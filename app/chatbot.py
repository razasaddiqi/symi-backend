import openai
import os
import json
import logging
import asyncio
from dotenv import load_dotenv
from datetime import datetime, timedelta
from app.database import get_db_connection_context, get_db_connection, return_db_connection
import threading
from concurrent.futures import ThreadPoolExecutor
import queue

# Set up logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Load environment variables
load_dotenv()
openai_api_key = os.getenv("OPENAI_API_KEY")

# Initialize OpenAI client
client = openai.OpenAI(api_key=openai_api_key)

# Thread pool for concurrent database operations
_db_thread_pool = ThreadPoolExecutor(max_workers=10, thread_name_prefix="db_worker")

# Session cache to reduce database hits
_session_cache = {}
_cache_lock = threading.Lock()

def is_session_expired(user_id, timeout_minutes=15):
    """Check if the user's session has expired - optimized with caching"""
    current_time = datetime.utcnow()
    
    # Check cache first
    with _cache_lock:
        if user_id in _session_cache:
            last_active = _session_cache[user_id]
            if current_time - last_active <= timedelta(minutes=timeout_minutes):
                # Update cache and return False (not expired)
                _session_cache[user_id] = current_time
                return False
    
    # Not in cache or expired, check database
    try:
        with get_db_connection_context() as conn:
            with conn.cursor() as cursor:
                cursor.execute("SELECT last_active FROM session_tracker WHERE user_id = %s", (user_id,))
                row = cursor.fetchone()
                
                expired = False
                if row:
                    last_active = row[0]
                    expired = current_time - last_active > timedelta(minutes=timeout_minutes)
                    if expired:
                        cursor.execute("UPDATE session_tracker SET session_expired = TRUE WHERE user_id = %s", (user_id,))
                    cursor.execute("UPDATE session_tracker SET last_active = %s WHERE user_id = %s", (current_time, user_id))
                else:
                    cursor.execute("INSERT INTO session_tracker (user_id, last_active) VALUES (%s, %s)", (user_id, current_time))
                
                conn.commit()
                
                # Update cache
                with _cache_lock:
                    _session_cache[user_id] = current_time
                
                return expired
                
    except Exception as e:
        logger.error(f"Error checking session: {e}")
        return False

def get_chat_history(user_id, limit=20):
    """Retrieve the last few chat messages for the user - thread-safe"""
    try:
        with get_db_connection_context() as conn:
            with conn.cursor() as cursor:
                cursor.execute(
                    "SELECT message, response FROM chat_history WHERE user_id = %s ORDER BY timestamp DESC LIMIT %s",
                    (str(user_id), limit)
                )
                chats = cursor.fetchall()
                
                return [{"role": "user", "content": chat[0]} if i % 2 == 0 else {"role": "assistant", "content": chat[1]} for i, chat in enumerate(chats[::-1])]
    except Exception as e:
        logger.error(f"Error getting chat history for user {user_id}: {e}")
        return []

def get_current_model():
    """Fetch the chatbot model selected by admin - cached"""
    # Simple caching for model selection
    if not hasattr(get_current_model, '_cached_model'):
        get_current_model._cached_model = None
        get_current_model._cache_time = 0
    
    current_time = datetime.now().timestamp()
    
    # Cache model for 5 minutes
    if get_current_model._cached_model is None or (current_time - get_current_model._cache_time) > 300:
        try:
            with get_db_connection_context() as conn:
                with conn.cursor() as cursor:
                    cursor.execute("SELECT model_name FROM chatbot_settings WHERE id = 1")
                    model = cursor.fetchone()
                    
                    get_current_model._cached_model = model[0] if model else "gpt-4o"
                    get_current_model._cache_time = current_time
        except Exception as e:
            logger.error(f"Error getting current model: {e}")
            return "gpt-4o"
    
    return get_current_model._cached_model

def get_answered_question_keys(user_id):
    """Get the list of already answered question keys"""
    try:
        with get_db_connection_context() as conn:
            with conn.cursor() as cursor:
                cursor.execute("SELECT question_key FROM audit_progress WHERE user_id = %s", (user_id,))
                keys = [row[0] for row in cursor.fetchall()]
                return keys
    except Exception as e:
        logger.error(f"Error getting answered questions for user {user_id}: {e}")
        return []

def get_user_profession(user_id):
    """Get the user's selected profession and its associated prompt - optimized"""
    
    try:
        with get_db_connection_context() as conn:
            with conn.cursor() as cursor:
                # Get the user's profession (should be set during signup)
                cursor.execute("""
                    SELECT up.profession_id, p.name, pp.system_prompt
                    FROM user_profession up
                    JOIN professions p ON up.profession_id = p.id
                    LEFT JOIN profession_prompts pp ON pp.profession_id = up.profession_id
                    WHERE up.user_id = %s
                """, (user_id,))
                
                result = cursor.fetchone()
                
                if result[2] is None:
                    return {
                        "profession_id": result[0],
                        "profession_name": result[1],
                        "system_prompt": None
                    }
                
                return {
                    "profession_id": result[0],
                    "profession_name": result[1],
                    "system_prompt": result[2]
                }
    except Exception as e:
        logger.error(f"Error getting user profession: {e}")
        return None

def has_completed_all_questions(user_id, profession):
    """Check if the user has answered all questions for their profession"""
    answered_keys = get_answered_question_keys(user_id)
    completion_threshold = 15
    return len(answered_keys) >= completion_threshold

default_system_prompt = """
You are a highly professional and friendly AI business consultant, specialized in conducting detailed, AI-powered business audits for transformation and optimization.

Your primary objective is to ask and collect **very specific business data** from the business owner by any mean, even if it requires:
- Repeating or rephrasing the question
- Clarifying vague or incomplete responses
- Redirecting irrelevant conversation

DO NOT move to the next question until the current one is properly answered.

If the answer is missing, too vague, or off-topic:
- Politely ask again or clarify what's needed
- Gently explain why this data is essential to continue the audit
- Example: "Thanks for that. To proceed effectively, I need a precise number or range for your average monthly revenue. Could you estimate it for me?"

If the user shares unrelated info:
- Say: "Thanks for sharing. Just to keep us focused on completing your personalized audit, could you please answer the question about [XYZ]?"

If the user says "I don't have" or "I didn't have":
- Accept that response, mark the question as complete, and move on.

If the user gives no answer at all:
- Add "None" as the answer and mark the question as complete.

Ask each of the following sections one by one, capturing **ALL information completely**:

1. **Business Basics**
   - What is the name of your business?
   - Where is it located (city, country)?
   - How long have you been in business?
   - How many staff members do you currently have?

2. **Revenue & Operational Metrics**
   - What is your average monthly revenue? 
   - Who is your target audience?
   - What is your Customer Acquisition Cost?
   - What are your biggest operational costs?

3. **Operational Challenges**
   - What are your main daily operations?
   - What processes take up most of your time?
   - What are the biggest operational bottlenecks you face?
   - How do you currently handle customer communications?

4. **Customer Behavior & Loyalty**
   - Do you segment your customers? If yes, how?
   - What is your customer retention rate?
   - Do you have any loyalty program?
   - How do you gather customer feedback?

5. **Competitor & Market Awareness**
   - Who are your top 3 competitors?
   - What makes your business different or better?
   - Do you consider your pricing premium, average, or budget?
   - What market trends are affecting your business?

6. **Tech & Automation**
   - What software or tools do you currently use in your business?
   - Are these systems integrated? Any pain points?
   - What processes do you wish were more automated?
   - Are you open to using AI/automation to improve operations?

After all questions are fully answered:
- Summarize the data back briefly
- Thank the user warmly for their time
- Let them know they can generate a detailed business transformation report by clicking the "Generate Report" button or by asking for a report
- Offer a final message: "Your data has been successfully collected. Based on your responses, a custom AI-powered business audit can now be generated to unlock your growth potential. Thank you for trusting me with your vision!"

Be persistent but polite, focused but friendly. Ensure you leave **no question unanswered** before ending the conversation."""

def format_system_prompt(user_profession, answered_keys, is_expired=False):
    """Format the system prompt based on the user's profession and already answered questions."""
    
    if not user_profession or not user_profession["system_prompt"]:
        system_prompt = default_system_prompt
    else:
        system_prompt = user_profession["system_prompt"]

    prefix = ""
    if is_expired:
        prefix = f"""
        Previous session expired due to inactivity.
        Please continue from where you left off.
        Already answered: {', '.join(answered_keys) if answered_keys else 'None'}.
        """
    else:
        profession_name = user_profession["profession_name"] if user_profession else "businesses"
        prefix = f"""
        You are an AI business consultant for {profession_name}.
        Already answered: {', '.join(answered_keys) if answered_keys else 'None'}.
        """
    
    return prefix + system_prompt

def get_openai_response_sync(user_id, user_message):
    """Synchronous version of OpenAI response for thread pool execution"""
    model_name = get_current_model()
    chat_history = get_chat_history(user_id)
    answered_keys = get_answered_question_keys(user_id)
    user_profession = get_user_profession(user_id)
    expired = is_session_expired(user_id)
    system_content = format_system_prompt(user_profession, answered_keys, expired)
    completed = has_completed_all_questions(user_id, user_profession)
    report_request = "report" in user_message.lower() or "generate" in user_message.lower()
    
    if completed and report_request:
        report_url = f"/reports/generate?token=<YOUR_TOKEN>"
        return f"""Great! You've completed all the necessary questions for your business audit. I can now generate your comprehensive Business Transformation Blueprint™ report.

To download your personalized report, please use this link:

[Download Your Business Transformation Blueprint™](/reports/generate)

Your report will include:
• Detailed business intelligence overview
• Revenue and operational metrics analysis
• Operational challenges and AI-powered solutions
• Market and competitive positioning strategy
• Technology and automation potential assessment
• 90-day transformation plan

The report will be tailored specifically to your {user_profession['profession_name'] if user_profession else 'business'} based on all the information you've shared. It will provide actionable insights and a clear roadmap for implementing AI-powered systems to transform your business.

Is there anything specific you'd like to see emphasized in your report?"""
    
    messages = [{"role": "system", "content": system_content}] + chat_history + [{"role": "user", "content": user_message}]

    try:
        response = client.chat.completions.create(
            model=model_name,
            messages=messages,
            timeout=30  # Add timeout for better error handling
        )

        bot_content = response.choices[0].message.content
        
        if completed and not report_request and "report" not in bot_content.lower():
            bot_content += """

You've provided all the key information needed for your business audit. Would you like me to generate your Business Transformation Blueprint™ report now? This detailed report will provide actionable insights and a transformation roadmap tailored to your business."""
        
        return bot_content
        
    except Exception as e:
        logger.error(f"Error getting OpenAI response: {e}")
        return f"I'm experiencing a temporary issue. Please try again in a moment. Error: {str(e)}"

async def get_openai_response(user_id, user_message):
    """Async wrapper for OpenAI response using thread pool"""
    loop = asyncio.get_event_loop()
    try:
        # Execute the synchronous function in a thread pool
        response = await loop.run_in_executor(_db_thread_pool, get_openai_response_sync, user_id, user_message)
        return response
    except Exception as e:
        logger.error(f"Error in async OpenAI response: {e}")
        return f"I'm experiencing a temporary issue. Please try again in a moment."

async def stream_chat_sync(user_id, user_message):
    """Synchronous streaming chat for thread pool execution"""
    model_name = get_current_model()
    chat_history = get_chat_history(user_id)
    answered_keys = get_answered_question_keys(user_id)
    
    user_profession = get_user_profession(user_id)
    expired = is_session_expired(user_id)
    system_content = format_system_prompt(user_profession, answered_keys, expired)
    completed = has_completed_all_questions(user_id, user_profession)
    report_request = "report" in user_message.lower() or "generate" in user_message.lower()
    
    if completed and report_request:
        report_message = f"""Great! You've completed all the necessary questions for your business audit. I can now generate your comprehensive Business Transformation Blueprint™ report.

To download your personalized report, please use this link:

[Download Your Business Transformation Blueprint™](/reports/generate)

Your report will include:
• Detailed business intelligence overview
• Revenue and operational metrics analysis
• Operational challenges and AI-powered solutions
• Market and competitive positioning strategy
• Technology and automation potential assessment
• 90-day transformation plan

The report will be tailored specifically to your {user_profession['profession_name'] if user_profession else 'business'} based on all the information you've shared. It will provide actionable insights and a clear roadmap for implementing AI-powered systems to transform your business.

Is there anything specific you'd like to see emphasized in your report?"""
        
        # Save the complete message to chat history
        save_chat_sync(user_id, user_message, report_message)
        
        # Return the complete message
        return report_message
    
    messages = [{"role": "system", "content": system_content}] + chat_history + [{"role": "user", "content": user_message}]

    full_response = ""
    
    try:
        # Create a streaming completion
        stream = client.chat.completions.create(
            model=model_name,
            messages=messages,
            stream=True,
            timeout=60
        )
        
        # Collect the full response
        for chunk in stream:
            if chunk.choices[0].delta.content is not None:
                content = chunk.choices[0].delta.content
                full_response += content
    
    except Exception as e:
        logger.error(f"Error in streaming response: {str(e)}")
        error_message = f"Sorry, I encountered an error: {str(e)}"
        full_response = error_message
    
    # Add report reminder if needed
    if completed and not report_request and "report" not in full_response.lower():
        report_reminder = """

You've provided all the key information needed for your business audit. Would you like me to generate your Business Transformation Blueprint™ report now? This detailed report will provide actionable insights and a transformation roadmap tailored to your business."""
        
        full_response += report_reminder
    
    # Save the complete chat to history
    save_chat_sync(user_id, user_message, full_response)
    
    return full_response

async def stream_chat(user_id, user_message):
    """Stream response from OpenAI API and save the final complete response - async version"""
    loop = asyncio.get_event_loop()
    try:
        # Execute the synchronous streaming function in a thread pool
        response = await loop.run_in_executor(_db_thread_pool, stream_chat_sync, user_id, user_message)
        
        # Yield the response in chunks for streaming effect
        words = response.split(' ')
        current_chunk = ""
        
        for word in words:
            current_chunk += word + " "
            if len(current_chunk) > 50:  # Send chunks of ~50 characters
                yield current_chunk
                current_chunk = ""
                await asyncio.sleep(0.05)  # Small delay for streaming effect
        
        if current_chunk:  # Send remaining content
            yield current_chunk
            
    except Exception as e:
        logger.error(f"Error in async streaming chat: {e}")
        yield f"Sorry, I encountered an error: {str(e)}"

def save_chat_sync(user_id, message, response):
    """Save chat history to database - synchronous version"""
    try:
        with get_db_connection_context() as conn:
            with conn.cursor() as cursor:
                cursor.execute(
                    "INSERT INTO chat_history (user_id, message, response) VALUES (%s, %s, %s)",
                    (user_id, message, response)
                )
                conn.commit()
    except Exception as e:
        logger.error(f"Error saving chat: {e}")

async def save_chat(user_id, message, response):
    """Save chat history to database - async version"""
    loop = asyncio.get_event_loop()
    await loop.run_in_executor(_db_thread_pool, save_chat_sync, user_id, message, response)

def process_chat_sync(user_id, user_message):
    """Handles chat interaction synchronously"""
    
    bot_response = get_openai_response_sync(user_id, user_message)
    save_chat_sync(user_id, user_message, bot_response)
    return bot_response

async def process_chat(user_id, user_message):
    """Handles chat interaction asynchronously"""
    
    bot_response = await get_openai_response(user_id, user_message)
    await save_chat(user_id, user_message, bot_response)
    return bot_response

# Keep the original synchronous function for backward compatibility
def process_chat_original(user_id, user_message):
    """Original synchronous chat processing for backward compatibility"""
    return process_chat_sync(user_id, user_message)

# Clear cache periodically to prevent memory leaks
def clear_session_cache():
    """Clear old entries from session cache"""
    with _cache_lock:
        current_time = datetime.utcnow()
        expired_keys = []
        
        for user_id, last_active in _session_cache.items():
            if current_time - last_active > timedelta(hours=1):  
                expired_keys.append(user_id)
        
        for key in expired_keys:
            del _session_cache[key]

# Background task to clear cache periodically
async def cache_cleanup_task():
    """Background task to clean up caches"""
    while True:
        try:
            await asyncio.sleep(1800)  # Run every 30 minutes
            clear_session_cache()
            
            # Clear model cache if it's too old
            if hasattr(get_current_model, '_cache_time'):
                current_time = datetime.now().timestamp()
                if (current_time - get_current_model._cache_time) > 3600:  
                    get_current_model._cached_model = None
                    
        except Exception as e:
            logger.error(f"Error in cache cleanup task: {e}")

# Alias for backward compatibility
def get_openai_response_original(user_id, user_message):
    """Original function name for backward compatibility"""
    return get_openai_response_sync(user_id, user_message)
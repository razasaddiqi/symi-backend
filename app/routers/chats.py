from fastapi import APIRouter, HTTPException
from app.auth import decode_access_token
from app.chatbot import get_chat_history, process_chat, get_user_profession
from app.database import get_db_connection_context
from pydantic import BaseModel
from typing import Optional
import logging
import asyncio
from concurrent.futures import ThreadPoolExecutor

# Set up logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

router = APIRouter(tags=["Chats"])

# Thread pool for database operations
chat_executor = ThreadPoolExecutor(max_workers=15, thread_name_prefix="chat_worker")

class ChatRequest(BaseModel):
    user_message: str
    profession_id: Optional[int] = None

async def check_user_status_async(user_id):
    """Check user status asynchronously"""
    loop = asyncio.get_event_loop()
    
    def check_user_status():
        try:
            with get_db_connection_context() as conn:
                with conn.cursor() as cursor:
                    # Fetch user status
                    cursor.execute("SELECT status FROM users WHERE id = %s", (user_id,))
                    status_result = cursor.fetchone()
                    
                    if not status_result:
                        return {"error": "User not found", "status_code": 404}
                    
                    if status_result[0] == "suspended":
                        return {"error": "Your account is suspended. Contact admin.", "status_code": 403}
                    
                    # Verify the current profession set for the user
                    cursor.execute("""
                        SELECT up.profession_id, p.name 
                        FROM user_profession up
                        JOIN professions p ON up.profession_id = p.id
                        WHERE up.user_id = %s
                    """, (user_id,))
                    
                    current_profession = cursor.fetchone()
                    
                    if not current_profession:
                        return {
                            "error": "No profession is set for your account. This is unusual and might be a system error since profession should be selected during signup.",
                            "status_code": 400
                        }
                    
                    return {
                        "status": "active",
                        "profession_id": current_profession[0],
                        "profession_name": current_profession[1]
                    }
                    
        except Exception as e:
            logger.error(f"Error checking user status: {e}")
            return {"error": f"Database error: {str(e)}", "status_code": 500}
    
    return await loop.run_in_executor(chat_executor, check_user_status)

async def get_chat_history_async(user_id):
    """Get chat history asynchronously"""
    loop = asyncio.get_event_loop()
    return await loop.run_in_executor(chat_executor, get_chat_history, user_id)

async def get_user_profession_async(user_id):
    """Get user profession asynchronously"""
    loop = asyncio.get_event_loop()
    return await loop.run_in_executor(chat_executor, get_user_profession, user_id)

@router.post("/chat")
async def chat(chat_request: ChatRequest, token: str):
    """REST API endpoint for sending messages - optimized for concurrent users"""
    user = decode_access_token(token)
    if not user:
        raise HTTPException(status_code=401, detail="Unauthorized")

    user_id = user["user_id"]
    user_message = chat_request.user_message

    # Check user status asynchronously
    user_status = await check_user_status_async(user_id)
    
    if "error" in user_status:
        raise HTTPException(status_code=user_status["status_code"], detail=user_status["error"])
    
    # Handle initial greetings
    if user_message.lower() in ["hi", "hello", "hey", "start"]:
        prof_name = user_status["profession_name"]
        return {"response": f"Welcome! I'll be asking you specific questions about your {prof_name} business to help provide a customized audit. What's the name of your business?"}

    # Process the chat asynchronously
    try:
        bot_response = await process_chat(user_id, user_message)
        
        return {"response": bot_response}
        
    except Exception as e:
        logger.error(f"Error processing chat for user {user_id}: {e}")
@router.get("/history")
async def get_chat_history_api(token: str):
    """Retrieve chat history asynchronously"""
    user = decode_access_token(token)
    if not user:
        raise HTTPException(status_code=401, detail="Unauthorized")

    try:
        chat_history = await get_chat_history_async(user["user_id"])
        return chat_history
    except Exception as e:
        logger.error(f"Error getting chat history for user {user['user_id']}: {e}")
        raise HTTPException(status_code=500, detail="Error retrieving chat history")

@router.get("/status")
async def get_chat_status(token: str):
    """Get current chat/audit status for the user"""
    user = decode_access_token(token)
    if not user:
        raise HTTPException(status_code=401, detail="Unauthorized")

    user_id = user["user_id"]
    
    try:
        # Get user profession and completion status asynchronously
        loop = asyncio.get_event_loop()
        
        async def get_status():
            user_profession = await loop.run_in_executor(chat_executor, get_user_profession, user_id)
            
            # Import here to avoid circular imports
            from app.chatbot import has_completed_all_questions, get_answered_question_keys
            
            is_complete = await loop.run_in_executor(chat_executor, has_completed_all_questions, user_id, user_profession)
            answered_keys = await loop.run_in_executor(chat_executor, get_answered_question_keys, user_id)
            
            return {
                "user_id": user_id,
                "profession": user_profession["profession_name"] if user_profession else None,
                "audit_complete": is_complete,
                "questions_answered": len(answered_keys),
                "can_generate_report": is_complete
            }
        
        status = await get_status()
        return status
        
    except Exception as e:
        logger.error(f"Error getting chat status for user {user_id}: {e}")
        raise HTTPException(status_code=500, detail="Error getting chat status")

@router.get("/metrics")
async def get_chat_metrics():
    """Get chat service metrics"""
    try:
        return {
            "thread_pool_size": chat_executor._max_workers,
            "active_threads": chat_executor._threads,
            "pending_tasks": chat_executor._work_queue.qsize(),
            "timestamp": __import__("datetime").datetime.now().isoformat()
        }
    except Exception as e:
        logger.error(f"Error getting chat metrics: {e}")
        return {"error": str(e)}
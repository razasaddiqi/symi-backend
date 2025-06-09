from fastapi import APIRouter, HTTPException
from pydantic import BaseModel, EmailStr
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
import os
from dotenv import load_dotenv
import logging
from datetime import datetime

# Set up logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Load environment variables
load_dotenv()

router = APIRouter(tags=["Lab Signup"])

class LabSignupRequest(BaseModel):
    email: EmailStr
    name: str = None
    message: str = None

class LabSignupResponse(BaseModel):
    message: str
    success: bool

def send_email_notification(subject: str, body: str, recipient_email: str = None, sender_name: str = "SYMI"):
    """Generic email sending function"""
    try:
        # Email configuration from environment variables
        smtp_server = os.getenv("SMTP_SERVER")
        smtp_port = int(os.getenv("SMTP_PORT"))
        sender_email = os.getenv("SENDER_EMAIL")
        sender_password = os.getenv("SENDER_PASSWORD") # this is a app password not a regular password
        
        if not sender_email or not sender_password:
            logger.error("Email credentials not configured")
            return False
        
        # Use provided recipient or default admin email
        if not recipient_email:
            recipient_email = os.getenv("LAB_SIGNUP_EMAIL", sender_email)
        
        # Create message
        msg = MIMEMultipart()
        msg['From'] = f"{sender_name} <{sender_email}>"
        msg['To'] = recipient_email
        msg['Subject'] = subject
        
        msg.attach(MIMEText(body, 'plain'))
        
        # Send email
        server = smtplib.SMTP(smtp_server, smtp_port)
        server.starttls()
        server.login(sender_email, sender_password)
        text = msg.as_string()
        server.sendmail(sender_email, recipient_email, text)
        server.quit()
        
        logger.info(f"Email sent successfully to: {recipient_email}")
        return True
        
    except Exception as e:
        logger.error(f"Failed to send email: {str(e)}")
        return False

def send_lab_signup_email(email: str, name: str = None, user_message: str = None):
    """Send email notification about lab signup"""
    subject = "New SYMI Lab Collaboration Interest"
    
    body = f"""
New Lab Collaboration Request

Email: {email}
Name: {name or 'Not provided'}

Message:
{user_message or 'No additional message provided'}

---
Received via SYMI Lab signup form
Time: {datetime.now().strftime('%Y-%m-%d %H:%M:%S UTC')}
    """
    
    admin_email = os.getenv("LAB_SIGNUP_EMAIL", os.getenv("SENDER_EMAIL"))
    return send_email_notification(subject, body, admin_email)

def send_confirmation_email(email: str, name: str = None):
    """Send confirmation email to the person who signed up"""
    subject = "✧ Welcome to SYMI Lab Collaboration Interest"
    
    body = f"""
Hello {name or 'there'},

Thank you for your signal.

SYMI Lab explores the frontier of autonomous systems, recursive tools, and creative infrastructure.
We review all collaboration intents with care — if resonance aligns, we'll reach out.

In the meantime, you're free to explore: https://symi.io

— The SYMI Lab Team  
This is an automated message. No reply needed.
    """
    
    return send_email_notification(subject, body, email, "SYMI Lab")

from datetime import datetime
import os

def send_purchase_notification_email(user_email: str, plan_name: str, plan_price: float, currency: str, user_name: str = None):
    """Send email notification to admin when user purchases a plan"""
    subject = f"New SYMI Purchase: {plan_name} - {user_email}"
    
    body = f"""
🛎️ New Purchase Notification

Customer:
- Name: {user_name or 'Not provided'}
- Email: {user_email}

Order Details:
- Plan: {plan_name}
- Amount: {plan_price} {currency.upper()}
- Time: {datetime.utcnow().strftime('%B %d, %Y at %H:%M UTC')}

The customer now has access to premium SYMI services.

—
Automated alert from SYMI Payment System
    """
    
    admin_email = os.getenv("LAB_SIGNUP_EMAIL", os.getenv("SENDER_EMAIL"))
    return send_email_notification(subject, body, admin_email, "SYMI Payment System")

from datetime import datetime

def send_purchase_confirmation_email(user_email: str, plan_name: str, plan_price: float, currency: str, user_name: str = None):
    """Send confirmation email to user after successful purchase"""
    subject = "✓ SYMI Order Confirmed"
    
    body = f"""
Hello {user_name or 'there'},

Thanks for your purchase. Your system is now being prepared.

Purchase Details:
- Plan: {plan_name}
- Amount: {plan_price} {currency.upper()}
- Purchase Date: {datetime.utcnow().strftime('%B %d, %Y at %H:%M UTC')}

You'll receive everything within the next few days, depending on the type of build.
If anything is needed from your side, we'll reach out directly.

You're now part of a different kind of infrastructure — modular, sovereign, and built to scale.

→ For any questions: contact@symi.io

— The SYMI Lab Team  
Build different. Own your flow
    """
    
    return send_email_notification(subject, body, user_email, "SYMI")

@router.post("/join-lab", response_model=LabSignupResponse)
def join_lab_signup(signup_data: LabSignupRequest):
    """Collect email signups for SYMI Lab collaboration interest and send email notifications"""
    try:
        # Send notification email to admin/lab team
        admin_email_sent = send_lab_signup_email(
            email=signup_data.email,
            name=signup_data.name,
            user_message=signup_data.message
        )
        
        # Send confirmation email to user
        confirmation_sent = send_confirmation_email(
            email=signup_data.email,
            name=signup_data.name
        )
        
        if admin_email_sent:
            logger.info(f"New lab signup processed: {signup_data.email}")
            return {
                "message": "Thank you for your interest in joining SYMI Lab! We've received your information and will be in touch soon with collaboration opportunities.",
                "success": True
            }
        else:
            logger.error(f"Failed to process lab signup for: {signup_data.email}")
            return {
                "message": "There was an issue processing your request. Please try again or contact us directly.",
                "success": False
            }
        
    except Exception as e:
        logger.error(f"Error processing lab signup: {str(e)}")
        raise HTTPException(status_code=500, detail="Error processing your signup. Please try again.")

# Export the email functions so they can be used by other modules
__all__ = ['send_purchase_notification_email', 'send_purchase_confirmation_email', 'send_email_notification']
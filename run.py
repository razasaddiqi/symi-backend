import os
import multiprocessing
import logging
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

# Set up logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)

def calculate_optimal_workers():
    """Calculate optimal number of workers based on system resources"""
    try:
        import psutil
        
        cpu_count = multiprocessing.cpu_count()
        memory_gb = psutil.virtual_memory().total / (1024**3)
        base_workers = cpu_count * 2 + 1
        memory_limited_workers = int(memory_gb * 1024 * 0.7 / 250) 
        optimal_workers = min(base_workers, memory_limited_workers, 16)  
        
        return max(optimal_workers, 2)
        
    except Exception as e:
        logger.error(f"Error calculating workers: {e}")
        return 4

def get_hardware_info():
    """Get system hardware information"""
    try:
        import psutil
        
        cpu_count = multiprocessing.cpu_count()
        memory = psutil.virtual_memory()
        disk = psutil.disk_usage('/')
        
        return {
            "cpu_cores": cpu_count,
            "memory_total_gb": memory.total / (1024**3),
            "memory_available_gb": memory.available / (1024**3),
            "disk_total_gb": disk.total / (1024**3),
            "disk_free_gb": disk.free / (1024**3)
        }
    except Exception as e:
        logger.error(f"Error getting hardware info: {e}")
        return {}

def main():
    # Get hardware information
    hw_info = get_hardware_info()
    
    # Configuration
    workers = os.getenv("WORKERS", "auto")
    
    if workers == "auto":
        workers = calculate_optimal_workers()
    else:
        workers = int(workers)
    
    # Get other configuration
    host = os.getenv("HOST", "0.0.0.0")
    port = int(os.getenv("PORT", "8800"))
    ssl_keyfile = os.getenv("SSL_KEYFILE", "key.pem")
    ssl_certfile = os.getenv("SSL_CERTFILE", "cert.pem")
    
    # Check SSL
    use_ssl = os.path.exists(ssl_keyfile) and os.path.exists(ssl_certfile)
    
    # Database configuration
    db_min_conn = int(os.getenv("DB_MIN_CONNECTIONS", "5"))
    db_max_conn = int(os.getenv("DB_MAX_CONNECTIONS", "50"))
    
    # Memory estimation
    estimated_memory = workers * 250  # MB per worker
    if hw_info:
        memory_percent = (estimated_memory / (hw_info.get('memory_total_gb', 1) * 1024)) * 100
        
        if memory_percent > 80:
            logger.warning(f"High memory usage expected! Consider reducing workers.")
    
    # Validate environment
    required_vars = ["OPENAI_API_KEY", "SECRET_KEY"]
    missing_vars = [var for var in required_vars if not os.getenv(var)]
    
    if missing_vars:
        logger.error(f"Missing required environment variables: {', '.join(missing_vars)}")
        logger.error("Please check your .env file")
        return 1
    
    # Set environment variables for the main app
    os.environ["WORKERS"] = str(workers)
    os.environ["HOST"] = host
    os.environ["PORT"] = str(port)
    
    # Import and run the main app
    try:
        from app.main import app
        import uvicorn
        
        # Configure uvicorn for multiprocessing
        config = {
            "app": "app.main:app",
            "host": host,
            "port": port,
            "workers": workers,
            "reload": False,
            "log_level": "info",
            "access_log": True,
            "server_header": False,
            "date_header": False,
            # Performance optimizations
            "loop": "auto",
            "http": "auto",
            "ws_ping_interval": 20,
            "ws_ping_timeout": 20,
            "ws_per_message_deflate": True,
            "lifespan": "on",
            "timeout_keep_alive": 5,
            "limit_concurrency": 1000,
            "limit_max_requests": 1000,
            "backlog": 2048
        }
        
        # Add SSL if available
        if use_ssl:
            config["ssl_keyfile"] = ssl_keyfile
            config["ssl_certfile"] = ssl_certfile
        
        # Start the server
        uvicorn.run(**config)
        
    except KeyboardInterrupt:
        logger.info("Received shutdown signal")
    except Exception as e:
        logger.error(f"Error starting server: {e}")
        return 1
    finally:
        logger.info("Server shutdown complete")
    
    return 0

if __name__ == "__main__":
    exit(main())
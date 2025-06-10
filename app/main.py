import asyncio
import multiprocessing
import signal
import atexit
import logging
import os
import uvicorn
from contextlib import asynccontextmanager
from fastapi import FastAPI
from starlette.middleware.sessions import SessionMiddleware
# from app.models import create_tables
from app.routers import google_auth, pricing, profession_prompts, professions, reports, user_profession, users, chats, websocket, admin, payment, lab_signup
from app.database import cleanup_connection_pool, check_database_health, get_pool_stats
from fastapi.middleware.cors import CORSMiddleware
from dotenv import load_dotenv

load_dotenv()

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - [PID:%(process)d] - %(message)s'
)
logger = logging.getLogger(__name__)

shutdown_event = asyncio.Event()

@asynccontextmanager
async def lifespan(app: FastAPI):
    
    try:
        logger.info("Database initialization completed")
    except Exception as e:
        logger.error(f"Database initialization failed: {e}")
    
    health = check_database_health()
    
    async def periodic_health_check():
        while not shutdown_event.is_set():
            try:
                await asyncio.sleep(int(os.getenv("HEALTH_CHECK_INTERVAL", "300")))
                health = check_database_health()
                pool_stats = get_pool_stats()
                
                if health['status'] == 'unhealthy':
                    logger.warning(f"Database health check failed: {health}")
                else:
                    logger.info(f"Health check OK - Pool stats: {pool_stats}")
                    
            except asyncio.CancelledError:
                break
            except Exception as e:
                logger.error(f"Error in periodic health check: {e}")
    
    monitoring_task = asyncio.create_task(periodic_health_check())
    
    yield
    
    logger.info(f"Shutting down application process with PID: {os.getpid()}")
    
    shutdown_event.set()
    
    monitoring_task.cancel()
    try:
        await monitoring_task
    except asyncio.CancelledError:
        pass
    
    cleanup_connection_pool()
    logger.info("Application shutdown completed")

app = FastAPI(
    title=os.getenv("APP_TITLE", "SYMI Chatbot API"),
    description=os.getenv("APP_DESCRIPTION", "AI-powered business transformation chatbot with multiprocessing support"),
    version=os.getenv("APP_VERSION", "2.0.0"),
    lifespan=lifespan
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=os.getenv("CORS_ORIGINS", "*").split(","),
    allow_credentials=os.getenv("CORS_ALLOW_CREDENTIALS", "true").lower() == "true",
    allow_methods=os.getenv("CORS_ALLOW_METHODS", "*").split(","),
    allow_headers=os.getenv("CORS_ALLOW_HEADERS", "*").split(","),
)

SECRET_KEY = os.getenv("SECRET_KEY")
app.add_middleware(SessionMiddleware, secret_key=SECRET_KEY)

os.makedirs(os.path.join('app', 'static'), exist_ok=True)

app.include_router(users.router, prefix="/users")
app.include_router(chats.router, prefix="/chats")
app.include_router(websocket.router)
app.include_router(admin.router, prefix="/admin")  
app.include_router(payment.router, prefix="/payment")
app.include_router(pricing.router, prefix="/pricing")
app.include_router(professions.router, prefix="/professions")
app.include_router(user_profession.router, prefix="/user-profession")
app.include_router(profession_prompts.router, prefix="/profession-prompts")
app.include_router(reports.router, prefix="/reports")
app.include_router(google_auth.router, prefix="/auth")
app.include_router(lab_signup.router, prefix="/lab")

@app.get("/health")
async def health_check():
    try:
        db_health = check_database_health()
        pool_stats = get_pool_stats()
        
        return {
            "status": "healthy" if db_health["status"] == "healthy" else "degraded",
            "pid": os.getpid(),
            "database": db_health,
            "connection_pool": pool_stats,
            "timestamp": __import__("datetime").datetime.now().isoformat()
        }
    except Exception as e:
        logger.error(f"Health check failed: {e}")
        return {
            "status": "unhealthy",
            "pid": os.getpid(),
            "error": str(e),
            "timestamp": __import__("datetime").datetime.now().isoformat()
        }

@app.get("/metrics")
async def metrics():
    try:
        import psutil
        process = psutil.Process(os.getpid())
        
        memory_info = process.memory_info()
        cpu_percent = process.cpu_percent()
        
        system_memory = psutil.virtual_memory()
        system_cpu = psutil.cpu_percent(interval=1)
        
        pool_stats = get_pool_stats()
        
        return {
            "pid": os.getpid(),
            "process_metrics": {
                "memory_mb": memory_info.rss / 1024 / 1024,
                "cpu_percent": cpu_percent,
                "threads": process.num_threads(),
                "connections": process.num_fds() if hasattr(process, 'num_fds') else None
            },
            "system_metrics": {
                "memory_percent": system_memory.percent,
                "cpu_percent": system_cpu,
                "available_memory_gb": system_memory.available / 1024 / 1024 / 1024
            },
            "database_pool": pool_stats,
            "timestamp": __import__("datetime").datetime.now().isoformat()
        }
    except Exception as e:
        logger.error(f"Metrics endpoint failed: {e}")
        return {"error": str(e), "pid": os.getpid()}

@app.get("/")
def root():
    return {
        "message": "Chatbot API is running with multiprocessing support",
        "pid": os.getpid(),
        "version": os.getenv("APP_VERSION", "2.0.0")
    }

def signal_handler(signum, frame):
    shutdown_event.set()
    cleanup_connection_pool()

signal.signal(signal.SIGTERM, signal_handler)
signal.signal(signal.SIGINT, signal_handler)

atexit.register(cleanup_connection_pool)

def calculate_optimal_workers():
    try:
        import psutil
        
        cpu_count = multiprocessing.cpu_count()
        memory_gb = psutil.virtual_memory().total / (1024**3)
        
        base_workers = cpu_count * 2 + 1
        
        memory_limited_workers = int(memory_gb * 1024 * 0.7 / 250)
        
        optimal_workers = min(base_workers, memory_limited_workers, int(os.getenv("MAX_WORKERS", "16")))
        
        return max(optimal_workers, int(os.getenv("MIN_WORKERS", "2")))
        
    except Exception as e:
        logger.error(f"Error calculating workers: {e}")
        return int(os.getenv("DEFAULT_WORKERS", "4"))

if __name__ == "__main__":
    workers_env = os.getenv("WORKERS", "0")
    
    if workers_env == "auto" or workers_env == "0":
        workers = calculate_optimal_workers()
    else:
        workers = int(workers_env)
    
    host = os.getenv("HOST", "0.0.0.0")
    port = int(os.getenv("PORT", "8800"))
    
    ssl_keyfile = os.getenv("SSL_KEYFILE")
    ssl_certfile = os.getenv("SSL_CERTFILE")
    
    use_ssl = ssl_keyfile and ssl_certfile and os.path.exists(ssl_keyfile) and os.path.exists(ssl_certfile)
    
    logger.info(f"Starting SYMI Chatbot API:")
    logger.info(f"  Workers: {workers}")
    logger.info(f"  Host: {host}")
    logger.info(f"  Port: {port}")
    logger.info(f"  SSL: {'Enabled' if use_ssl else 'Disabled'}")
    logger.info(f"  Database pool: {os.getenv('DB_MIN_CONNECTIONS', '5')}-{os.getenv('DB_MAX_CONNECTIONS', '50')} connections")
    
    config = {
        "app": "app.main:app",
        "host": host,
        "port": port,
        "workers": workers,
        "reload": False,
        "log_level": os.getenv("LOG_LEVEL", "info").lower(),
        "access_log": os.getenv("ACCESS_LOG", "true").lower() == "true",
        "server_header": False,
        "date_header": False,
        "loop": "auto",
        "http": "auto",
        "ws_ping_interval": int(os.getenv("WS_PING_INTERVAL", "20")),
        "ws_ping_timeout": int(os.getenv("WS_PING_TIMEOUT", "20")),
        "ws_per_message_deflate": os.getenv("WS_PER_MESSAGE_DEFLATE", "true").lower() == "true",
        "lifespan": "on",
        "timeout_keep_alive": int(os.getenv("TIMEOUT_KEEP_ALIVE", "5")),
        "limit_concurrency": int(os.getenv("LIMIT_CONCURRENCY", "1000")),
        "limit_max_requests": int(os.getenv("LIMIT_MAX_REQUESTS", "1000")),
        "backlog": int(os.getenv("BACKLOG", "2048"))
    }
    
    if use_ssl:
        config["ssl_keyfile"] = ssl_keyfile
        config["ssl_certfile"] = ssl_certfile
    
    import platform
    if platform.system() == "Linux":
        try:
            import uvloop
            config["loop"] = "uvloop"
            logger.info("Using uvloop for better performance on Linux")
        except ImportError:
            logger.info("uvloop not available, using default asyncio loop")
    
    uvicorn.run(**config)
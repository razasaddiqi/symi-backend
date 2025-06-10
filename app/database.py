import psycopg2
import psycopg2.pool
import os
import threading
import logging
from dotenv import load_dotenv
from contextlib import contextmanager

load_dotenv()

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

DATABASE_URL = {
    "dbname": os.getenv("DB_NAME"),
    "user": os.getenv("DB_USER"),
    "password": os.getenv("DB_PASSWORD"),
    "host": os.getenv("DB_HOST"),
    "port": os.getenv("DB_PORT"),
}

MIN_CONNECTIONS = int(os.getenv("DB_MIN_CONNECTIONS", "5"))
MAX_CONNECTIONS = int(os.getenv("DB_MAX_CONNECTIONS", "50"))

_connection_pool = None
_pool_lock = threading.Lock()

def initialize_connection_pool():
    global _connection_pool
    
    if _connection_pool is None:
        with _pool_lock:
            if _connection_pool is None:
                try:
                    _connection_pool = psycopg2.pool.ThreadedConnectionPool(
                        MIN_CONNECTIONS,
                        MAX_CONNECTIONS,
                        **DATABASE_URL,
                        connect_timeout=int(os.getenv("DB_CONNECT_TIMEOUT", "10")),
                        application_name=os.getenv("DB_APPLICATION_NAME", "symi_chatbot_multiprocess"),
                        keepalives=int(os.getenv("DB_KEEPALIVES", "1")),
                        keepalives_idle=int(os.getenv("DB_KEEPALIVES_IDLE", "30")),
                        keepalives_interval=int(os.getenv("DB_KEEPALIVES_INTERVAL", "5")),
                        keepalives_count=int(os.getenv("DB_KEEPALIVES_COUNT", "5")),
                    )
                except Exception as e:
                    logger.error(f"Failed to create connection pool: {e}")
                    raise

def get_db_connection():
    global _connection_pool
    
    if _connection_pool is None:
        initialize_connection_pool()
    
    try:
        connection = _connection_pool.getconn()
        if connection:
            with connection.cursor() as cursor:
                cursor.execute("SELECT 1")
            return connection
        else:
            raise Exception("Unable to get connection from pool")
    except Exception as e:
        logger.error(f"Error getting database connection: {e}")
        try:
            return psycopg2.connect(**DATABASE_URL)
        except Exception as fallback_error:
            logger.error(f"Fallback connection also failed: {fallback_error}")
            raise

def return_db_connection(connection):
    global _connection_pool
    
    if _connection_pool and connection:
        try:
            _connection_pool.putconn(connection)
        except Exception as e:
            logger.error(f"Error returning connection to pool: {e}")
            try:
                connection.close()
            except:
                pass

@contextmanager
def get_db_connection_context():
    connection = None
    try:
        connection = get_db_connection()
        yield connection
    finally:
        if connection:
            return_db_connection(connection)

def get_pool_stats():
    global _connection_pool
    
    if _connection_pool:
        try:
            with _pool_lock:
                used_connections = len(_connection_pool._used) if hasattr(_connection_pool, '_used') else 0
                available_connections = len(_connection_pool._pool) if hasattr(_connection_pool, '_pool') else 0
                total_connections = used_connections + available_connections
                
                return {
                    "used": used_connections,
                    "available": available_connections,
                    "total": total_connections,
                    "max_connections": MAX_CONNECTIONS
                }
        except Exception as e:
            logger.error(f"Error getting pool stats: {e}")
            return {"error": str(e)}
    
    return {"status": "pool_not_initialized"}

def cleanup_connection_pool():
    global _connection_pool
    
    if _connection_pool:
        with _pool_lock:
            try:
                _connection_pool.closeall()
                _connection_pool = None
                logger.info("Connection pool cleaned up")
            except Exception as e:
                logger.error(f"Error cleaning up connection pool: {e}")

def check_database_health():
    try:
        with get_db_connection_context() as conn:
            with conn.cursor() as cursor:
                cursor.execute("SELECT 1")
                
                cursor.execute("""
                    SELECT count(*) as active_connections 
                    FROM pg_stat_activity 
                    WHERE state = 'active'
                """)
                active_connections = cursor.fetchone()[0]
                
                pool_stats = get_pool_stats()
                
                return {
                    "status": "healthy",
                    "active_db_connections": active_connections,
                    "pool_stats": pool_stats
                }
    except Exception as e:
        logger.error(f"Database health check failed: {e}")
        return {
            "status": "unhealthy",
            "error": str(e)
        }

try:
    initialize_connection_pool()
except Exception as e:
    logger.warning(f"Could not initialize connection pool on import: {e}")
    logger.info("Pool will be initialized on first connection request")
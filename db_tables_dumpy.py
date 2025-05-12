import subprocess
import os
# import psycopg2
# 
# ---- CONFIGURATION ----
PG_DUMP_PATH = r"C:\Program Files\PostgreSQL\17\bin\pg_dump.exe"
LOCAL_DB_NAME = 'chatbot_db'
LOCAL_DB_USER = 'postgres'
LOCAL_DB_PASSWORD = '123'
LOCAL_DB_HOST = 'localhost'
LOCAL_DB_PORT = '5432'

DUMP_FILE = 'db_dump.sql'

# ---- 1. DUMP LOCAL DATABASE ----
os.environ['PGPASSWORD'] = LOCAL_DB_PASSWORD
print("Dumping local database...")
dump_command = [
    PG_DUMP_PATH,
    '-h', LOCAL_DB_HOST,
    '-U', LOCAL_DB_USER,
    '-p', LOCAL_DB_PORT,
    '-d', LOCAL_DB_NAME,
    '-F', 'c',  # custom format for pg_restore
    '-f', DUMP_FILE
]
subprocess.run(dump_command, check=True)
print("Database dump completed.")

# ---- 2. RESTORE TO RDS ----
# RDS_DB_NAME = 'your_rds_db'
# RDS_DB_USER = 'your_rds_user'
# RDS_DB_PASSWORD = 'your_rds_password'
# RDS_DB_HOST = 'your-rds-endpoint.rds.amazonaws.com'
# RDS_DB_PORT = '5432'
# print("Restoring to RDS...")
# os.environ['PGPASSWORD'] = RDS_DB_PASSWORD
# restore_command = [
#     'pg_restore',
#     '-h', RDS_DB_HOST,
#     '-U', RDS_DB_USER,
#     '-p', RDS_DB_PORT,
#     '-d', RDS_DB_NAME,
#     '-c',  # clean (drop) database objects before recreating
#     DUMP_FILE
# ]
# subprocess.run(restore_command, check=True)
# print("Restore to RDS completed.")

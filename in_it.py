import subprocess
import os

# PostgreSQL configuration
pg_dump_path = r"C:\Program Files\PostgreSQL\17\bin\pg_dump.exe"  # Path to pg_dump.exe
host = "localhost"
username = "postgres"
dbname = "chatbot_db"
output_file = "local_db.dump"

# Optional: Set PGPASSWORD environment variable for non-interactive password passing
os.environ["PGPASSWORD"] = "123"

# Build command
command = [
    pg_dump_path,
    "-Fc",  # Custom format
    "--host", host,
    "--username", username,
    "--dbname", dbname,
    "--file", output_file,
    "--no-owner",        # Remove ownership commands
    "--no-privileges",
    "--no-acl"
]

try:
    subprocess.run(command, check=True)
    print(f"Database dump successful! Output file: {output_file}")
except subprocess.CalledProcessError as e:
    print("Error during pg_dump:")
    print(e)

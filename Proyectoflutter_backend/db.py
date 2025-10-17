import os
from dotenv import load_dotenv

load_dotenv()

ENTORNO = os.getenv("ENTORNO", "local")

if ENTORNO == "local":
    CONNECTION_STRING = (
        "DRIVER={ODBC Driver 17 for SQL Server};"
        f"SERVER=localhost;"
        f"DATABASE=Proyectoflutter;"
        "Trusted_Connection=yes;"
    )
elif ENTORNO == "instituto":
    CONNECTION_STRING = (
        "DRIVER={ODBC Driver 17 for SQL Server};"
        f"SERVER={os.getenv('DB_SERVER')};"
        f"DATABASE={os.getenv('DB_DATABASE')};"
        f"UID={os.getenv('DB_USER')};"
        f"PWD={os.getenv('DB_PASS')};"
    )

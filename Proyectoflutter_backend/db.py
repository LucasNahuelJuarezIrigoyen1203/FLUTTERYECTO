import os
import pyodbc
from dotenv import load_dotenv

load_dotenv()

ENTORNO = os.getenv("ENTORNO", "local")

# 🔌 Conexión según entorno
if ENTORNO == "local":
    CONNECTION_STRING = (
        "DRIVER={ODBC Driver 17 for SQL Server};"
        "SERVER=localhost\\SQLEXPRESS01;"
        "DATABASE=Proyectoflutter;"
        "Trusted_Connection=yes;"
    )
elif ENTORNO == "instituto":
    CONNECTION_STRING = (
        "DRIVER={ODBC Driver 17 for SQL Server};"
        f"SERVER={os.getenv('SQL_SERVER')};"
        f"DATABASE={os.getenv('SQL_DATABASE')};"
        f"UID={os.getenv('SQL_USER')};"
        f"PWD={os.getenv('SQL_PASSWORD')};"
    )
else:
    raise ValueError("⚠️ ENTORNO no reconocido. Usá 'local' o 'instituto'.")

# 🌐 Conexión global
try:
    conn = pyodbc.connect(CONNECTION_STRING)
    print("✅ Conexión exitosa a SQL Server")
except Exception as e:
    print(f"❌ Error de conexión a SQL Server: {e}")
    conn = None  # Evita fallos si se importa en otros módulos

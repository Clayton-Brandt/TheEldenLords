import sqlite3
from pathlib import Path 
# Instead of eldenring.sqlite, it might need to be eldenring.db.
DB_PATH = Path(__file__).resolve().parent/ "eldenring.db"
def get_db():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row  
    conn.execute("PRAGMA foreign_keys = ON")  
    return conn
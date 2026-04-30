import sqlite3

def get_db():
    conn = sqlite3.connect(
        r"C:\Users\wdrya\OneDrive\Documents\GitHub\TheEldenLords\Database\eldenring.db"
    )
    conn.row_factory = sqlite3.Row
    return conn

from fastapi import APIRouter, HTTPException
from database import get_db

router = APIRouter(prefix="/bosses", tags=["weaknesses"])


@router.get("/{boss_id}/weaknesses")
def get_boss_weaknesses(boss_id: int):
    conn = get_db()
    cur = conn.cursor()

    cur.execute("SELECT weakness FROM boss_weaknesses WHERE boss_id=?", (boss_id,))
    rows = cur.fetchall()

    if not rows:
        raise HTTPException(404, "No weaknesses found for this boss")

    return [row["weakness"] for row in rows]

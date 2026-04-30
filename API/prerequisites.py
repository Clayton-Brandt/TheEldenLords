from fastapi import APIRouter, HTTPException
from database import get_db

router = APIRouter(prefix="/bosses", tags=["prerequisites"])


@router.get("/{boss_id}/prerequisites")
def get_boss_prerequisites(boss_id: int):
    conn = get_db()
    cur = conn.cursor()

    cur.execute("SELECT prerequisite FROM boss_prerequisites WHERE boss_id=?", (boss_id,))
    rows = cur.fetchall()

    if not rows:
        raise HTTPException(404, "No prerequisites found for this boss")

    return [row["prerequisite"] for row in rows]

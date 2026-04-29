from fastapi import APIRouter, HTTPException
from database import get_db

router = APIRouter(prefix="/bosses", tags=["rewards"])


@router.get("/{boss_id}/rewards")
def get_boss_rewards(boss_id: int):
    conn = get_db()
    cur = conn.cursor()

    cur.execute("SELECT reward FROM boss_rewards WHERE boss_id=?", (boss_id,))
    rows = cur.fetchall()

    if not rows:
        raise HTTPException(404, "No rewards found for this boss")

    return [row["reward"] for row in rows]

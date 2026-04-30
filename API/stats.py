from fastapi import APIRouter, HTTPException
from database import get_db

router = APIRouter(prefix="/bosses", tags=["stats"])


@router.get("/{boss_id}/stats")
def get_boss_stats(boss_id: int):
    conn = get_db()
    cur = conn.cursor()

    cur.execute("SELECT * FROM boss_stats WHERE boss_id=?", (boss_id,))
    row = cur.fetchone()

    if not row:
        raise HTTPException(404, "No stats found for this boss")

    return dict(row)

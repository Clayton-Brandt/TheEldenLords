from fastapi import APIRouter, HTTPException
from database import get_db

router = APIRouter(prefix="/bosses", tags=["resistances"])


@router.get("/{boss_id}/resistances")
def get_boss_resistances(boss_id: int):
    conn = get_db()
    cur = conn.cursor()

    cur.execute("SELECT resistance FROM boss_resistances WHERE boss_id=?", (boss_id,))
    rows = cur.fetchall()

    if not rows:
        raise HTTPException(404, "No resistances found for this boss")

    return [row["resistance"] for row in rows]

from fastapi import APIRouter, HTTPException
from database import get_db

router = APIRouter(prefix="/bosses", tags=["lore"])


@router.get("/{boss_id}/lore")
def get_boss_lore(boss_id: int):
    conn = get_db()
    cur = conn.cursor()

    cur.execute("SELECT lore FROM boss_lore WHERE boss_id=?", (boss_id,))
    rows = cur.fetchall()

    if not rows:
        raise HTTPException(404, "No lore found for this boss")

    return [row["lore"] for row in rows]

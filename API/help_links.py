from fastapi import APIRouter, HTTPException
from database import get_db

router = APIRouter(prefix="/bosses", tags=["help_links"])


@router.get("/{boss_id}/help")
def get_boss_help_links(boss_id: int):
    conn = get_db()
    cur = conn.cursor()

    cur.execute("SELECT title, url FROM boss_help_links WHERE boss_id=?", (boss_id,))
    rows = cur.fetchall()

    if not rows:
        raise HTTPException(404, "No help links found for this boss")

    return [dict(row) for row in rows]

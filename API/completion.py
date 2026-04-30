from fastapi import APIRouter, HTTPException
from database import get_db

router = APIRouter(prefix="/completion", tags=["completion"])


@router.get("/{user_id}")
def get_user_progress(user_id: int):
    conn = get_db()
    cur = conn.cursor()

    cur.execute("SELECT * FROM user_progress WHERE user_id=?", (user_id,))
    rows = cur.fetchall()

    if not rows:
        raise HTTPException(404, "No progress found for this user")

    return [dict(row) for row in rows]


@router.get("/{run_id}/{boss_id}")
def get_boss_completion(run_id: int, boss_id: int):
    conn = get_db()
    cur = conn.cursor()

    cur.execute(
        "SELECT * FROM user_progress WHERE run_id=? AND boss_id=?",
        (run_id, boss_id)
    )
    row = cur.fetchone()

    if not row:
        raise HTTPException(404, "No completion data found")

    return dict(row)

@router.get("/{user_id}")
def get_completion_by_user(user_id: int):
    conn = get_db()
    cur = conn.cursor()
    cur.execute("SELECT * FROM completion WHERE user_id=?", (user_id,))
    rows = cur.fetchall()
    return [dict(row) for row in rows]

@router.get("/{user_id}/{boss_id}")
def get_completion_entry(user_id: int, boss_id: int):
    conn = get_db()
    cur = conn.cursor()
    cur.execute("SELECT * FROM completion WHERE user_id=? AND boss_id=?" (user_id, boss_id))
    row = cur.fetchone()

    if not row:
        raise HTTPException(404, "Post not found")

    return dict(row)

@router.post("/")
def create_completion(entry: Completion):
    conn = get_db()
    cur = conn.cursor()
    cur.execute(
        "INSERT INTO completion (user_id, boss_id, completed) VALUES (?, ?, ?)",
        (entry.user_id, entry.boss_id, entry.completed,)
    )
    conn.commit()
    return "Completion entry created"



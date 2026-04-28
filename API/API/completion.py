@router.get("/{user_id}")
def get_progress_by_user(user_id: int):
    conn = get_db()
    cur = conn.cursor()
    cur.execute("""
        SELECT * FROM user_progress WHERE run_id IN (SELECT run_id FROM user_boss_runs WHERE user_id=?)""", (user_id,))
    rows = cur.fetchall()
    return [dict(row) for row in rows]

@router.get("/{run_id}/{boss_id}")
def get_progress_entry(run_id: int, boss_id: int):
    conn = get_db()
    cur = conn.cursor()
    cur.execute("SELECT * FROM user_progress WHERE run_id=? AND boss_id=?",(run_id, boss_id)
    row = cur.fetchone()

    if not row:
        raise HTTPException(404, "Progress entry not found")

    return dict(row)


@router.post("/")
def create_progress(entry: UserProgressCreate):
    conn = get_db()
    cur = conn.cursor()
    cur.execute(
        "SELECT * FROM user_progress WHERE run_id=? AND boss_id=?",(entry.run_id, entry.boss_id))
    existing = cur.fetchone()

    if existing:
        raise HTTPException(400, "Progress entry already exists")

    cur.execute("""INSERT INTO user_progress (run_id, boss_id, defeated, attempts) VALUES (?, ?, 0, 0)""", (entry.run_id, entry.boss_id))

    conn.commit()
    return "Progress entry created"

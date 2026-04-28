@router.get("/")
def get_bosses(name: str | None = None):
    conn = get_db()
    cur = conn.cursor()

    if name:
        cur.execute("SELECT * FROM bosses WHERE name LIKE ?", (f"%{name}%",))
    else:
        cur.execute("SELECT * FROM bosses")

    rows = cur.fetchall()
    return [dict(row) for row in rows]

@router.get("/{boss_id}")
def get_boss(boss_id: int):
    conn = get_db()
    cur = conn.cursor()
    cur.execute("SELECT * FROM bosses WHERE id=?", (boss_id,))
    row = cur.fetchone()

    if not row:
        raise HTTPException(404, "Boss not found")

    return dict(row)


@router.post("/")
def create_boss(boss: Boss):
    conn = get_db()
    cur = conn.cursor()
    cur.execute(
        "INSERT INTO bosses (name, location, lore, stats, prerequisites, help, rewards) VALUES (?, ?, ?, ?, ?, ?, ?)",
        (boss.name, boss.location, boss.lore, boss.stats, boss.prerequisites, boss.help, boss.rewards)
    )
    conn.commit()
    return "Boss created"

@router.put("/{boss_id}")
def update_boss(boss_id: int, boss: BossUpdate):
    conn = get_db()
    cur = conn.cursor()
    cur.execute(
        "UPDATE bosses SET name=?, location=?, lore=?, stats=?, prerequisites=?, help=?, rewards=? WHERE id=?",
        (boss.name, boss.location, boss.lore, boss.strats, boss.prerequisites, boss.help, boss.rewards, boss_id))
    conn.commit()
    return "Boss updated"

@router.delete("/{boss_id}")
def delete_boss(boss_id: int):
    conn = get_db()
    cur = conn.cursor()
    cur.execute("DELETE FROM bosses WHERE id=?", (boss_id,))
    conn.commit()
    return "boss deleted"





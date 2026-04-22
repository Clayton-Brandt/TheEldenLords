@router.get("/user/{user_id}")
def get_posts_by_user(user_id: int):
    conn = get_db()
    cur = conn.cursor()
    cur.execute("SELECT * FROM posts WHERE user_id=?", (user_id,))
    rows = cur.fetchall()
    return [dict(row) for row in rows]

@router.get("/{post_id}")
def get_post(post_id: int):
    conn = get_db()
    cur = conn.cursor()
    cur.execute("SELECT * FROM posts WHERE id=?", (post_id,))
    row = cur.fetchone()

    if not row:
        raise HTTPException(404, "Post not found")

    return dict(row)

@router.post("/")
def create_post(post: Post):
    conn = get_db()
    cur = conn.cursor()
    cur.execute(
        "INSERT INTO posts (user_id, title, post_text, likes) VALUES (?, ?, ?, ?)",
        (post.user_id, post.title, post.post_text, post.likes)
    )
    conn.commit()
    return "Post created"



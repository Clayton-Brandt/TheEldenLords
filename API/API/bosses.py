@router.get("/")
def get_posts(title: str | None = None):
    conn = get_db()
    cur = conn.cursor()

    if title:
        cur.execute("SELECT * FROM posts WHERE title LIKE ?", (f"%{title}%",))
    else:
        cur.execute("SELECT * FROM posts")

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

@router.put("/{post_id}")
def update_post(post_id: int, post: PostUpdate):
    conn = get_db()
    cur = conn.cursor()
    cur.execute(
        "UPDATE posts SET user_id=?, title=?, post_text=?, likes=? WHERE id=?",
        (post.user_id, post.title, post.post_text, post.likes, post_id)
    )
    conn.commit()
    return "Post updated"

@router.patch("/{post_id}/title")
def patch_title(post_id: int, title: str):
    conn = get_db()
    cur = conn.cursor()
    cur.execute("UPDATE posts SET title=? WHERE id=?", (title, post_id))
    conn.commit()
    return "Title updated"

@router.delete("/{post_id}")
def delete_post(post_id: int):
    conn = get_db()
    cur = conn.cursor()
    cur.execute("DELETE FROM posts WHERE id=?", (post_id,))
    conn.commit()
    return "Post deleted"





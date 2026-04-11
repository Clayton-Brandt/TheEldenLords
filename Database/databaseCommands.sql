-- Create statements for tables.

CREATE TABLE bosses (
    boss_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    location TEXT,
    lore TEXT,
    stats TEXT,
    prerequisites TEXT
);

CREATE TABLE user_progress (
    discord_user_id TEXT,
    boss_id INTEGER,
    defeated INTEGER,
    PRIMARY KEY (discord_user_id, boss_id),
    FOREIGN KEY (boss_id) REFERENCES bosses(boss_id)
);

-- DROP TABLE bosses;

-- Test if the data is actually there.
SELECT * FROM bosses;

-- Tests if there's relationships or not.
INSERT INTO user_progress (discord_user_id, boss_id, defeated)
VALUES ('123456', 1, 1);
SELECT * FROM user_progress;
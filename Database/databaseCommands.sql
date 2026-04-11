-- Drops tables make recreating the database easier.
DROP TABLE IF EXISTS boss_help_links;
DROP TABLE IF EXISTS boss_rewards;
DROP TABLE IF EXISTS boss_resistances;
DROP TABLE IF EXISTS boss_weaknesses;
DROP TABLE IF EXISTS boss_prerequisites;
DROP TABLE IF EXISTS boss_stats;
DROP TABLE IF EXISTS user_progress;
DROP TABLE IF EXISTS user_boss_runs;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS bosses;




-- Create statements for the database.
CREATE TABLE bosses (
    boss_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    location TEXT,
    lore TEXT
);

CREATE TABLE boss_weaknesses (
    boss_id INTEGER NOT NULL,
    weakness TEXT NOT NULL,
    FOREIGN KEY (boss_id) REFERENCES bosses(boss_id)
);

CREATE TABLE boss_resistances (
    boss_id INTEGER NOT NULL,
    resistance TEXT NOT NULL,
    FOREIGN KEY (boss_id) REFERENCES bosses(boss_id)
);

CREATE TABLE boss_rewards (
    boss_id INTEGER NOT NULL,
    reward TEXT NOT NULL,
    FOREIGN KEY (boss_id) REFERENCES bosses(boss_id)
);

CREATE TABLE boss_prerequisites (
    boss_id INTEGER NOT NULL,
    prerequisite TEXT NOT NULL,
    FOREIGN KEY (boss_id) REFERENCES bosses(boss_id)
);

CREATE TABLE boss_stats (
    stat_id INTEGER PRIMARY KEY AUTOINCREMENT,
    boss_id INTEGER NOT NULL,
    phase INTEGER NOT NULL DEFAULT 1,
    hp INTEGER,
    defense INTEGER,
    stance INTEGER,
    FOREIGN KEY (boss_id) REFERENCES bosses(boss_id)
);

CREATE TABLE boss_help_links (
    link_id INTEGER PRIMARY KEY AUTOINCREMENT,
    boss_id INTEGER NOT NULL,
    link_type TEXT NOT NULL DEFAULT 'wiki',
    title TEXT,
    url TEXT NOT NULL,
    FOREIGN KEY (boss_id) REFERENCES bosses(boss_id)
);

CREATE TABLE users (
    user_id INTEGER PRIMARY KEY AUTOINCREMENT,
    discord_user_id TEXT NOT NULL UNIQUE
);

CREATE TABLE user_boss_runs (
    run_id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    run_name TEXT DEFAULT 'main',
    created_at TEXT DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE user_progress (
    progress_id INTEGER PRIMARY KEY AUTOINCREMENT,
    run_id INTEGER NOT NULL,
    boss_id INTEGER NOT NULL,

    defeated INTEGER DEFAULT 0,
    attempts INTEGER DEFAULT 0,

    first_defeated_at TEXT,
    last_updated TEXT DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (run_id) REFERENCES user_boss_runs(run_id),
    FOREIGN KEY (boss_id) REFERENCES bosses(boss_id)
);




-- Insert statements for the database.
INSERT INTO bosses (name, location, lore) VALUES
('Margit The Fell Omen', 'Stormveil Castle', NULL),
('Godrick the Grafted', 'Stormveil Castle', NULL),
('Rennala Queen of the Full Moon', 'Raya Lucaria Academy', NULL),
('Starscourge Radahn', 'Redmane Castle', NULL),
('Mohg Lord of Blood', 'Mohgwyn Palace', NULL),
('Rykard Lord of Blasphemy', 'Volcano Manor', NULL),
('Draconic Tree Sentinel', 'Capital Outskirts', NULL),
('Godfrey First Elden Lord (Golden Shade)', 'Leyndell, Royal Capital', NULL),
('Morgott The Omen King', 'Leyndell, Royal Capital', NULL),
('Fire Giant', 'Flame Peak', NULL),
('Godskin Duo', 'Crumbling Farum Azula', NULL),
('Beast Clergyman/Maliketh The Black Blade', 'Crumbling Farum Azula', NULL),
('Sir Gideon-Ofnir the All Knowing', 'Leyndell, Ashen Capital', NULL),
('Godfrey First Elden Lord (Hoarah Loux)', 'Leyndell, Ashen Capital', NULL),
('Radagon of the Golden Order', 'Elden Throne', NULL),
('Elden Beast', 'Elden Throne', NULL);

INSERT INTO boss_weaknesses VALUES
(1,'Slash'), (2,'All Physical Damage'),
(3,'Standard'), (3,'Slash'), (3,'Pierce'),
(4,'Pierce'), (4,'Scarlet Rot'),
(5,'All Physical'), (5,'Hemorrhage'),
(6,'All Physical'),
(7,'Standard'), (7,'Strike'), (7,'Pierce'),
(8,'Pierce'), (8,'Lightning'),
(9,'Slash'),
(10,'Slash'),
(11,'Slash'), (11,'Sleep'), (11,'Hemorrhage'),
(12,'All Physical Damage'),
(13,'Strike'), (13,'Pierce'), (13,'Lightning'), (13,'Sleep'), (13,'Madness'),
(14,'Pierce'), (14,'Lightning'), (14,'Slash'),
(15,'Strike'), (15,'Fire');

INSERT INTO boss_resistances VALUES
(1,'Holy'), (2,'Holy'), (3,'Magic'),
(4,'Holy'), (4,'Sleep'),
(5,'Fire'),
(6,'Fire'),
(7,'Slash'), (7,'Fire'), (7,'Lightning'), (7,'Hemorrhage'), (7,'Frostbite'),
(8,'Holy'),
(9,'Holy'), (9,'Sleep'),
(10,'Fire'), (10,'Frostbite'),
(11,'Strike'), (11,'Fire'), (11,'Holy'),
(12,'Holy'), (12,'Sleep'),
(13,'Magic'),
(14,'Holy'), (14,'Sleep'),
(15,'Holy'), (15,'Hemorrhage'),
(16,'Holy'), (16,'All Status Effects');

INSERT INTO boss_rewards VALUES
(1,'12,000 runes'), (1,'Talisman Pouch'),
(2,'20,000 runes'), (2,'Godrick''s Great Rune'), (2,'Remembrance of the Grafted'),
(3,'40,000 runes'), (3,'Remembrance of the Full Moon'), (3,'Great Rune of the Unborn'),
(4,'70,000 runes'), (4,'Remembrance of the Starscourge'), (4,'Radahn''s Great Rune'),
(5,'420,000 runes'), (5,'Mohg''s Great Rune'), (5,'Remembrance of the Blood Lord'),
(6,'130,000 runes'), (6,'Rykard''s Great Rune'), (6,'Remembrance of the Blasphemous'),
(7,'50,000 runes'), (7,'Dragon Greatclaw'), (7,'Dragonclaw Shield'),
(8,'80,000 runes'), (8,'Talisman Pouch'),
(9,'120,000 runes'), (9,'Remembrance of the Omen King'), (9,'Morgott''s Great Rune'),
(10,'180,000 runes'), (10,'Remembrance of the Fire Giant'),
(11,'170,000 runes'), (11,'Black Flame Tornado'),
(12,'220,000 runes'), (12,'Remembrance of the Black Blade'),
(13,'150,000 runes'), (13,'All-Knowing Armor'),
(14,'300,000 runes'), (14,'Remembrance of Hoarah Loux'),
(15,'None'), (16,'500,000 runes'), (16,'Elden Remembrance');

INSERT INTO boss_prerequisites VALUES
(2,'Defeat Margit The Fell Omen'),
(3,'Glintstone Key'),
(3,'Defeat Red Wolf'),
(4,'Trigger Radahn Festival'),
(5,'Pureblood Knight''s Medal'),
(8,'None'),
(9,'2 Great Runes'),
(9,'Defeat Draconic Tree Sentinel'),
(9,'Defeat Godfrey Golden Shade'),
(10,'Defeat Morgott the Omen King'),
(12,'None'),
(13,'None'),
(14,'Defeat Gideon the All-Knowing'),
(15,'Defeat Hoarah Loux'),
(16,'Defeat Radagon of the Golden Order');

INSERT INTO boss_stats (boss_id, phase, hp, defense, stance) VALUES
(1,1,4174,103,80),
(2,1,6080,105,105),
(3,1,3493,109,0),
(3,2,4097,109,80),
(4,1,9572,113,200),
(5,1,18389,122,110),
(6,1,30493,115,120),
(6,2,59174,115,120),
(7,1,13362,118,80),
(8,1,7099,114,120),
(9,1,10399,114,80),
(10,1,42363,118,120),
(11,1,6668,118,80),
(11,2,8000,118,80),
(12,1,10620,120,80),
(13,1,9312,0,47),
(14,1,21903,120,120),
(15,1,13339,121,120),
(16,1,22127,121,150);

INSERT INTO users (discord_user_id) VALUES
('user_001'),
('user_002'),
('user_003');

INSERT INTO user_boss_runs (user_id, run_name) VALUES
(1,'main'),
(2,'main'),
(3,'main');

INSERT INTO user_progress (run_id, boss_id, defeated, attempts, first_defeated_at, last_updated) VALUES
(1,1,1,3,'2026-04-01 18:22:00','2026-04-01 18:22:00'),
(1,2,1,5,'2026-04-02 19:10:00','2026-04-02 19:10:00'),
(1,3,0,2,NULL,'2026-04-03 20:05:00'),
(2,1,1,1,'2026-03-28 15:44:00','2026-03-28 15:44:00'),
(2,4,0,6,NULL,'2026-04-05 21:33:00'),
(2,5,1,4,'2026-04-06 17:12:00','2026-04-06 17:12:00'),
(3,6,0,2,NULL,'2026-04-07 13:20:00'),
(3,7,1,7,'2026-04-07 19:55:00','2026-04-07 19:55:00'),
(3,8,1,2,'2026-04-08 16:10:00','2026-04-08 16:10:00'),
(1,4,1,8,'2026-04-09 22:40:00','2026-04-09 22:40:00');

INSERT INTO boss_help_links (boss_id, link_type, title, url) VALUES
(1,'wiki','Margit Strategy','https://eldenring.wiki.fextralife.com/Margit+the+Fell+Omen'),
(2,'wiki','Godrick Strategy','https://eldenring.wiki.fextralife.com/Godrick+the+Grafted'),
(4,'wiki','Radahn Strategy','https://eldenring.wiki.fextralife.com/Starscourge+Radahn'),
(10,'wiki','Fire Giant Strategy','https://eldenring.wiki.fextralife.com/Fire+Giant');
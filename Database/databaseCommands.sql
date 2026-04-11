DROP TABLE IF EXISTS bosses;
DROP TABLE IF EXISTS boss_stats;
DROP TABLE IF EXISTS user_progress;



-- Create statements for tables.
CREATE TABLE bosses (
    boss_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    location TEXT,
    lore TEXT,
    prerequisites TEXT,
    weaknesses TEXT,
    resistances TEXT,
    rewards TEXT
);


CREATE TABLE boss_stats (
    stat_id INTEGER PRIMARY KEY AUTOINCREMENT,
    boss_id INTEGER NOT NULL,

    phase INTEGER DEFAULT 1,
    hp TEXT,
    defense INTEGER,
    stance INTEGER,

    FOREIGN KEY (boss_id) REFERENCES bosses(boss_id)
);


CREATE TABLE user_progress (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    discord_user_id TEXT NOT NULL,
    boss_id INTEGER NOT NULL,

    defeated INTEGER DEFAULT 0,
    attempts INTEGER DEFAULT 0,

    first_defeated_at TEXT,
    last_updated TEXT DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (boss_id) REFERENCES bosses(boss_id)
);




-- Insert statements for tables.
INSERT INTO bosses (name, location, lore, prerequisites, weaknesses, resistances, rewards)
VALUES
('Margit The Fell Omen', 'Stormveil Castle', NULL, 'None', 'Slash', 'Holy', '12,000 runes, Talisman Pouch'),
('Godrick the Grafted', 'Stormveil Castle', NULL, 'Defeat Margit The Fell Omen', 'All Physical Damage', 'Holy', '20,000 runes, Godrick''s Great Rune, Remembrance of the Grafted'),
('Rennala Queen of the Full Moon', 'Raya Lucaria Academy', NULL, 'Glintstone Key, Defeat Red Wolf', 'Standard, Slash, Pierce', 'Magic', '40,000 Runes, Remembrance of the Full Moon, Great Rune of the Unborn'),
('Starscourge Radahn', 'Redmane Castle', NULL, 'Trigger Radahn Festival', 'Pierce, Scarlet Rot', 'Holy, Sleep', '70,000 Runes, Remembrance of the Starscourge, Radahn''s Great Rune'),
('Mohg Lord of Blood', 'Mohgwyn Palace', NULL, 'Pureblood Knight''s Medal', 'All Physical, Hemorrhage', 'Fire', '420,000 Runes, Mohg''s Great Rune, Remembrance of the Blood Lord'),
('Rykard Lord of Blasphemy', 'Volcano Manor', NULL, 'None', 'All Physical', 'Fire', '130,000 Runes, Rykard''s Great Rune, Remembrance of the Blasphemous'),
('Draconic Tree Sentinel', 'Capital Outskirts', NULL, 'None', 'Standard, Strike, Pierce', 'Slash, Fire, Lightning, Hemorrhage, Frostbite', '50,000 Runes, Dragon Greatclaw, Dragonclaw Shield'),
('Godfrey First Elden Lord (Golden Shade)', 'Leyndell, Royal Capital', NULL, 'None', 'Pierce, Lightning', 'Holy', '80,000 runes, Talisman Pouch'),
('Morgott The Omen King', 'Leyndell, Royal Capital', NULL, '2 Great Runes, Defeat Draconic Tree Sentinel & Godfrey Golden Shade', 'Slash', 'Holy, Sleep', '120,000 runes, Remembrance of the Omen King, Morgott''s Great Rune, Talisman Pouch'),
('Fire Giant', 'Flame Peak', NULL, 'Defeat Morgott the Omen King', 'Slash', 'Fire, Frostbite', '180,000 Runes, Remembrance of the Fire Giant'),
('Godskin Duo', 'Crumbling Farum Azula', NULL, 'None', 'Slash, Sleep, Hemorrhage', 'Strike, Fire, Holy', '170,000 Runes, Ash of War: Black Flame Tornado, Smithing Stone Bell Bearing [4]'),
('Beast Clergyman/Maliketh The Black Blade', 'Crumbling Farum Azula', NULL, 'None', 'All Physical Damage', 'Holy, Sleep', '220,000 Runes, Remembrance of the Black Blade'),
('Sir Gideon-Ofnir the All Knowing', 'Leyndell, Ashen Capital', NULL, 'None', 'Strike, Pierce, Lightning, Sleep, Madness', 'Magic', '150,000 Runes, All-Knowing Armor, Scepter of the All-Knowing'),
('Godfrey First Elden Lord (Hoarah Loux)', 'Leyndell, Ashen Capital', NULL, 'Defeat Gideon the All-Knowing', 'Pierce, Lightning, Slash', 'Holy, Sleep', '300,000 Runes, Remembrance of Hoarah Loux'),
('Radagon of the Golden Order', 'Elden Throne', NULL, 'Defeat Hoarah Loux', 'Strike, Fire', 'Holy, Hemorrhage (immune)', 'None'),
('Elden Beast', 'Elden Throne', NULL, 'Defeat Radagon of the Golden Order', 'All Physical Damage', 'Holy, All Status Effects (immune)', '500,000 Runes, Elden Remembrance');


INSERT INTO boss_stats (boss_id, phase, hp, defense, stance)
VALUES
(1, 1, '4174', 103, 80),
(2, 1, '6080', 105, 105),
(3, 1, '3493', 109, 0),
(3, 2, '4097', 109, 80),
(4, 1, '9572', 113, 200),
(5, 1, '18389', 122, 110),
(6, 1, 'Serpent: 30493 / Rykard: 59174', 115, 120),
(7, 1, '13362', 118, 80),
(8, 1, '7099', 114, 120),
(9, 1, '10399', 114, 80),
(10, 1, '42363', 118, 120),
(11, 1, 'Apostle: 6668 / Noble: 8000', 118, 80),
(12, 1, '10620', 120, 80),
(13, 1, '9312', 0, 47),
(14, 1, '21903', 120, 120),
(15, 1, '13339', 121, 120),
(16, 1, '22127', 121, 150);


-- Temporary insert statements for user_progress. This is probably going to be removed
-- once the API/Discord Bot works.
INSERT INTO user_progress (discord_user_id, boss_id, defeated, attempts, first_defeated_at, last_updated)
VALUES
('user_001', 1, 1, 3, '2026-04-01 18:22:00', '2026-04-01 18:22:00'),
('user_001', 2, 1, 5, '2026-04-02 19:10:00', '2026-04-02 19:10:00'),
('user_001', 3, 0, 2, NULL, '2026-04-03 20:05:00'),
('user_002', 1, 1, 1, '2026-03-28 15:44:00', '2026-03-28 15:44:00'),
('user_002', 4, 0, 6, NULL, '2026-04-05 21:33:00'),
('user_002', 5, 1, 4, '2026-04-06 17:12:00', '2026-04-06 17:12:00'),
('user_003', 6, 0, 2, NULL, '2026-04-07 13:20:00'),
('user_003', 7, 1, 7, '2026-04-07 19:55:00', '2026-04-07 19:55:00'),
('user_003', 8, 1, 2, '2026-04-08 16:10:00', '2026-04-08 16:10:00'),
('user_001', 4, 1, 8, '2026-04-09 22:40:00', '2026-04-09 22:40:00');
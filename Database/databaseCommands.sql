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
DROP TABLE IF EXISTS boss_lore;




-- Create statements for the database.
CREATE TABLE bosses (
    boss_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    location TEXT
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

CREATE TABLE boss_lore (
    lore_id INTEGER PRIMARY KEY AUTOINCREMENT,
    boss_id INTEGER NOT NULL,
    lore TEXT NOT NULL,
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
INSERT INTO bosses (name, location) VALUES
('Margit The Fell Omen', 'Stormveil Castle'),
('Godrick the Grafted', 'Stormveil Castle'),
('Rennala Queen of the Full Moon', 'Raya Lucaria Academy'),
('Starscourge Radahn', 'Redmane Castle'),
('Mohg Lord of Blood', 'Mohgwyn Palace'),
('Rykard Lord of Blasphemy', 'Volcano Manor'),
('Draconic Tree Sentinel', 'Capital Outskirts'),
('Godfrey First Elden Lord (Golden Shade)', 'Leyndell, Royal Capital'),
('Morgott The Omen King', 'Leyndell, Royal Capital'),
('Fire Giant', 'Flame Peak'),
('Godskin Duo', 'Crumbling Farum Azula'),
('Beast Clergyman/Maliketh The Black Blade', 'Crumbling Farum Azula'),
('Sir Gideon-Ofnir the All Knowing', 'Leyndell, Ashen Capital'),
('Godfrey First Elden Lord (Hoarah Loux)', 'Leyndell, Ashen Capital'),
('Radagon of the Golden Order', 'Elden Throne'),
('Elden Beast', 'Elden Throne');

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

INSERT INTO boss_lore (boss_id, lore) VALUES
(1, 'Margit is an Omen, who gained notoriety during The Shattering, in which he slaughtered countless champions who harbored ambitions for Lordship, stacking high their corpses during the Second Defense of Leyndell'),
(2, 'Godrick is a descendant of the Golden Lineage, the bloodline that began with Queen Marika the Eternal and her first consort Godfrey. Only a distant relation of Marika''s line, his divine blood was sorely diluted, and he was viewed as the runt of the litter. Godrick idolized the first Elden Lord, desiring his ancestor to witness his feats.'),
(3, 'The young Lunar Princess was an astrologer who gazed at the night sky and chased the stars. In her youth, Rennala and her younger sister, Rellana, encountered moons that one day made them champions. Hers was an enchanting Full Moon. Later, she bewitched the Academy of Raya Lucaria with her lunar magic, becoming its master.'),
(4, 'Red-Maned Radahn was the son of Radagon, a champion of the Erdtree, and Queen Rennala of the Full Moon, born after the Second Liurnian War. He has two siblings, Rykard and Ranni. From a young age, he was enamored with Elden Lord Godfrey and adorned his armor with lions, the symbol of Godfrey and Serosh.'),
(5, 'Mohg was born of the Golden Lineage and twin brother of Morgott. The twins were accursed Omen and as a result, were confined and shackled to the Subterranean Shunning Grounds below Leyndell. Mohg embraced his Omen blood and made contact with an Outer God, The Formless Mother, who ignited his accursed blood with bloodflame, granting him powerful magic.'),
(6, 'Under the Golden Order, Rykard was a ruthless justiciar who commanded a company of inquisitors. They persecuted and mercilessly tortured those considered heretics to the Golden Order. He spent time in the volcanic Mt. Gelmir, where he discovered the ancient magma hexes of a forgotten serpent-worshiping religion native to the region, which he brought back into practical use as new sorceries. Rykard was also an orchestrator of the Night of the Black Knives.'),
(7, 'Possessed of great strength and abundant Grace, Queen Marika''s mounted Sentinels met little resistance as they charged down her enemies. Very few were permitted to join their unbreakable ranks. Defenders of the Erdtree as the Golden standard. After the Ancient Dragon Gransax attacked Leyndell, some Sentinels adopted characteristics of the Dragons.'),
(8, 'A Spectral Shade, radiating a Golden hue, adorning the likeness of the First Elden Lord, Godfrey.'),
(9, 'Rightful Heir of the Golden Lineage. Despite his royal pedigree, he and his brother Mohg were born with accursed blood that caused tangled horns to sprout from their infant bodies. These growths branded them as Omen spurned by the Erdtree and excluded from its Grace. Though banished, his devotion to the Erdtree never wavered and he became its defender.'),
(10, 'Long before the Erdtree, the Giants claimed the inhospitable northern mountains after driving away the Ice Dragons that once ruled them. They worshipped their Fell God and tended its Flame within the Great Forge. When Queen Marika ushered in the Age of the Erdtree, she ordered Godfrey and his Crucible Knights to wage war with the Giants, fearing that their flame could burn her Erdtree. This is the last Giant who has stood tall, defending the Flame.'),
(11, 'Draped in robes of soft skin, this duo serves the Gloam Eyed Queen, who served the Rune of Death. Their black flames were able to kill any God that stood in their path to service. However after Maliketh killed the Gloam Eyed Queen, Queen Marika sealed away the power of the Rune of Death and her and her kin were made immortal. This duo lays in wait in their old God''s Temple.'),
(12, 'A loyal Shadowbound Beast, Half Brother of Queen Marika. He defeated the Gloam Eyed Queen and Queen Marika sealed the Rune of Death within his blade. Causing the power of the god slaying black flame to be lost except within his blade. There is no demigod who did not fear his name.'),
(13, 'Tarnished Leader of the Roundtable Hold. Called to the Lands Between by guidance of Grace. Gideon wished to become Elden Lord. At some point, he engages the Two Fingers, and in doing so learns that everything including the Erdtree and the Two Fingers had been broken. Gideon glimpses into the will of Queen Marika, shuddering in fear at an end that should not be.'),
(14, 'The first Elden Lord. He was an unmatched Champion who earned his right to Lordship through sheer strength alone. Godfrey led Marika''s Golden armies and was named Lord of the Battlefield. At the end of his campaign, Godfrey and his armies were stripped of their Grace by Marika, who ordered them to fight in a distant land, to die, and after which she promised they would regain what she had taken from them and with the strength required to brandish the Elden Ring.'),
(15, 'Radagon first rose to prominence during the Liurnian Wars, the redlocked Great Champion. After which he married Rennala and had 3 children. While married to Rennala, he studied Glintstone sorcery. After Godfrey was stripped of Grace, he returned to the Capital of Leyndell and became the consort of Marika, becoming the Second Elden Lord. They had two children together, Malenia and Miquella. Though a secret, some learned of a horrific truth about the man: he was in fact Queen Marika all along, like one soul inhabiting two bodies.'),
(16, 'A long-necked aquatic creature, the Elden Beast is a living constellation of shimmering amber starlight suspended in a translucent silhouette. Set upon a golden star by the Greater Will, the arrival of the Elden Beast was one of the earliest events known to have occurred in the Lands Between. It was the vassal of the Greater Will and the living incarnation of the concept of Order. The Elden Beast was later forged into the Elden Ring and those who became a vessel for it were known as Lord.');

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
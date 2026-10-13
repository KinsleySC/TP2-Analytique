INSERT INTO coachs (id, nom, manager_id) VALUES
    (1, 'Sarah Morel', NULL),
    (2, 'Lucas Petit', 1),
    (3, 'Emma Laurent', 1),
    (4, 'Noah Bernard', 1),
    (5, 'Jade Roux', 2),
    (6, 'Adam Martin', 2),
    (7, 'Lina Robert', 2),
    (8, 'Louis Simon', 3),
    (9, 'Chloe Michel', 3),
    (10, 'Gabriel Leroy', 3),
    (11, 'Alice Garcia', 4),
    (12, 'Arthur David', 4),
    (13, 'Louise Bertrand', 4),
    (14, 'Nathan Vincent', 5),
    (15, 'Manon Thomas', 8);

INSERT INTO adherents (id, nom, email, date_inscription)
SELECT g,
       (ARRAY['Camille', 'Alex', 'Ines', 'Tom', 'Lea'])[1 + ((g - 1) % 5)] || ' Adherent ' || g,
       'adherent' || g || '@example.com',
       DATE '2026-05-01' + g
FROM generate_series(1, 20) AS g;

INSERT INTO cours (id, nom, categorie, coach_id, duree_minutes, tarif) VALUES
    (1, 'Velo debutant', 'Cardio', 1, 45, 12),
    (2, 'Velo intense', 'Cardio', 2, 60, 15),
    (3, 'Course douce', 'Cardio', 3, 45, 12),
    (4, 'Circuit cardio', 'Cardio', 4, 60, 18),
    (5, 'Boxe cardio', 'Cardio', 5, 60, 20),
    (6, 'Abdominaux', 'Renforcement', 6, 30, 10),
    (7, 'Haut du corps', 'Renforcement', 7, 45, 15),
    (8, 'Bas du corps', 'Renforcement', 8, 45, 15),
    (9, 'Musculation', 'Renforcement', 9, 60, 18),
    (10, 'Circuit force', 'Renforcement', 10, 60, 20),
    (11, 'Yoga doux', 'Bien-etre', 11, 60, 12),
    (12, 'Pilates', 'Bien-etre', 12, 60, 15),
    (13, 'Mobilite', 'Bien-etre', 13, 30, 10),
    (14, 'Etirements', 'Bien-etre', 14, 30, 10),
    (15, 'Atelier bien-etre', 'Bien-etre', 15, 120, 90);
INSERT INTO reservations (id, adherent_id, cours_id, date_seance, montant)
SELECT (j - 1) * 3 + p,
       1 + ((j * 3 + p * 7) % 20),
       c.id,
       DATE '2026-06-01' + (j - 1) * 2,
       c.tarif
FROM generate_series(1, 61) AS j
CROSS JOIN generate_series(1, 3) AS p
JOIN cours c ON c.id = 1 + ((j * 2 + p * 3) % 15);

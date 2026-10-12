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

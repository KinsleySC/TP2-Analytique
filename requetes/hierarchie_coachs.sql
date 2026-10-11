WITH RECURSIVE equipe AS (
    SELECT id, nom, manager_id, 0 AS niveau, nom::text AS chemin
    FROM coachs
    WHERE manager_id IS NULL
    UNION ALL
    SELECT c.id, c.nom, c.manager_id, e.niveau + 1, e.chemin || ' > ' || c.nom
    FROM coachs c
    JOIN equipe e ON c.manager_id = e.id
)
SELECT id, nom, manager_id, niveau, chemin
FROM equipe
ORDER BY chemin;

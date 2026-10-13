WITH classement AS (
    SELECT c.id, c.categorie, c.nom, COUNT(r.id) AS reservations,
           ROW_NUMBER() OVER (
               PARTITION BY c.categorie ORDER BY COUNT(r.id) DESC, c.id
           ) AS rang
    FROM cours c
    LEFT JOIN reservations r ON r.cours_id = c.id
    GROUP BY c.id, c.categorie, c.nom
)
SELECT categorie, nom, reservations, rang
FROM classement
WHERE rang <= 3
ORDER BY categorie, rang;

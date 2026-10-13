WITH totaux AS (
    SELECT c.categorie, SUM(r.montant) AS recettes
    FROM cours c JOIN reservations r ON r.cours_id = c.id
    GROUP BY c.categorie
)
SELECT SUM(recettes) = (SELECT SUM(montant) FROM reservations) AS total_categories_correct
FROM totaux;

SELECT 'coachs' AS table_nom, COUNT(*) AS lignes FROM coachs
UNION ALL SELECT 'adherents', COUNT(*) FROM adherents
UNION ALL SELECT 'cours', COUNT(*) FROM cours
UNION ALL SELECT 'reservations', COUNT(*) FROM reservations;

SELECT COUNT(*) AS reservations, MIN(date_seance) AS premiere_date,
    MAX(date_seance) AS derniere_date,
    COUNT(DISTINCT DATE_TRUNC('month', date_seance)) AS mois,
    SUM(montant) AS recettes
FROM reservations;

WITH totaux AS (
    SELECT c.categorie, SUM(r.montant) AS recettes
    FROM cours c JOIN reservations r ON r.cours_id = c.id
    GROUP BY c.categorie
)
SELECT SUM(recettes) = (SELECT SUM(montant) FROM reservations) AS total_categories_correct
FROM totaux;

SELECT COUNT(*) AS jours_sans_activite
FROM generate_series(TIMESTAMP '2026-06-01', TIMESTAMP '2026-09-30', INTERVAL '1 day') j
LEFT JOIN reservations r ON r.date_seance = j::date
WHERE r.id IS NULL;

SELECT COUNT(*) AS inscriptions_apres_seance
FROM reservations r
JOIN adherents a ON a.id = r.adherent_id
WHERE a.date_inscription > r.date_seance;

SELECT COUNT(*) AS montants_differents_du_tarif_initial
FROM reservations r
JOIN cours c ON c.id = r.cours_id
WHERE r.montant <> c.tarif;

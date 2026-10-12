SELECT 'coachs' AS table_nom, COUNT(*) AS lignes FROM coachs
UNION ALL SELECT 'adherents', COUNT(*) FROM adherents
UNION ALL SELECT 'cours', COUNT(*) FROM cours
UNION ALL SELECT 'reservations', COUNT(*) FROM reservations;

SELECT COUNT(*) AS reservations, MIN(date_seance) AS premiere_date,
       MAX(date_seance) AS derniere_date,
       COUNT(DISTINCT DATE_TRUNC('month', date_seance)) AS mois,
       SUM(montant) AS recettes
FROM reservations;

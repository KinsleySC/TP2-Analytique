SELECT SUM(montant) AS total_general FROM reservations;

SELECT DATE_TRUNC('month', date_seance)::date AS mois, SUM(montant) AS recettes
FROM reservations
GROUP BY 1
ORDER BY 1;

SELECT COUNT(*) AS lignes_vue, SUM(recettes) AS recettes_vue
FROM tableau_bord_ocoach;

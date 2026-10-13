WITH par_mois AS (
    SELECT DATE_TRUNC('month', date_seance)::date AS mois, SUM(montant) AS recettes
    FROM reservations
    GROUP BY 1
)
SELECT mois, recettes,
       ROUND(AVG(recettes) OVER (
           ORDER BY mois ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
       ), 2) AS moyenne_mobile
FROM par_mois
ORDER BY mois;

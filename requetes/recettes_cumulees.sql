WITH par_mois AS (
    SELECT DATE_TRUNC('month', date_seance)::date AS mois, SUM(montant) AS recettes
    FROM reservations
    GROUP BY 1
)
SELECT mois, recettes,
       SUM(recettes) OVER (
           ORDER BY mois ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
       ) AS cumul
FROM par_mois
ORDER BY mois;

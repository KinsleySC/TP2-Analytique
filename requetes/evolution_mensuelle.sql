WITH par_mois AS (
    SELECT DATE_TRUNC('month', date_seance)::date AS mois, SUM(montant) AS recettes
    FROM reservations
    GROUP BY 1
), comparaison AS (
    SELECT mois, recettes, LAG(recettes) OVER (ORDER BY mois) AS precedent
    FROM par_mois
)
SELECT mois, recettes, precedent,
       ROUND(100.0 * (recettes - precedent) / NULLIF(precedent, 0), 2) AS evolution_pct
FROM comparaison
ORDER BY mois;

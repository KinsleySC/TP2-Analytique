SELECT j::date AS jour, COUNT(r.id) AS reservations,
       COALESCE(SUM(r.montant), 0) AS recettes
FROM generate_series(
    TIMESTAMP '2026-06-01', TIMESTAMP '2026-09-30', INTERVAL '1 day'
) AS j
LEFT JOIN reservations r ON r.date_seance = j::date
GROUP BY j
ORDER BY j;

SELECT c.categorie,
       COALESCE(SUM(r.montant) FILTER (WHERE DATE_TRUNC('month', r.date_seance) = DATE '2026-06-01'), 0) AS juin,
       COALESCE(SUM(r.montant) FILTER (WHERE DATE_TRUNC('month', r.date_seance) = DATE '2026-07-01'), 0) AS juillet,
       COALESCE(SUM(r.montant) FILTER (WHERE DATE_TRUNC('month', r.date_seance) = DATE '2026-08-01'), 0) AS aout,
       COALESCE(SUM(r.montant) FILTER (WHERE DATE_TRUNC('month', r.date_seance) = DATE '2026-09-01'), 0) AS septembre
FROM cours c
LEFT JOIN reservations r ON r.cours_id = c.id
GROUP BY c.categorie
ORDER BY c.categorie;

SELECT COUNT(*) AS jours_sans_activite
FROM generate_series(TIMESTAMP '2026-06-01', TIMESTAMP '2026-09-30', INTERVAL '1 day') j
LEFT JOIN reservations r ON r.date_seance = j::date
WHERE r.id IS NULL;

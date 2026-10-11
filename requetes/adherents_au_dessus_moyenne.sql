WITH depenses AS (
    SELECT a.id, a.nom, COALESCE(SUM(r.montant), 0) AS total
    FROM adherents a
    LEFT JOIN reservations r ON r.adherent_id = a.id
    GROUP BY a.id, a.nom
), moyenne AS (
    SELECT AVG(total) AS valeur FROM depenses
)
SELECT d.nom, d.total, ROUND(m.valeur, 2) AS moyenne_adherents
FROM depenses d
CROSS JOIN moyenne m
WHERE d.total > m.valeur
ORDER BY d.total DESC, d.id;

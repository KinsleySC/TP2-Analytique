WITH activite AS (
    SELECT co.id, co.nom, COUNT(r.id) AS reservations
    FROM coachs co
    LEFT JOIN cours c ON c.coach_id = co.id
    LEFT JOIN reservations r ON r.cours_id = c.id
    GROUP BY co.id, co.nom
), moyenne AS (
    SELECT AVG(reservations) AS valeur FROM activite
)
SELECT a.nom, a.reservations, ROUND(m.valeur, 2) AS moyenne_coachs
FROM activite a
CROSS JOIN moyenne m
WHERE a.reservations > m.valeur
ORDER BY a.reservations DESC, a.id;

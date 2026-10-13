CREATE OR REPLACE VIEW tableau_bord_ocoach AS
WITH bilan AS (
    SELECT c.categorie, COUNT(r.id) AS reservations,
            COALESCE(SUM(r.montant), 0) AS recettes,
            COALESCE(SUM(r.montant) FILTER (WHERE DATE_TRUNC('month', r.date_seance) = DATE '2026-08-01'), 0) AS aout,
            COALESCE(SUM(r.montant) FILTER (WHERE DATE_TRUNC('month', r.date_seance) = DATE '2026-09-01'), 0) AS septembre
    FROM cours c
    LEFT JOIN reservations r ON r.cours_id = c.id
    GROUP BY c.categorie
)
SELECT categorie, reservations, recettes,
        DENSE_RANK() OVER (ORDER BY recettes DESC) AS rang,
       ROUND(100.0 * recettes / NULLIF(SUM(recettes) OVER (), 0), 2) AS part_pct,
        aout, septembre,
       ROUND(100.0 * (septembre - aout) / NULLIF(aout, 0), 2) AS evolution_pct
FROM bilan
ORDER BY rang, categorie;

SELECT * FROM tableau_bord_ocoach ORDER BY rang, categorie;

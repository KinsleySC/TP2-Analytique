SELECT c.categorie, c.nom, COALESCE(SUM(r.montant), 0) AS recettes,
    DENSE_RANK() OVER (
        PARTITION BY c.categorie ORDER BY COALESCE(SUM(r.montant), 0) DESC
    ) AS rang
FROM cours c
LEFT JOIN reservations r ON r.cours_id = c.id
GROUP BY c.id, c.nom, c.categorie
ORDER BY c.categorie, rang, c.id;

WITH classement AS (
    SELECT c.id, c.categorie, c.nom, COUNT(r.id) AS reservations,
        ROW_NUMBER() OVER (
            PARTITION BY c.categorie ORDER BY COUNT(r.id) DESC, c.id
        ) AS rang
    FROM cours c
    LEFT JOIN reservations r ON r.cours_id = c.id
    GROUP BY c.id, c.categorie, c.nom
)
SELECT categorie, nom, reservations, rang
FROM classement
WHERE rang <= 3
ORDER BY categorie, rang;

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

SELECT c.categorie, SUM(r.montant) AS recettes,
       ROUND(100.0 * SUM(r.montant) / NULLIF(SUM(SUM(r.montant)) OVER (), 0), 2) AS part_pct
FROM reservations r
JOIN cours c ON c.id = r.cours_id
GROUP BY c.categorie
ORDER BY recettes DESC, c.categorie;

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

WITH RECURSIVE equipe AS (
    SELECT id, nom, manager_id, 0 AS niveau, nom::text AS chemin
    FROM coachs
    WHERE manager_id IS NULL
    UNION ALL
    SELECT c.id, c.nom, c.manager_id, e.niveau + 1, e.chemin || ' > ' || c.nom
    FROM coachs c
    JOIN equipe e ON c.manager_id = e.id
)
SELECT id, nom, manager_id, niveau, chemin
FROM equipe
ORDER BY chemin;

SELECT j::date AS jour, COUNT(r.id) AS reservations,
    COALESCE(SUM(r.montant), 0) AS recettes
FROM generate_series(
    TIMESTAMP '2026-06-01', TIMESTAMP '2026-09-30', INTERVAL '1 day'
) AS j
LEFT JOIN reservations r ON r.date_seance = j::date
GROUP BY j
ORDER BY j;

SELECT c.categorie,
    COALESCE(SUM(r.montant) FILTER (WHERE DATE_TRUNC('month', r.date_seance) = DATE '2026-06-01'), 0) AS juin,
    COALESCE(SUM(r.montant) FILTER (WHERE DATE_TRUNC('month', r.date_seance) = DATE '2026-07-01'), 0) AS juillet,
    COALESCE(SUM(r.montant) FILTER (WHERE DATE_TRUNC('month', r.date_seance) = DATE '2026-08-01'), 0) AS aout,
    COALESCE(SUM(r.montant) FILTER (WHERE DATE_TRUNC('month', r.date_seance) = DATE '2026-09-01'), 0) AS septembre
FROM cours c
LEFT JOIN reservations r ON r.cours_id = c.id
GROUP BY c.categorie
ORDER BY c.categorie;

SELECT CASE WHEN GROUPING(c.categorie) = 1 THEN 'Total general' ELSE c.categorie END AS categorie,
    CASE WHEN GROUPING(c.nom) = 1 THEN 'Tous les cours' ELSE c.nom END AS cours,
    COALESCE(SUM(r.montant), 0) AS recettes
FROM cours c
LEFT JOIN reservations r ON r.cours_id = c.id
GROUP BY ROLLUP(c.categorie, c.nom)
ORDER BY GROUPING(c.categorie), c.categorie, GROUPING(c.nom), c.nom;

SELECT COUNT(*) AS reservations,
    ROUND(AVG(montant), 2) AS moyenne,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY montant) AS mediane,
    MIN(montant) AS minimum, MAX(montant) AS maximum
FROM reservations;

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

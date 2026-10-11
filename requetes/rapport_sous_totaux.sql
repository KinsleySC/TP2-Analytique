SELECT CASE WHEN GROUPING(c.categorie) = 1 THEN 'Total general' ELSE c.categorie END AS categorie,
       CASE WHEN GROUPING(c.nom) = 1 THEN 'Tous les cours' ELSE c.nom END AS cours,
       COALESCE(SUM(r.montant), 0) AS recettes
FROM cours c
LEFT JOIN reservations r ON r.cours_id = c.id
GROUP BY ROLLUP(c.categorie, c.nom)
ORDER BY GROUPING(c.categorie), c.categorie, GROUPING(c.nom), c.nom;

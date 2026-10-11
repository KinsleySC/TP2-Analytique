SELECT c.categorie, c.nom, COALESCE(SUM(r.montant), 0) AS recettes,
       DENSE_RANK() OVER (
           PARTITION BY c.categorie ORDER BY COALESCE(SUM(r.montant), 0) DESC
       ) AS rang
FROM cours c
LEFT JOIN reservations r ON r.cours_id = c.id
GROUP BY c.id, c.nom, c.categorie
ORDER BY c.categorie, rang, c.id;

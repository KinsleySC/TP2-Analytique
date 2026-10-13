SELECT c.categorie, SUM(r.montant) AS recettes,
       ROUND(100.0 * SUM(r.montant) / NULLIF(SUM(SUM(r.montant)) OVER (), 0), 2) AS part_pct
FROM reservations r
JOIN cours c ON c.id = r.cours_id
GROUP BY c.categorie
ORDER BY recettes DESC, c.categorie;

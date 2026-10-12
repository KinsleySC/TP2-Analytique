SELECT COUNT(*) AS inscriptions_apres_seance
FROM reservations r
JOIN adherents a ON a.id = r.adherent_id
WHERE a.date_inscription > r.date_seance;

SELECT COUNT(*) AS montants_differents_du_tarif_initial
FROM reservations r
JOIN cours c ON c.id = r.cours_id
WHERE r.montant <> c.tarif;

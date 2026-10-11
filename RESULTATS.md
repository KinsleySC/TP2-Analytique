# Résultats et validation

Validation effectuée le 9 octobre 2026 sur PostgreSQL 18, dans une base locale dédiée aux essais. Les CSV sont des résultats d'exécution, pas des exemples inventés.

- schema.sql puis seed.sql : exécutés sans erreur.
- requetes.sql : les quatorze requêtes exécutées sans erreur.
- bonus.sql : vue créée, résultat identique à Q14.
- Rechargement complet : réussi ; toujours 183 réservations.
- Q02 : neuf résultats ; Q09 : quinze coachs, profondeur maximale 3.
- Q10 : 122 jours et 61 journées sans activité.
- Q12 : dix-neuf lignes et total égal à la somme des montants.
- Aucun commentaire SQL dans les fichiers livrés.
- Six erreurs attendues vérifiées : email déjà utilisé, montant négatif, adhérent inexistant, cycle hiérarchique, réservation en double, catégorie non autorisée. Les essais ont été annulés et n'ont pas modifié les données finales.

## Recettes mensuelles

| Mois | Recettes | Cumul | Évolution |
|---|---:|---:|---:|
| 2026-06-01 | 876,00 € | 876,00 € | Non définie |
| 2026-07-01 | 919,00 € | 1795,00 € | 4.91 % |
| 2026-08-01 | 876,00 € | 2671,00 € | -4.68 % |
| 2026-09-01 | 876,00 € | 3547,00 € | 0.00 % |

## Tableau de bord

| Catégorie | Réservations | Recettes | Part | Évolution septembre/août |
|---|---:|---:|---:|---:|
| Bien-etre | 61 | 1659,00 € | 46.77 % | 0.00 % |
| Renforcement | 62 | 964,00 € | 27.18 % | 0.00 % |
| Cardio | 60 | 924,00 € | 26.05 % | 0.00 % |

Tous les résultats Q01 à Q14 sont exportés dans resultats/. En cas de modification du jeu de données, ces fichiers et les interprétations du journal doivent être actualisés. Les tests de contraintes sont décrits ici ; verifications.sql contient uniquement des contrôles en lecture, sans provoquer d'erreur.

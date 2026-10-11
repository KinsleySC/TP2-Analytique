# Journal technique O'Coach

Document préparé avec l'aide d'un assistant IA. Les résultats ci-dessous ont été exécutés et vérifiés sur PostgreSQL 18. Les membres doivent les relire, les reproduire et ajouter leurs propres difficultés après leur travail. Ce document ne prétend pas décrire des séances de travail déjà réalisées par les quatre membres.

## Choix du modèle

Quatre tables suffisent au sujet. Les coachs portent la hiérarchie pour éviter une cinquième table. Les réservations portent la date et le montant. Le tarif est copié lors de l'insertion afin de conserver le prix effectivement payé. Les données sont déterministes : les comparaisons de résultats sont faciles à reproduire.

L'atelier bien-être coûte 90 € pour 120 minutes, contre 10 à 20 € pour les autres activités. Cela donne une valeur élevée plausible pour discuter de la médiane. La génération est pédagogique : trois réservations un jour sur deux, sans prétendre simuler fidèlement une vraie salle.

## Ce que les requêtes apprennent sur les données

- Q01 : les premiers par recettes sont Atelier bien-etre (Bien-etre), Boxe cardio (Cardio), Circuit force (Renforcement) ; un tarif élevé peut compenser un volume plus faible.
- Q02 : le top 3 retient neuf lignes, soit trois cours par catégorie ; à égalité de volume, l'identifiant départage les cours.
- Q03 : le cumul atteint 3547,00 € à la fin de septembre.
- Q04 : l'évolution de septembre par rapport à août est de 0.00 % ; juin n'a pas de période précédente.
- Q05 : Bien-etre représente la plus grande part des recettes, avec 46.77 %.
- Q06 : la moyenne mobile de septembre vaut 890,33 € et porte sur juillet, août et septembre.
- Q07 : 4 adhérents dépensent plus que la moyenne de 177,35 € calculée sur les vingt adhérents.
- Q08 : 3 coachs dépassent la moyenne de 12.20 réservations ; cela mesure le volume, pas leur compétence.
- Q09 : les quinze coachs sont présents dans l'arbre, répartis entre les niveaux 0 et 3.
- Q10 : la période compte 122 jours, dont 61 sans réservation ; ces jours apparaissent avec zéro réservation et zéro recette.
- Q11 : le tableau croisé permet de comparer les recettes des trois catégories sur les quatre mois ; les totaux mensuels correspondent à Q03.
- Q12 : le rapport contient quinze détails, trois sous-totaux et un total général de 3547,00 €.
- Q13 : la moyenne vaut 19,38 € et la médiane 15 €. La médiane représente mieux le prix habituel car les ateliers à 90 € tirent la moyenne vers le haut. La moyenne reste utile pour la recette par réservation.
- Q14 : Bien-etre est en tête des recettes avec 1659,00 € pour 61 réservations ; le tableau combine volume, classement, part et évolution.
- Bonus : la vue renvoie les mêmes trois lignes que Q14, avec une commande SELECT plus courte.

## Points techniques traités

Le filtre sur un rang est placé après la CTE, car les fenêtres ne sont pas disponibles dans WHERE au même niveau. Les divisions utilisent NULLIF pour éviter une division par zéro. Le calendrier emploie COUNT(r.id), et non COUNT(*), pour compter correctement les journées sans réservation.

La contrainte manager_id < id empêche les cycles sans ajouter une méthode hors programme. Cette convention est restrictive, mais facile à comprendre en B2. Les rôles de gestion et de coaching sont cumulables dans le modèle.

## Limites et suites possibles

Q03, Q04 et Q06 portent sur les mois ayant une activité ; tous les mois de ce jeu sont présents. Avec un mois entièrement vide, il faudrait compléter les mois avec generate_series avant LAG ou la moyenne mobile. Q11 et Q14 ciblent explicitement juin à septembre 2026.

Les cours constituent un catalogue : pas de table de créneaux, de capacité ou d'annulations. Une évolution de recettes ne prouve pas une évolution du nombre de clients. Les données fictives ne justifient aucune conclusion sur une vraie salle.

## À compléter par le groupe après sa relecture

Pour chaque membre, noter une requête expliquée sans aide, une difficulté réellement rencontrée, la correction appliquée et le résultat du test. Ne pas présenter les étapes proposées comme un historique de travail déjà réalisé.

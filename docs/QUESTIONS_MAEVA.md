# Questions et explications

## Q11 - Quelles recettes chaque catégorie réalise-t-elle chaque mois ?

Fichier : requetes/Q11_tableau_croise_mois.sql

FILTER limite chaque somme au mois de sa colonne. LEFT JOIN conserve les cours sans activité et COALESCE produit zéro si une catégorie n’a aucune recette sur un mois.

## Q12 - Quels sont les recettes par cours, les sous-totaux par catégorie et le total général ?

Fichier : requetes/Q12_rapport_sous_totaux.sql

ROLLUP produit les groupes catégorie/cours, catégorie seule, puis le total. GROUPING distingue les lignes de total et permet de les nommer proprement.

## Q13 - La moyenne ou la médiane représente-t-elle mieux le prix habituel d’une réservation ?

Fichier : requetes/Q13_moyenne_mediane.sql

AVG calcule la moyenne ; percentile_cont(0.5) cherche le centre de la distribution triée. Le tarif élevé de l’atelier bien-être tire la moyenne vers le haut. La médiane décrit mieux une réservation habituelle, tandis que la moyenne sert à calculer une recette moyenne par réservation.

## Q14 - Comment comparer les catégories selon leurs recettes, leur volume et leur évolution récente ?

Fichier : requetes/Q14_tableau_bord_direction.sql

La CTE bilan combine des agrégats et FILTER pour août et septembre. La sélection finale ajoute un classement et une part du total grâce aux fenêtres, puis la variation de septembre par rapport à août. Le rapport combine CTE, FILTER et fenêtres.


## Bonus

 - Réutiliser le tableau de bord

bonus.sql crée une vue à partir de Q14 puis l’interroge. Une vue classique stocke une requête, pas une copie figée des résultats. Elle reflète les données présentes au moment de sa lecture.

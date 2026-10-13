# Questions et explications

## 1 - Quels cours rapportent le plus dans chaque catégorie ?

classement_cours.sql

Le LEFT JOIN conserve les cours sans réservation. GROUP BY calcule les recettes par cours. DENSE_RANK recommence le classement dans chaque catégorie et conserve les égalités, sans saut de rang.

## 2 - Quels sont les trois cours les plus réservés par catégorie ?

top_trois_cours.sql

La CTE calcule le nombre de réservations puis ROW_NUMBER. L’identifiant du cours départage les égalités. La requête finale filtre les numéros 1 à 3 : exactement trois cours par catégorie dans ces données.

## 3 - Comment les recettes se cumulent-elles au fil des mois ?

recettes_cumulees.sql

La CTE regroupe les recettes par mois. SUM OVER ajoute chaque total mensuel aux précédents. Le cadre explicite va du début jusqu’au mois courant.

## 4 - Quel est le pourcentage d’évolution des recettes entre deux mois ?

evolution_mensuelle.sql

par_mois calcule les totaux. comparaison utilise ces totaux et LAG pour retrouver le mois précédent. La variation est divisée par la valeur précédente. NULLIF évite la division par zéro ; juin n’a pas de comparaison. Les quatre mois du jeu de données ont une activité.

## 5 - Quelle part des recettes représente chaque catégorie ?

part_categories.sql

GROUP BY produit trois totaux. SUM OVER sans partition additionne ces totaux. Le facteur 100.0 exprime la part en pourcentage ; un arrondi peut empêcher la somme affichée de faire exactement 100.

## 6 - Quelle est la moyenne des recettes sur le mois courant et les deux précédents ?

moyenne_mobile.sql

Après le regroupement par mois, AVG OVER utilise la ligne courante et les deux précédentes. En juin il n’y a qu’un mois et en juillet deux mois. Il s’agit des mois présents ; ce jeu ne comporte aucun mois entièrement vide.


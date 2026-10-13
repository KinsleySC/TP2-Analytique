# Questions métier et lecture des requêtes

Les requêtes sont dans l’ordre Q01 à Q14 dans requetes.sql. Chaque fichier du dossier requetes contient une seule requête. Les explications restent hors du code SQL, à la demande du groupe.

## Q01 - Quels cours rapportent le plus dans chaque catégorie ?

Fichier : requetes/classement_cours.sql

Le LEFT JOIN conserve les cours sans réservation. GROUP BY calcule les recettes par cours. DENSE_RANK recommence le classement dans chaque catégorie et conserve les égalités, sans saut de rang.

## Q02 - Quels sont les trois cours les plus réservés par catégorie ?

Fichier : requetes/top_trois_cours.sql

La CTE calcule le nombre de réservations puis ROW_NUMBER. L’identifiant du cours départage les égalités. La requête finale filtre les numéros 1 à 3 : exactement trois cours par catégorie dans ces données.

## Q03 - Comment les recettes se cumulent-elles au fil des mois ?

Fichier : requetes/recettes_cumulees.sql

La CTE regroupe les recettes par mois. SUM OVER ajoute chaque total mensuel aux précédents. Le cadre explicite va du début jusqu’au mois courant.

## Q04 - Quel est le pourcentage d’évolution des recettes entre deux mois ?

Fichier : requetes/evolution_mensuelle.sql

par_mois calcule les totaux. comparaison utilise ces totaux et LAG pour retrouver le mois précédent. La variation est divisée par la valeur précédente. NULLIF évite la division par zéro ; juin n’a pas de comparaison. Les quatre mois du jeu de données ont une activité.

## Q05 - Quelle part des recettes représente chaque catégorie ?

Fichier : requetes/part_categories.sql

GROUP BY produit trois totaux. SUM OVER sans partition additionne ces totaux. Le facteur 100.0 exprime la part en pourcentage ; un arrondi peut empêcher la somme affichée de faire exactement 100.

## Q06 - Quelle est la moyenne des recettes sur le mois courant et les deux précédents ?

Fichier : requetes/moyenne_mobile.sql

Après le regroupement par mois, AVG OVER utilise la ligne courante et les deux précédentes. En juin il n’y a qu’un mois et en juillet deux mois. Il s’agit des mois présents ; ce jeu ne comporte aucun mois entièrement vide.

## Q07 - Quels adhérents dépensent plus que la moyenne des adhérents ?

Fichier : requetes/adherents_au_dessus_moyenne.sql

depenses inclut tous les adhérents, même sans réservation. moyenne dépend de depenses. CROSS JOIN ajoute la moyenne unique à chaque total, puis WHERE retient les dépenses strictement supérieures.

## Q08 - Quels coachs ont plus de réservations que la moyenne des coachs ?

Fichier : requetes/coachs_au_dessus_moyenne.sql

activite compte les réservations de chaque coach, avec zéro pour ceux sans activité. moyenne dépend de activite. Le dernier SELECT compare chaque nombre à la moyenne de tous les coachs. Ce nombre mesure l’activité commerciale, pas la qualité pédagogique.

## Q09 - Quelle est la hiérarchie complète des coachs, avec niveau et chemin ?

Fichier : requetes/hierarchie_coachs.sql

L’ancrage sélectionne les responsables sans manager au niveau 0. La récursion cherche leurs enfants, ajoute un niveau et prolonge le chemin. La contrainte manager_id < id empêche les cycles, donc la récursion finit quand il n’y a plus d’enfant.

## Q10 - Quels jours n’ont aucune réservation sur la période étudiée ?

Fichier : requetes/jours_sans_activite.sql

generate_series construit chaque jour du 1er juin au 30 septembre. Le LEFT JOIN conserve les dates sans réservation. COUNT(r.id) vaut zéro pour ces dates ; COUNT(*) aurait compté la ligne vide. COALESCE remplace les recettes NULL par zéro.

## Q11 - Quelles recettes chaque catégorie réalise-t-elle chaque mois ?

Fichier : requetes/tableau_croise_mois.sql

FILTER limite chaque somme au mois de sa colonne. LEFT JOIN conserve les cours sans activité et COALESCE produit zéro si une catégorie n’a aucune recette sur un mois.

## Q12 - Quels sont les recettes par cours, les sous-totaux par catégorie et le total général ?

Fichier : requetes/rapport_sous_totaux.sql

ROLLUP produit les groupes catégorie/cours, catégorie seule, puis le total. GROUPING distingue les lignes de total et permet de les nommer proprement.

## Q13 - La moyenne ou la médiane représente-t-elle mieux le prix habituel d’une réservation ?

Fichier : requetes/moyenne_mediane.sql

AVG calcule la moyenne ; percentile_cont(0.5) cherche le centre de la distribution triée. Le tarif élevé de l’atelier bien-être tire la moyenne vers le haut. La médiane décrit mieux une réservation habituelle, tandis que la moyenne sert à calculer une recette moyenne par réservation.

## Q14 - Comment comparer les catégories selon leurs recettes, leur volume et leur évolution récente ?

Fichier : requetes/tableau_bord_direction.sql

La CTE bilan combine des agrégats et FILTER pour août et septembre. La sélection finale ajoute un classement et une part du total grâce aux fenêtres, puis la variation de septembre par rapport à août. Le rapport combine CTE, FILTER et fenêtres.

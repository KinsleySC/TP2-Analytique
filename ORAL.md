# Préparation de l'oral

Passage annoncé : mardi 13 octobre 2026. Prévoir 10 minutes de présentation puis 5 minutes de questions. Chaque membre doit comprendre toutes les requêtes.

| Temps | Personne | Contenu |
|---|---|---|
| 0:00 à 2:00 | Kinsley | Thème, quatre tables, clés et hiérarchie |
| 2:00 à 3:40 | Hugo | Démonstration Q02 : top 3 par catégorie |
| 3:40 à 5:20 | Jonathan | Démonstration Q09 : arbre des coachs |
| 5:20 à 7:00 | Maeva | Démonstration Q14 : tableau de bord |
| 7:00 à 9:00 | Tous, 30 secondes chacun | Choix, difficulté réellement rencontrée, solution, limite |
| 9:00 à 10:00 | Tous | Marge pour transitions et résultat principal |

Avant le passage, recharger schema.sql puis seed.sql dans la base dédiée et exécuter verifications.sql. Mesurer le chargement sur l'ordinateur de présentation pour vérifier l'objectif d'une minute. Garder ouvertes Q02, Q09 et Q14 ; leurs fichiers individuels évitent de chercher une requête dans un long script.

Pour chacune des trois démonstrations, annoncer la question métier, expliquer le principe, exécuter puis interpréter les colonnes et une ligne concrète. Les résultats de référence sont dans resultats/ et RESULTATS.md.

## Questions possibles

- GROUP BY réduit-il les lignes ? Oui, il regroupe. Une fenêtre ajoute un calcul aux lignes restantes.
- Pourquoi une CTE pour le top 3 ? Le rang est calculé avant d'être filtré dans la requête extérieure.
- Pourquoi ROW_NUMBER utilise-t-il l'identifiant ? Pour départager les égalités de façon stable.
- Comment finit la récursion ? Elle n'a plus d'enfants à ajouter ; la contrainte d'identifiants empêche les cycles.
- Pourquoi juin n'a-t-il pas d'évolution ? Il n'existe aucun mois précédent dans les données.
- Pourquoi NULLIF ? Une division par zéro devient une valeur NULL, qui signifie que l'évolution n'est pas définie.
- Pourquoi la médiane est-elle inférieure à la moyenne ? L'atelier à 90 € augmente la moyenne, mais ne représente pas le tarif central.
- Que stocke une vue ? La définition d'une requête, pas ses résultats figés.
- Pourquoi un chiffre d'affaires élevé ne suffit-il pas à dire qu'un cours est populaire ? Il dépend aussi du prix.

S'entraîner en échangeant les requêtes entre membres. Les difficultés annoncées à l'oral doivent être celles réellement rencontrées pendant votre relecture et vos essais.

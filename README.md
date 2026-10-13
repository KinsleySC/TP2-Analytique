# O'Coach

Projet d'analyse SQL pour une salle de sport.
Équipe : Kinsley, Hugo, Jonathan et Maeva.

O'Coach est une salle de sport fictive. Le projet analyse les réservations de séances payées à l'unité, les recettes et l'activité des coachs. Il ne modélise pas les abonnements.

Les données sont entièrement fictives. Chaque réservation correspond à une séance payée par un adhérent. Toutes les réservations sont confirmées ; le modèle ne gère pas les annulations ni les remboursements.


## Chargement

Utiliser PostgreSQL et une base dédiée vide appelée ocoach. Dans pgAdmin, créer la base, ouvrir l'outil de requête sur cette base, puis exécuter schema.sql et seed.sql dans cet ordre. Sélectionner ensuite la requête à tester dans requetes.sql et l'exécuter.

Avec psql installé et accessible dans le terminal :

```sh
createdb -U postgres ocoach
psql -U postgres -d ocoach -v ON_ERROR_STOP=1 -f schema.sql
psql -U postgres -d ocoach -v ON_ERROR_STOP=1 -f seed.sql
psql -U postgres -d ocoach -v ON_ERROR_STOP=1 -f requetes.sql
```

schema.sql supprime puis recrée uniquement les quatre tables et la vue du projet. Ne l'exécuter que dans la base dédiée au TP. seed.sql s'exécute après schema.sql ; il ne doit pas être rejoué seul.

## Schéma

| Table | Clé primaire | Liens | Rôle |
|---|---|---|---|
| coachs | id | manager_id vers coachs.id | Équipe et hiérarchie |
| adherents | id | Aucun | Clients inscrits |
| cours | id | coach_id vers coachs.id | Catalogue des activités |
| reservations | id | adherent_id vers adherents.id ; cours_id vers cours.id | Réservations et montants payés |

Un coach peut encadrer plusieurs coachs et plusieurs cours. Un cours a un seul coach. Un adhérent peut effectuer plusieurs réservations. Chaque réservation appartient à un seul adhérent et un seul cours.

Il y a 15 coachs, 20 adhérents, 15 cours et 183 réservations entre le 1er juin et le 29 septembre 2026. Les données sont créées avec `generate_series` et des calculs de restes de division. Le même chargement produit toujours les mêmes données. Une activité a lieu un jour sur deux pour rendre visibles les jours sans activité.

manager_id doit être inférieur à id : cette règle empêche les cycles dans la hiérarchie, mais limite le choix des identifiants. Les responsables encadrent aussi des cours.

Le montant est le prix payé, conservé même si le tarif du catalogue change.

Le modèle ne gère pas les créneaux, la capacité des cours ni les conflits d'horaires.

## Requêtes et documents

- requetes.sql : les quatorze requêtes, sans commentaires SQL.
- docs/QUESTIONS.md : question métier et explication de chaque requête.
- verifications.sql : contrôles de volume et de cohérence en lecture seule.
- bonus.sql : création et interrogation de la vue du tableau de bord ; à lancer après le chargement.


## Collaboration

Les explications sont dans docs/ et les contrôles dans controles/. Maeva rassemble les requêtes dans requetes.sql, les explications dans QUESTIONS.md et les contrôles dans verifications.sql après avoir récupéré les autres branches.

Les noms retenus pour les contrôles sont controles/kinsley.sql, controles/verification_recettes_categories.sql et controles/verification_dates_montants.sql.

Chacun relit et teste ses changements avant de les envoyer. Le plan de commits sert de guide ; il ne décrit pas à lui seul le travail déjà réalisé. Une branche peut contenir les commits récupérés des autres : pour compter les contributions, il faut regarder l'auteur de chaque commit.

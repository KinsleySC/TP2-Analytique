# O'Coach

Projet SQL analytique de niveau B2 informatique/cybersécurité.
Équipe : Kinsley, Hugo, Jonathan et Maeva.

O'Coach est une salle de sport fictive. Le projet analyse les réservations de séances payées à l'unité, les recettes et l'activité des coachs. Il ne modélise pas les abonnements.

Les données sont entièrement fictives. Une réservation représente une participation payée à une date de séance. Toutes les réservations sont confirmées ; il n'y a ni annulation ni remboursement dans ce modèle.

## Écarts à faire accepter par l'intervenant

Le sujet prévoit 2 ou 3 personnes ; cette version est répartie entre 4 personnes à la demande du groupe. Le sujet demande aussi des commentaires SQL : à la demande du groupe, le code n'en contient aucun. Les questions métier et explications sont dans QUESTIONS.md. Ce déplacement ne satisfait pas littéralement l'exigence de commentaires dans requetes.sql.

## Chargement

Utiliser PostgreSQL et une base dédiée vide appelée ocoach. Dans pgAdmin, créer la base, ouvrir l'outil de requête sur cette base, puis exécuter schema.sql et seed.sql dans cet ordre. Exécuter ensuite une requête à la fois depuis requetes.sql, ou depuis le dossier requetes.

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
| reservations | id | adherent_id vers adherents.id ; cours_id vers cours.id | Événements payants |

Un coach peut encadrer plusieurs coachs et plusieurs cours. Un cours a un seul coach. Un adhérent peut effectuer plusieurs réservations. Chaque réservation appartient à un seul adhérent et un seul cours.

Il y a 15 coachs, 20 adhérents, 15 cours et 183 réservations entre le 1er juin et le 29 septembre 2026. La génération utilise des restes de division et generate_series : les données sont identiques à chaque chargement. Une activité a lieu un jour sur deux pour rendre visibles les jours sans activité.

manager_id doit être inférieur à id : cette convention simple empêche les cycles dans la hiérarchie, mais limite le choix des identifiants. Les responsables encadrent aussi des cours. Le montant est le prix payé, conservé même si le tarif du catalogue change. Le modèle simplifie les créneaux et ne gère ni capacité ni conflits d'horaires.

## Requêtes et documents

- requetes.sql : les quatorze requêtes, dans l'ordre Q01 à Q14, sans commentaires SQL.
- requetes/ : une requête par fichier, identifiée par son numéro et son sujet.
- QUESTIONS.md : question métier et explication de chaque requête.
- JOURNAL.md : choix, limites et interprétations des résultats vérifiés.
- verifications.sql : contrôles de volume et de cohérence en lecture seule.
- bonus.sql : création et interrogation de la vue du tableau de bord ; à lancer après le chargement.
- RESULTATS.md et resultats/ : bilan des tests et exports CSV des résultats.
- ORAL.md et oral/ : déroulé et questions de préparation.
- CONFORMITE.md : correspondance avec les paliers du TP et écarts explicites.
- COMMITS.md : 40 étapes proposées, dix par membre.

Les noms Q01 à Q14 sont portés par les fichiers individuels. requetes.sql contient uniquement les instructions SQL correspondantes, séparées par une ligne vide.

## Collaboration

Utiliser exclusivement les lots V2 et ORGANISATION_PARALLELE_V2.txt. Les 40 commits alternent entre quatre branches personnelles, avec dix commits de travail par membre. Les dépendances communes sont partagées après K05, K09 et K10. Hugo puis Jonathan sont intégrés avant la validation finale de Maeva.

Les requêtes individuelles, les explications dans docs/ et les contrôles dans controles/ évitent les modifications concurrentes des fichiers consolidés. Maeva assemble requetes.sql, QUESTIONS.md et verifications.sql après réception des autres branches.

Les changements préparés doivent être relus et testés par leurs auteurs. Les ZIP ne contiennent pas d'historique Git préfabriqué. Une branche personnelle peut contenir les commits récupérés des collègues : le compteur par auteur doit rester de dix, pas le nombre total de commits visibles sur cette branche.

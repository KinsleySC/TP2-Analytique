DROP VIEW IF EXISTS tableau_bord_ocoach;
DROP TABLE IF EXISTS reservations;
DROP TABLE IF EXISTS cours;
DROP TABLE IF EXISTS adherents;
DROP TABLE IF EXISTS coachs;

CREATE TABLE coachs (
    id INTEGER PRIMARY KEY,
    nom VARCHAR(80) NOT NULL,
    manager_id INTEGER REFERENCES coachs(id),
    CHECK (manager_id IS NULL OR manager_id < id)
);

CREATE TABLE adherents (
    id INTEGER PRIMARY KEY,
    nom VARCHAR(80) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    date_inscription DATE NOT NULL
);

CREATE TABLE cours (
    id INTEGER PRIMARY KEY,
    nom VARCHAR(80) NOT NULL UNIQUE,
    categorie VARCHAR(30) NOT NULL CHECK (categorie IN ('Cardio', 'Renforcement', 'Bien-etre')),
    coach_id INTEGER NOT NULL REFERENCES coachs(id),
    duree_minutes INTEGER NOT NULL CHECK (duree_minutes BETWEEN 15 AND 120),
    tarif NUMERIC(8,2) NOT NULL CHECK (tarif > 0)
);

CREATE TABLE reservations (
    id INTEGER PRIMARY KEY,
    adherent_id INTEGER NOT NULL REFERENCES adherents(id),
    cours_id INTEGER NOT NULL REFERENCES cours(id),
    date_seance DATE NOT NULL,
    montant NUMERIC(8,2) NOT NULL CHECK (montant > 0),
    UNIQUE (adherent_id, cours_id, date_seance)
);

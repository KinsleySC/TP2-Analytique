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

CREATE DATABASE IF NOT EXISTS billetterie;
USE billetterie;

-- Utilisateurs
CREATE TABLE roles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role_id INT,
    FOREIGN KEY (role_id) REFERENCES roles(id)
);

-- Circuits
CREATE TABLE circuits (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    pays VARCHAR(100) NOT NULL
);

-- Écuries
CREATE TABLE ecuries (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL
);

-- Pilotes
CREATE TABLE pilotes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    ecurie_id INT,
    FOREIGN KEY (ecurie_id) REFERENCES ecuries(id)
);

-- Grand Prix
CREATE TABLE grand_prix (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    date DATE NOT NULL,
    circuit_id INT,
    FOREIGN KEY (circuit_id) REFERENCES circuits(id)
);

-- Tickets
CREATE TABLE tickets (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    grand_prix_id INT,
    quantite INT NOT NULL,
    date_achat TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (grand_prix_id) REFERENCES grand_prix(id)
);

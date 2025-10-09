CREATE DATABASE Homework_1;
USE Homework_1;

DROP TABLE if exists Tunnels;
CREATE TABLE Tunnels (
    line_id INT PRIMARY KEY AUTO_INCREMENT,
    line_name VARCHAR(30) NOT NULL UNIQUE,
    line_color VARCHAR(20) NOT NULL UNIQUE
);

DROP TABLE if exists Interchanges;
CREATE TABLE Interchanges (
    interchange_id INT PRIMARY KEY AUTO_INCREMENT,
    hub_name_1 VARCHAR(40) NOT NULL UNIQUE,
    hub_name_2 VARCHAR(40) NOT NULL UNIQUE
);

DROP TABLE if exists Stations;
CREATE TABLE Stations (
    station_id INT PRIMARY KEY AUTO_INCREMENT,
    station_name VARCHAR(40) NOT NULL UNIQUE,
    line_id INT,
    depth_meters INT,
    opening_year INT,
    interchange_id INT NULL
);

DROP TABLE if exists Architects;
CREATE TABLE Architects (
    architect_id INT PRIMARY KEY AUTO_INCREMENT,
    architect_name VARCHAR(50) NOT NULL
);

DROP TABLE if exists Station_architects;
CREATE TABLE Station_architects (
    station_id INT,
    architect_id INT
);
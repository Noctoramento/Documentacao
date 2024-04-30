CREATE DATABASE noctoramento;

USE NOCTORAMENTO;

CREATE TABLE EMPRESA (
IDEMPRESA INT PRIMARY KEY auto_increment NOT NULL,
CNPJ CHAR (14) NOT NULL,
RAZAOSOCIAL VARCHAR (100) NOT NULL,
EMAIL varchar (50) NOT NULL,
SENHA varchar (25) NOT NULL); 

select * from empresa;

CREATE TABLE COMPONENTES (
IDCOMPONENTES INT primary key auto_increment not null,
DiscoTempoAtividade varchar (45),
MemoriaDisponivel varchar(45),
MemoriaUtilizada varchar(45),
CPUNome varchar (45),
JanelasEmUso varchar(45)
);

select * from COMPONENTES;











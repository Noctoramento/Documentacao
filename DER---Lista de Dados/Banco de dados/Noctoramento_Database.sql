-- Criação e Uso do Banco de Dados
CREATE DATABASE Noctoramento;
USE Noctoramento;

-- Apagar o banco de dados:
DROP DATABASE Noctoramento;

-- Criação das tabelas:

CREATE TABLE Empresa (
idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
razaoSocial VARCHAR(45) NOT NULL,
cnpjEmpresa CHAR(14) NOT NULL,
email VARCHAR(45) NOT NULL,
senha VARCHAR(45) NOT NULL
);

CREATE TABLE Cargo (
idCargo INT PRIMARY KEY AUTO_INCREMENT,
nomeCargo VARCHAR(45) UNIQUE NOT NULL
);

-- Inserindo cargos para melhor gerenciamento da empresa:
INSERT INTO Cargo (nomeCargo) VALUES ('CEO');
INSERT INTO Cargo (nomeCargo) VALUES ('Gestor');
INSERT INTO Cargo (nomeCargo) VALUES ('Gerente');
INSERT INTO Cargo (nomeCargo) VALUES ('Analista');
INSERT INTO Cargo (nomeCargo) VALUES ('Desenvolvedor');
INSERT INTO Cargo (nomeCargo) VALUES ('Estagiário');
INSERT INTO Cargo (nomeCargo) VALUES ('Suporte');

CREATE TABLE Usuario (
idUsuario INT AUTO_INCREMENT,
nomeUsuario VARCHAR(45) NOT NULL,
emailUsuario VARCHAR(45) NOT NULL,
senhaUsuario VARCHAR(45),
fkEmpresa INT NOT NULL,
fkCargo INT NOT NULL,
CONSTRAINT fkEmpresa FOREIGN KEY (fkEmpresa) REFERENCES Empresa (idEmpresa),
CONSTRAINT fkCargo FOREIGN KEY (fkCargo) REFERENCES Cargo (idCargo),
PRIMARY KEY (idUsuario, fkEmpresa));

CREATE TABLE Notebook(
idNotebook INT AUTO_INCREMENT,
numeroSerie VARCHAR(45) NOT NULL,
marca VARCHAR(45) NOT NULL,
fkEmpresa INT NOT NULL,
CONSTRAINT fkEmpresaNotebook FOREIGN KEY (fkEmpresa) REFERENCES Empresa (idEmpresa),
PRIMARY KEY (idNotebook, fkEmpresa));

CREATE TABLE InfoNotebook(
idInfoNotebook INT AUTO_INCREMENT,
fabricante VARCHAR(45) NOT NULL,
modelo VARCHAR(45) NOT NULL,
sistemaOperacional VARCHAR(45),
processador VARCHAR(45),
capacidadeMaxCpu DOUBLE,
maxDisco DOUBLE,
maxMemoriaRam DOUBLE,
fkNotebook INT NOT NULL,
fkEmpresa INT NOT NULL,
CONSTRAINT fkEmpresaInfoNotebook FOREIGN KEY (fkEmpresa) REFERENCES Empresa (idEmpresa),
CONSTRAINT fkNotebook FOREIGN KEY (fkNotebook) REFERENCES Notebook (idNotebook),
PRIMARY KEY (idInfoNotebook, fkEmpresa, fkNotebook)
);

CREATE TABLE Alocacao(
dataUsoInicio DATE NOT NULL,
dataUsoFim DATE,
fkNotebook INT NOT NULL,
fkEmpresaNotebook INT NOT NULL,
fkUsuario INT NOT NULL,
fkEmpresaUsuario INT NOT NULL,
CONSTRAINT fkNotebookAlocacao FOREIGN KEY (fkNotebook) REFERENCES Notebook (idNotebook),
CONSTRAINT fkEmpresaNotebookAlocacao FOREIGN KEY (fkEmpresaNotebook) REFERENCES Notebook (fkEmpresa),
CONSTRAINT fkUsuarioAlocacao FOREIGN KEY (fkUsuario) REFERENCES Usuario (idUsuario),
CONSTRAINT fkEmpresaUsuarioAlocacao FOREIGN KEY (fkEmpresaUsuario) REFERENCES Usuario (fkEmpresa),
PRIMARY KEY (fkNotebook, fkEmpresaNotebook, fkUsuario, fkEmpresaUsuario));

CREATE TABLE ParametrosLimite(
idParametrosLimite INT AUTO_INCREMENT,
urgenteUsoCpu DOUBLE,
urgenteUsoDisco DOUBLE,
urgenteUsoMemoriaRam DOUBLE,
alertaUsoCpu DOUBLE,
alertaUsoDisco DOUBLE,
alertaUsoMemoriaRam DOUBLE,
fkEmpresa INT NOT NULL,
CONSTRAINT fkEmpresaParametrosLimite FOREIGN KEY (fkEmpresa) REFERENCES Empresa (idEmpresa),
PRIMARY KEY (idParametrosLimite, fkEmpresa));

CREATE TABLE RegistroUsoNotebook(
idRegistroUsoNotebook INT AUTO_INCREMENT,
usoCpu DOUBLE,
usoDisco DOUBLE,
tempoAtividadeDisco DOUBLE,
usoMemoriaRam DOUBLE,
qtdJanelasEmUso INT,
dtHoraCaptura DATETIME,
fkNotebook INT NOT NULL,
fkEmpresa INT NOT NULL,
CONSTRAINT fkNotebookRegistroUsoNotebook FOREIGN KEY (fkNotebook) REFERENCES Notebook (idNotebook),
CONSTRAINT fkEmpresaRegistroUsoNotebook FOREIGN KEY (fkEmpresa) REFERENCES Notebook (fkEmpresa),
PRIMARY KEY (idRegistroUsoNotebook, fkNotebook, fkEmpresa)
);

CREATE TABLE Alerta(
fkRegistroUsoNotebook INT NOT NULL,
fkNotebook INT NOT NULL,
fkEmpresaNotebook INT NOT NULL,
fkParametrosLimite INT NOT NULL,
fkEmpresaParametrosLimite INT NOT NULL,
dtHoraAlerta DATETIME,
CONSTRAINT fkRegistroUsoNotebookAlerta FOREIGN KEY (fkRegistroUsoNotebook) REFERENCES RegistroUsoNotebook (idRegistroUsoNotebook),
CONSTRAINT fkNotebookAlerta FOREIGN KEY (fkNotebook) REFERENCES Notebook (idNotebook),
CONSTRAINT fkEmpresaNotebookAlerta FOREIGN KEY (fkEmpresaNotebook) REFERENCES Notebook (fkEmpresa),
CONSTRAINT fkParametrosLimiteAlerta FOREIGN KEY (fkParametrosLimite) REFERENCES ParametrosLimite (idParametrosLimite),
CONSTRAINT fkEmpresaParametrosLimiteAlerta FOREIGN KEY (fkEmpresaParametrosLimite) REFERENCES ParametrosLimite (fkEmpresa),
PRIMARY KEY (fkRegistroUsoNotebook, fkNotebook, fkEmpresaNotebook, fkParametrosLimite, fkEmpresaParametrosLimite)
);

-- Apagar o banco de dados:
DROP DATABASE Noctoramento;
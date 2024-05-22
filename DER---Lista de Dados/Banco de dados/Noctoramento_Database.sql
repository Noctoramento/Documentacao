-- Criação e Uso do Banco de Dados
CREATE DATABASE Noctoramento;
USE Noctoramento;

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
sistemaOperacional VARCHAR(45) NOT NULL,
processador VARCHAR(45) NOT NULL,
fkNotebook INT NOT NULL,
fkEmpresa INT NOT NULL,
CONSTRAINT fkEmpresaInfoNotebook FOREIGN KEY (fkEmpresa) REFERENCES Empresa (idEmpresa),
CONSTRAINT fkNotebook FOREIGN KEY (fkNotebook) REFERENCES Notebook (idNotebook),
PRIMARY KEY (idInfoNotebook, fkEmpresa, fkNotebook)
);

-- Daqui para baixo, será necessário atualizar!

CREATE TABLE Alocacao(
dataUsoInicio DATE NOT NULL,
dataUsoFim DATE,
fkNotebook INT NOT NULL,
fkInfoNotebook INT NOT NULL,
fkEmpresaNotebook INT NOT NULL,
fkUsuario INT NOT NULL,
fkEmpresaUsuario INT NOT NULL,
CONSTRAINT fkNotebook FOREIGN KEY (fkNotebook) REFERENCES Notebook (idNotebook),
CONSTRAINT fkInfoNotebookAlocacao FOREIGN KEY (fkInfoNotebook) REFERENCES InfoNotebook (idInfoNotebook),
CONSTRAINT fkEmpresaNotebookAlocacao FOREIGN KEY (fkEmpresaNotebook) REFERENCES Empresa (idEmpresa),
CONSTRAINT fkUsuario FOREIGN KEY (fkUsuario) REFERENCES Usuario (idUsuario),
CONSTRAINT fkEmpresaUsuario FOREIGN KEY (fkEmpresaUsuario) REFERENCES Empresa (idEmpresa),
PRIMARY KEY (fkNotebook, fkInfoNotebook, fkEmpresaNotebook, fkUsuario, fkEmpresaUsuario));

CREATE TABLE ParametrosLimite(
idParametrosLimite INT AUTO_INCREMENT,
maxUsoCpu DOUBLE,
maxTempoUsoDisco DOUBLE,
maxUsoMemoriaRam DOUBLE,
fkEmpresa INT NOT NULL,
CONSTRAINT fkEmpresaParametrosLimite FOREIGN KEY (fkEmpresa) REFERENCES Empresa (idEmpresa),
PRIMARY KEY (idParametrosLimite, fkEmpresa));

CREATE TABLE RegistroUsoNotebook(
idRegistroUsoNotebook INT AUTO_INCREMENT,
usoCpu DOUBLE,
tempoAtividadeDisco DOUBLE,
usoMemoria DOUBLE,
qtdJanelasEmUso INT,
dtHoraCaptura DATETIME,
fkNotebook INT NOT NULL,
fkInfoNotebook INT NOT NULL,
CONSTRAINT fkNotebookRegistroUsoNotebook FOREIGN KEY (fkNotebook) REFERENCES Notebook (idNotebook),
CONSTRAINT fkInfoNotebookRegistroUsoNotebook FOREIGN KEY (fkInfoNotebook) REFERENCES InfoNotebook (idInfoNotebook),
PRIMARY KEY (idRegistroUsoNotebook, fkNotebook, fkInfoNotebook)
);

CREATE TABLE Alerta(
fkParametrosLimite INT NOT NULL,
fkEmpresa INT NOT NULL,
fkRegistroUsoNotebook INT NOT NULL,
fkNotebook INT NOT NULL,
fkInfoNotebook INT NOT NULL,
dtHora DATETIME,
CONSTRAINT fkParametrosLimiteAlerta FOREIGN KEY (fkParametrosLimite) REFERENCES ParametrosLimite (idParametrosLimite),
CONSTRAINT fkEmpresaAlerta FOREIGN KEY (fkEmpresa) REFERENCES Empresa (idEmpresa),
CONSTRAINT fkRegistroUsoNotebookAlerta FOREIGN KEY (fkRegistroUsoNotebook) REFERENCES RegistroUsoNotebook (idRegistroUsoNotebook),
CONSTRAINT fkNotebookAlerta FOREIGN KEY (fkNotebook) REFERENCES Notebook (idNotebook),
CONSTRAINT fkInfoNotebookAlerta FOREIGN KEY (fkInfoNotebook) REFERENCES InfoNotebook (idInfoNotebook),
PRIMARY KEY (fkParametrosLimite, fkEmpresa, fkRegistroUsoNotebook, fkNotebook, fkInfoNotebook)
);
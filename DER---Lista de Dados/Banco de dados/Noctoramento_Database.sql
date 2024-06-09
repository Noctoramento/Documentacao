-- Criação e Uso do Banco de Dados
CREATE DATABASE Noctoramento;
USE Noctoramento;

-- Apagar o banco de dados:
DROP DATABASE Noctoramento;

-- Criação das tabelas:

CREATE TABLE Empresa (
idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
razaoSocial VARCHAR(45),
cnpjEmpresa CHAR(14),
email VARCHAR(45),
senha VARCHAR(45)
);

-- SELECT * FROM Empresa;

-- INSERT INTO Empresa (razaoSocial, cnpjEmpresa, email, senha) 
-- VALUES ('Noctoramento', '12345678000195', 'contato@noctoramento.com', 'urubu100');

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

-- SELECT * FROM Cargo;

CREATE TABLE Usuario (
idUsuario INT AUTO_INCREMENT,
nomeUsuario VARCHAR(45),
emailUsuario VARCHAR(45),
senhaUsuario VARCHAR(45),
fkEmpresa INT,
fkCargo INT,
CONSTRAINT fkEmpresa FOREIGN KEY (fkEmpresa) REFERENCES Empresa (idEmpresa),
CONSTRAINT fkCargo FOREIGN KEY (fkCargo) REFERENCES Cargo (idCargo),
PRIMARY KEY (idUsuario, fkEmpresa));

-- SELECT * FROM Usuario;

-- INSERT INTO Usuario (nomeUsuario, emailUsuario, senhaUsuario, fkEmpresa) VALUES
-- ('Pedro', 'pedro@gmail.com', '123456789', 1);

-- INSERT INTO Usuario (nomeUsuario, emailUsuario, senhaUsuario, fkEmpresa) VALUES
-- ('Aarthur', 'arthur@gmail.com', '123456789', 1);

-- INSERT INTO Usuario (nomeUsuario, emailUsuario, senhaUsuario, fkEmpresa) VALUES
-- ('Vitinho', 'vitinho.nunes@gmail.com', '123456789', 1);

-- SELECT fkEmpresa FROM Usuario WHERE idUsuario = 1;

CREATE TABLE Notebook(
idNotebook INT AUTO_INCREMENT,
numeroSerie VARCHAR(45),
fabricante VARCHAR(45),
modelo VARCHAR(45),
dtRegistro TIMESTAMP DEFAULT NOW(),
fkEmpresa INT,
CONSTRAINT fkEmpresaNotebook FOREIGN KEY (fkEmpresa) REFERENCES Empresa (idEmpresa),
PRIMARY KEY (idNotebook, fkEmpresa));

-- INSERT INTO Notebook (numeroSerie, fabricante, modelo, fkEmpresa) VALUES
-- (1234566, "fabricante", "modelo", 1);

-- SELECT * FROM Notebook WHERE idNotebook = 1;

-- SELECT * FROM Notebook;

CREATE TABLE InfoNotebook(
idInfoNotebook INT AUTO_INCREMENT,
sistemaOperacional VARCHAR(45),
processador VARCHAR(45),
capacidadeMaxCpu DOUBLE,
maxDisco DOUBLE,
maxMemoriaRam DOUBLE,
fkNotebook INT,
fkEmpresa INT,
CONSTRAINT fkEmpresaInfoNotebook FOREIGN KEY (fkEmpresa) REFERENCES Empresa (idEmpresa),
CONSTRAINT fkNotebook FOREIGN KEY (fkNotebook) REFERENCES Notebook (idNotebook),
PRIMARY KEY (idInfoNotebook, fkEmpresa, fkNotebook)
);

-- SELECT * FROM InfoNotebook;

CREATE TABLE Alocacao(
dataUsoInicio DATE,
dataUsoFim DATE,
fkNotebook INT,
fkEmpresaNotebook INT,
fkUsuario INT,
fkEmpresaUsuario INT,
CONSTRAINT fkNotebookAlocacao FOREIGN KEY (fkNotebook) REFERENCES Notebook (idNotebook),
CONSTRAINT fkEmpresaNotebookAlocacao FOREIGN KEY (fkEmpresaNotebook) REFERENCES Notebook (fkEmpresa),
CONSTRAINT fkUsuarioAlocacao FOREIGN KEY (fkUsuario) REFERENCES Usuario (idUsuario),
CONSTRAINT fkEmpresaUsuarioAlocacao FOREIGN KEY (fkEmpresaUsuario) REFERENCES Usuario (fkEmpresa),
PRIMARY KEY (fkNotebook, fkEmpresaNotebook, fkUsuario, fkEmpresaUsuario));

-- INSERT INTO Alocacao (fkNotebook, fkEmpresaNotebook, fkUsuario, fkEmpresaUsuario) VALUES (1, 1, 1, 1);
-- SELECT fkNotebook FROM Alocacao WHERE fkUsuario = 1 AND fkEmpresaUsuario = 1;

CREATE TABLE Parametros(
idParametros INT AUTO_INCREMENT,
tempoSegCapturaDeDados INT,
tempoSegAlertas INT,
urgenteUsoCpu DOUBLE,
urgenteUsoDisco DOUBLE,
urgenteUsoMemoriaRam DOUBLE,
alertaUsoCpu DOUBLE,
alertaUsoDisco DOUBLE,
alertaUsoMemoriaRam DOUBLE,
fkEmpresa INT,
CONSTRAINT fkEmpresaParametros FOREIGN KEY (fkEmpresa) REFERENCES Empresa (idEmpresa),
PRIMARY KEY (idParametros, fkEmpresa));

-- INSERT INTO Parametros (tempoSegCapturaDeDados, tempoSegAlertas, urgenteUsoCpu, urgenteUsoDisco, urgenteUsoMemoriaRam,
--    alertaUsoCpu, alertaUsoDisco, alertaUsoMemoriaRam, fkEmpresa) VALUES (60, 120, 90.5, 85.0, 92.3, 1.0, 1.5, 2.0, 1);

-- SELECT * FROM Parametros;
-- SELECT * FROM Parametros WHERE fkEmpresa = 1;

CREATE TABLE RegistroUsoNotebook(
idRegistroUsoNotebook INT AUTO_INCREMENT,
usoCpu DOUBLE,
usoDisco DOUBLE,
tempoAtividadeDisco VARCHAR(45),
usoMemoriaRam DOUBLE,
qtdJanelasEmUso INT,
dtHoraCaptura DATETIME,
fkNotebook INT,
fkEmpresa INT,
CONSTRAINT fkNotebookRegistroUsoNotebook FOREIGN KEY (fkNotebook) REFERENCES Notebook (idNotebook),
CONSTRAINT fkEmpresaRegistroUsoNotebook FOREIGN KEY (fkEmpresa) REFERENCES Notebook (fkEmpresa),
PRIMARY KEY (idRegistroUsoNotebook, fkNotebook, fkEmpresa)
);

-- SELECT * FROM RegistroUsoNotebook order by idRegistroUsoNotebook desc;

CREATE TABLE Alerta(
idAlerta INT AUTO_INCREMENT,
fkParametros INT,
fkEmpresaParametros INT,
dtHoraAlerta TIMESTAMP DEFAULT NOW(),
CONSTRAINT fkParametrosAlerta FOREIGN KEY (fkParametros) REFERENCES Parametros (idParametros),
CONSTRAINT fkEmpresaParametrosAlerta FOREIGN KEY (fkEmpresaParametros) REFERENCES Parametros (fkEmpresa),
PRIMARY KEY (idAlerta, fkParametros, fkEmpresaParametros)
);

-- SELECT * FROM Alerta;
-- INSERT INTO Alerta (fkParametros, fkEmpresaParametros) VALUES (1, 1);

-- Apagar o banco de dados:
-- DROP DATABASE Noctoramento;
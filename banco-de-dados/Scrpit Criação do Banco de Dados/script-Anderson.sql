CREATE DATABASE TIL_ICE;
USE TIL_ICE;

CREATE TABLE Usuario (
    idUsuario INT PRIMARY KEY AUTO_INCREMENT,
    nome_usuario VARCHAR(45) NOT NULL,
    email VARCHAR(45) NOT NULL UNIQUE,
    nome_completo VARCHAR(45) NOT NULL,
    senha VARCHAR(45) NOT NULL,
    cpf CHAR(11) NOT NULL UNIQUE,
    dtCadastro_Usuario DATETIME DEFAULT CURRENT_TIMESTAMP(),
    fkChefe INT,
    CONSTRAINT ctEmail CHECK (email LIKE '%@%' AND email LIKE '%.%')
);

ALTER TABLE Usuario
ADD CONSTRAINT ctFkChefe FOREIGN KEY (fkChefe) REFERENCES Usuario(idUsuario);

CREATE TABLE Empresa (
    idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
    nome_empresa VARCHAR(45) NOT NULL,
    cnpj VARCHAR(14) UNIQUE NOT NULL,
    dtCadastro_Empresa DATETIME DEFAULT CURRENT_TIMESTAMP(),
    fkUsuario INT,
    CONSTRAINT ctFkUsuario FOREIGN KEY (fkUsuario) REFERENCES Usuario(idUsuario)
);

CREATE TABLE Container (
    idContainer INT PRIMARY KEY AUTO_INCREMENT,
    codigo_sensor VARCHAR(20) NOT NULL,
    dtContainer DATETIME DEFAULT CURRENT_TIMESTAMP(),
    fkEmpresa INT,
    CONSTRAINT ctFkEmpresa FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa)
);

CREATE TABLE Registro (
    idRegistro INT PRIMARY KEY AUTO_INCREMENT,
    temperatura DECIMAL(5,2),
    umidade DECIMAL(5,2),
    dtRegistro DATETIME DEFAULT CURRENT_TIMESTAMP(),
    fkContainer INT,
    CONSTRAINT ctFkContainer FOREIGN KEY (fkContainer) REFERENCES Container(idContainer)
);

INSERT INTO Usuario (nome_usuario, email, nome_completo, senha, cpf) VALUES
('joao_silva', 'joao@Empresa.com', 'João Silva', '@Senha123', '12345678901'),
('maria_souza', 'maria@Empresa.com', 'Maria Souza', '@Senha456', '23456789012');

UPDATE Usuario SET fkChefe = NULL WHERE idUsuario IN (1, 2);

INSERT INTO Usuario (nome_usuario, email, nome_completo, senha, cpf, fkChefe) VALUES
('carlos_alberto', 'carlos@Empresa.com', 'Carlos Alberto', '@Senha789', '34567890123', 1),
('ana_pereira', 'ana@Empresa.com', 'Ana Pereira', '@Senha321', '45678901234', 1),
('lucas_martins', 'lucas@Empresa.com', 'Lucas Martins', '@Senha654', '56789012345', 2),
('fernanda_costa', 'fernanda@Empresa.com', 'Fernanda Costa', '@Senha987', '67890123456', 2);

INSERT INTO Empresa (nome_empresa, cnpj, fkUsuario) VALUES
('GeneSeas', '04459073000105', 1),
('Brazilian Fish', '33628460000118', 2),
('Cristalina Pescados', '10666522000180', 1),
('Maersk Line Brasil', '03598524000114', 2);

INSERT INTO Container (codigo_sensor, fkEmpresa) VALUES
('CONT-A100', 1),
('CONT-B200', 1),
('CONT-C300', 2),
('CONT-BA15', 2),
('CONT-A234', 3),
('CONT-F029', 4);

INSERT INTO Registro (temperatura, umidade, fkContainer) VALUES
(22.50, 60.00, 1),
(-5.20, 15.30, 2),
(18.00, 45.50, 3),
(9.50, 13.40, 4),
(-11.83, 22.30, 5),
(27.31, 65.50, 6);

-- Exibindo Usuarios e seus chefes
SELECT
    f.nome_completo AS 'Funcionário',
    f.email AS 'Email',
    IFNULL(c.nome_completo, 'Não possui Chefe') AS 'Chefe'
FROM Usuario AS f
LEFT JOIN Usuario AS c ON f.fkChefe = c.idUsuario;

-- Exibindo todos os dados do sistema (registro, container, empresa e usuário)

SELECT
    u.nome_completo AS 'Responsável',
    u.email AS 'Email do Responsável',
    IFNULL(ch.nome_completo, 'Sem Chefe') AS 'Chefe',
    e.nome_empresa AS 'Empresa',
    e.cnpj AS 'CNPJ',
    c.codigo_sensor AS 'Código do Container',
    c.dtContainer AS 'Data de Chegada do Container',
    r.temperatura AS 'Temperatura',
    r.umidade AS 'Umidade',
    r.dtRegistro AS 'Data do Registro',
    CASE
        WHEN r.temperatura < 0 THEN 'Temperatura Negativa'
        WHEN r.temperatura BETWEEN 0 AND 10 THEN 'Temperatura Baixa'
        WHEN r.temperatura BETWEEN 10 AND 25 THEN 'Temperatura Normal'
        ELSE 'Temperatura Alta'
    END AS 'Status da Temperatura',
    CASE
        WHEN r.umidade < 30 THEN 'Umidade Baixa'
        WHEN r.umidade BETWEEN 30 AND 60 THEN 'Umidade Normal'
        ELSE 'Umidade Alta'
    END AS 'Status da Umidade'
FROM Registro AS r
JOIN Container AS c ON r.fkContainer = c.idContainer
JOIN Empresa AS e ON c.fkEmpresa = e.idEmpresa
JOIN Usuario AS u ON e.fkUsuario = u.idUsuario
LEFT JOIN Usuario AS ch ON u.fkChefe = ch.idUsuario
ORDER BY r.dtRegistro;
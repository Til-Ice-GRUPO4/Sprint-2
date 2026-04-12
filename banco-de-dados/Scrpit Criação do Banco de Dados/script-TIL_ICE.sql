-- Criando  o banco de dados
CREATE DATABASE TIL_ICE;
-- Usando o banco de dados 
USE TIL_ICE;
-- Criando a tabela 'empresa'
CREATE TABLE empresa (
	id_empresa INT PRIMARY KEY AUTO_INCREMENT,
	nome_empresa VARCHAR(45) NOT NULL,
	cnpj VARCHAR(20) UNIQUE NOT NULL,
	dt_cadastro_empresa DATETIME DEFAULT CURRENT_TIMESTAMP()
);

-- Criando a tabela 'usuario'
CREATE TABLE usuario (
	id_usuario INT PRIMARY KEY AUTO_INCREMENT,
	nome_usuario VARCHAR(45),
	email VARCHAR(45),
	nome_completo VARCHAR(150),
	senha VARCHAR(45),
	cpf CHAR(11),
	dt_cadastro_usuario DATETIME,
	adm TINYINT,
	fk_empresa INT,
	CONSTRAINT ctfkEmpresa FOREIGN KEY(fk_empresa) REFERENCES empresa(id_empresa)
);

-- Criando a tabela 'lote'

CREATE TABLE lote(
	id_lote INT PRIMARY KEY AUTO_INCREMENT,
    codigo_lote VARCHAR(45),
    dt_transporte_inicio DATETIME DEFAULT CURRENT_TIMESTAMP(),
    dt_transporte_final DATETIME DEFAULT CURRENT_TIMESTAMP()    
);

-- Criando a tabela 'container'
CREATE TABLE container (
	id_container INT PRIMARY KEY AUTO_INCREMENT,
	apelido VARCHAR(45),
	dt_cadastro_container DATETIME,
    fk_lote INT,
    CONSTRAINT ctklote FOREIGN KEY(fk_lote) REFERENCES lote(id_lote),
	fk_empresa INT,
	CONSTRAINT ctfkContainer_Empresa FOREIGN KEY(fk_empresa) REFERENCES empresa(id_empresa)
);

CREATE TABLE sensor(
	id_sensor INT PRIMARY KEY AUTO_INCREMENT,
	apelido VARCHAR(45),
	codigo_sensor VARCHAR(45),
	dt_cadastro_sensor DATETIME DEFAULT CURRENT_TIMESTAMP(),
	fk_container INT,
	CONSTRAINT ctfkContainer FOREIGN KEY(fk_container) REFERENCES container(id_container)
);
    
-- Criando a tabela 'registro'
CREATE TABLE registro (
	id_registro INT PRIMARY KEY AUTO_INCREMENT,
	temperatura DECIMAL(5,2),
	umidade DECIMAL(5,2),
	dt_registro DATETIME DEFAULT CURRENT_TIMESTAMP(),
	fk_sensor INT,
	CONSTRAINT ctfk_sensor FOREIGN KEY (fk_sensor) REFERENCES sensor(id_sensor)
);

-- Dados inseridos mockados para simulação
-- Inserindo registros a tabela 'empresa'
INSERT INTO empresa (nome_empresa, cnpj) VALUES
	('GeneSeas', '04459073000105'),
	('Brazilian Fish', '33628460000118');
    
-- Inserindo registros a tabela 'usuario'
INSERT INTO usuario (nome_usuario, email, nome_completo, senha, cpf, adm, fk_empresa) VALUES
    ('chefe1', 'chefe1@empresa.com', 'Chefe 1', '@Senha242', '12345678901', 1, 1),
    ('chefe2', 'chefe2@empresa.com', 'Chefe 2', '@Senha243', '12345678902', 1, 1),
    ('funcionario1', 'funcionario1@empresa.com', 'Funcionario 1', '@Senha241','12345678903', 0, 1),
    ('funcionario2', 'funcionario2@empresa.com', 'Funcionario 2', '@Senha244','12345678904', 0, 1),
    ('funcionario3', 'funcionario3@empresa.com', 'Funcionario 3', '@Senha267','12345678907', 0, 2),
    ('funcionario4', 'funcionario4@empresa.com', 'Funcionario 4', '@Senha2','12345678909', 0, 2);
    
-- 1. Inserindo registros na tabela 'lote'
INSERT INTO lote (codigo_lote, dt_transporte_inicio, dt_transporte_final) VALUES
	('BRFISH-TIL-2024-001', '2024-04-01 08:00:00', '2024-04-03 14:00:00'),
	('BRFISH-TIL-2024-002', '2024-04-02 10:30:00', '2024-04-04 16:20:00'),
	('GENES-TIL-2024-055', '2024-04-01 07:45:00', '2024-04-02 20:00:00'),
	('GENES-TIL-2024-056', '2024-04-03 09:15:00', '2024-04-05 11:30:00');

-- 2. Inserindo registros na tabela 'container'
INSERT INTO container (apelido, dt_cadastro_container, fk_lote, fk_empresa) VALUES 
    ('CONT-BR-10', '2024-03-15 14:00:00', 1, 2),
    ('CONT-BR-20', '2024-03-15 14:30:00', 2, 2), 
    ('CONT-GS-01', '2024-03-20 09:00:00', 3, 1),
    ('CONT-GS-02', '2024-03-20 09:15:00', 4, 1);

-- 3. Inserindo registros na tabela 'sensor' com datas manuais
INSERT INTO sensor (apelido, codigo_sensor, dt_cadastro_sensor, fk_container) VALUES 
    ('DHT11-L01', 'SN-A1', '2024-03-21 10:00:00', 1),
    ('DHT11-L02', 'SN-B2', '2024-03-21 10:05:00', 2),
    ('DHT11-L03', 'SN-C3', '2024-03-21 10:10:00', 3),
    ('DHT11-L04', 'SN-D4', '2024-03-21 10:15:00', 4);

-- 4. Inserindo registros na tabela 'registro' com datas manuais
INSERT INTO registro (temperatura, umidade, dt_registro, fk_sensor) VALUES
	(-18.50, 10.00, '2024-04-01 12:00:00', 1),
	(-19.20, 09.50, '2024-04-01 13:00:00', 1),
	(1.50, 40.00, '2024-04-01 12:00:00', 3), 
	(2.10, 42.00, '2024-04-01 13:00:00', 3); 
    
-- Mostrar tabelas separadas:    
SELECT * FROM container;

SELECT * FROM empresa;

SELECT * FROM lote;

SELECT * FROM registro;

SELECT * FROM sensor;

-- Exibindo a mercadoria da empresa Brazilian Fish

SELECT
	e.nome_empresa AS 'Nome da empresa:',
    r.temperatura AS 'Temperatura:',
    r.dt_registro AS 'Registro da temperatura:',
	c.apelido AS 'Nome do conteiner:',
    l.codigo_lote AS 'Código da entrega:'
FROM Empresa as e
	JOIN Container as c
    ON c.fk_empresa = e.id_empresa
    JOIN Registro as r
    ON r.fk_sensor = c.id_container
    JOIN Lote as l
    ON c.fk_lote = l.id_lote
WHERE e.nome_empresa = 'Brazilian Fish';

-- Exibindo a mercadoria da empresa GeneSeas

SELECT
	e.nome_empresa AS 'Nome da empresa:',
    r.temperatura AS 'Temperatura:',
    r.dt_registro AS 'Registro da temperatura:',
	c.apelido AS 'Nome do conteiner:',
    l.codigo_lote AS 'Código da entrega:'
FROM Empresa as e
	JOIN Container as c
    ON c.fk_empresa = e.id_empresa
    JOIN Registro as r
    ON r.fk_sensor = c.id_container
    JOIN Lote as l
    ON c.fk_lote = l.id_lote
WHERE e.nome_empresa = 'GeneSeas';

-- Exibindo o relacionamento da tabela 'empresa' e 'usuario'
SELECT
	u.nome_usuario 'Nome dos administradores:',
    u.email 'Somente administradores:',
    u.nome_completo 'Nome apenas dos administradores:'
FROM usuario u
	JOIN empresa e
		ON u.fk_empresa = e.id_empresa
WHERE u.adm = 1;
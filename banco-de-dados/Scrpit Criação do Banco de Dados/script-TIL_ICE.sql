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

-- Criando a tabela 'container'
CREATE TABLE container (
	id_container INT PRIMARY KEY AUTO_INCREMENT,
	apelido VARCHAR(45),
	dt_cadastro_container DATETIME,
    -- (discutir em grupo "lote" dt_transporte_inicio dt_transporte_fim)
	fk_empresa INT,
	CONSTRAINT ctfkContainer_Empresa FOREIGN KEY(fk_empresa) REFERENCES empresa(id_empresa)
);

CREATE TABLE sensor(
	id_sensor INT PRIMARY KEY AUTO_INCREMENT,
	apelido VARCHAR(45),
	codigo_sensor VARCHAR(45),
	dt_cadastro_sensor VARCHAR(45),
	fk_container INT,
	CONSTRAINT ctfkContainer FOREIGN KEY(fk_container) REFERENCES container(id_container)
);
    
-- Criando a tabela 'registro'
CREATE TABLE registro (
	id_registro INT PRIMARY KEY AUTO_INCREMENT,
	temperatura DECIMAL(5,2),
	umidade DECIMAL(5,2),
	dt_registro DATETIME DEFAULT CURRENT_TIMESTAMP(),
	fk_container INT,
	CONSTRAINT ctFkregistro_Container FOREIGN KEY (fk_container) REFERENCES container(id_container)
);

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
    
-- Inserindo registros a tabela 'container'
INSERT INTO container (apelido, dt_cadastro_container, fk_empresa) VALUES 
    ('CONT-A100', CURRENT_TIMESTAMP, 1),
    ('CONT-B200', CURRENT_TIMESTAMP, 1),
    ('CONT-C300', CURRENT_TIMESTAMP, 1),
    ('CONT-BA15', CURRENT_TIMESTAMP, 2),
    ('CONT-A234', CURRENT_TIMESTAMP, 2),
    ('CONT-F029', CURRENT_TIMESTAMP, 2);
    
-- Inserindo registros a tabela 'sensor'
INSERT INTO sensor (apelido, codigo_sensor, dt_cadastro_sensor, fk_container) VALUES 
    ('DHT11-01', 'SN-DHT11-A1', CURRENT_TIMESTAMP, 1),
    ('DHT11-02', 'SN-DHT11-B2', CURRENT_TIMESTAMP, 2),
    ('DHT11-03', 'SN-DHT11-C3', CURRENT_TIMESTAMP, 3),
    ('DHT11-04', 'SN-DHT11-D4', CURRENT_TIMESTAMP, 4),
    ('DHT11-05', 'SN-DHT11-E5', CURRENT_TIMESTAMP, 5),
    ('DHT11-06', 'SN-DHT11-F6', CURRENT_TIMESTAMP, 6);
    
-- Inserindo registros a tabela 'registro'
INSERT INTO registro (temperatura, umidade, fk_container) VALUES
	(22.50, 60.00, 1),
	(-5.20, 15.30, 2),
	(18.00, 45.50, 3),
	(9.50, 13.40, 4),
	(-11.83, 22.30, 5),
	(27.31, 65.50, 6);

-- Exibindo dados
-- Exibindo o relacionamento da tabela 'empresa' e 'usuario'
SELECT
	u.nome_usuario 'Nome dos administradores:',
    u.email 'Somente administradores:',
    u.nome_completo 'Nome apenas dos administradores:'
FROM usuario u
	JOIN empresa e
		ON u.fk_empresa = e.id_empresa
WHERE u.adm = 1;

-- Exibindo dados da tabela 'container'
SELECT 
	c.apelido AS 'Apelido',
	c.codigo_sensor AS 'Código do Sensor',
	c.dtContainer AS 'Data da chegada do Container',
	e.nome_empresa AS 'Empresa proprietaria do Container',
	e.cnpj AS 'CNPJ da Empresa'
FROM container AS c
	JOIN empresa AS e
		ON c.fkEmpresa = e.id_empresa;

SELECT * FROM container;

-- Exibindo dados da tabela 'registro'
SELECT 
	c.codigo_sensor AS 'Código do Sensor',
	r.temperatura AS 'Temperatura',
	r.umidade AS 'Umidade',
	r.dtRegistro AS 'Data do Registro'
FROM registro AS r
	JOIN container AS c
		ON r.fkContainer = c.id_container;
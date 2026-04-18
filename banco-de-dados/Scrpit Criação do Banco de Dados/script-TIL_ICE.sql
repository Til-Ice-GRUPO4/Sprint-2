-- Criando o banco de dados
CREATE DATABASE TIL_ICE;
-- Usando o banco de dados 
USE TIL_ICE;
-- Criando a tabela 'empresa'
CREATE TABLE empresa (
	id_empresa INT PRIMARY KEY AUTO_INCREMENT,
	nome_empresa VARCHAR(45) NOT NULL,
	cnpj CHAR(14) UNIQUE NOT NULL,
	dt_cadastro_empresa DATETIME DEFAULT CURRENT_TIMESTAMP(),
	codigo_convite VARCHAR(45),
	ativo TINYINT DEFAULT 1
);

-- Criando a tabela 'usuario'
CREATE TABLE usuario (
	id_usuario INT PRIMARY KEY AUTO_INCREMENT,
	nome_usuario VARCHAR(45),
	email VARCHAR(45),
	nome_completo VARCHAR(150),
	senha VARCHAR(45),
	cpf CHAR(11) NOT NULL UNIQUE,
	dt_cadastro_usuario DATETIME DEFAULT CURRENT_TIMESTAMP(),
	adm TINYINT DEFAULT 0,
	fk_empresa INT NOT NULL,
	CONSTRAINT ctfkEmpresa FOREIGN KEY (fk_empresa) REFERENCES empresa(id_empresa)
);

-- Criando a tabela 'lote'
CREATE TABLE lote (
	id_lote INT PRIMARY KEY AUTO_INCREMENT,
	codigo_lote VARCHAR(45),
	dt_transporte_inicio DATETIME DEFAULT CURRENT_TIMESTAMP(),
	dt_transporte_final DATETIME,
	peso_total_tonelada DECIMAL(10,3)
);

-- Criando a tabela 'container'
CREATE TABLE container (
    id_container INT PRIMARY KEY AUTO_INCREMENT,
    apelido VARCHAR(45),
    codigo_conteiner VARCHAR(45),
    dt_cadastro_container DATETIME DEFAULT CURRENT_TIMESTAMP(),
    fk_lote INT,
    CONSTRAINT ctklote FOREIGN KEY (fk_lote) REFERENCES lote(id_lote),
    fk_empresa INT NOT NULL,
    CONSTRAINT ctfkContainer_Empresa FOREIGN KEY (fk_empresa) REFERENCES empresa(id_empresa),
    ativo TINYINT DEFAULT 1
);

-- Criando a tabela 'parametro'
CREATE TABLE parametro (
    id_parametro INT PRIMARY KEY AUTO_INCREMENT,
    temperatura_min DECIMAL(5,2),
    temperatura_max DECIMAL(5,2),
    umidade_min DECIMAL(5,2),
    umidade_max DECIMAL(5,2)
);

-- Criando a tabela 'sensor'
CREATE TABLE sensor (
    id_sensor INT PRIMARY KEY AUTO_INCREMENT,
    apelido VARCHAR(45),
    codigo_sensor VARCHAR(45),
    dt_cadastro_sensor DATETIME DEFAULT CURRENT_TIMESTAMP(),
    fk_container INT NOT NULL,
    CONSTRAINT ctfkContainer FOREIGN KEY (fk_container) REFERENCES container(id_container),
    fk_parametro INT NOT NULL,
    CONSTRAINT ctfkParametro FOREIGN KEY (fk_parametro) REFERENCES parametro(id_parametro),
    ativo TINYINT DEFAULT 1
);

-- Criando a tabela 'alerta'
CREATE TABLE alerta (
    id_alerta INT PRIMARY KEY AUTO_INCREMENT,
    tipo VARCHAR(30),-- 'TEMP_ALTA', 'TEMP_BAIXA', 'UMID_ALTA', 'UMID_BAIXA'
    dt_inicio DATETIME DEFAULT CURRENT_TIMESTAMP(),
    dt_fim DATETIME,-- NULL = alerta ainda ativo
    resolvido TINYINT DEFAULT 0
);

-- Criando a tabela 'registro'
CREATE TABLE registro (
    id_registro INT PRIMARY KEY AUTO_INCREMENT,
    temperatura DECIMAL(5,2),
    umidade DECIMAL(5,2),
    dt_registro DATETIME DEFAULT CURRENT_TIMESTAMP(),
    fk_sensor INT NOT NULL,
    CONSTRAINT ctfk_sensor FOREIGN KEY (fk_sensor) REFERENCES sensor(id_sensor),
    fk_alerta INT,
    CONSTRAINT ctfk_alerta FOREIGN KEY (fk_alerta) REFERENCES alerta(id_alerta)
);

-- DADOS INSERIDOS MOCKADOS PARA SIMULAÇÃO --

-- 1. Inserindo registros na tabela 'empresa'
INSERT INTO empresa (nome_empresa, cnpj, codigo_convite) VALUES
    ('GeneSeas','04459073000105', 'GENES-2024'),
    ('Brazilian Fish', '33628460000118', 'BRFISH-2024');

-- 2. Inserindo registros na tabela 'usuario'
INSERT INTO usuario (nome_usuario, email, nome_completo, senha, cpf, adm, fk_empresa) VALUES
    ('chefe1', 'chefe1@empresa.com', 'Chefe 1', '@Senha242', '12345678901', 1, 1),
    ('chefe2', 'chefe2@empresa.com', 'Chefe 2', '@Senha243', '12345678902', 1, 1),
    ('funcionario1', 'funcionario1@empresa.com', 'Funcionario 1', '@Senha241', '12345678903', 0, 1),
    ('funcionario2', 'funcionario2@empresa.com', 'Funcionario 2', '@Senha244', '12345678904', 0, 1),
    ('funcionario3', 'funcionario3@empresa.com', 'Funcionario 3', '@Senha267', '12345678907', 0, 2),
    ('funcionario4', 'funcionario4@empresa.com', 'Funcionario 4', '@Senha2',   '12345678909', 0, 2);

-- 3. Inserindo registros na tabela 'lote'
INSERT INTO lote (codigo_lote, dt_transporte_inicio, dt_transporte_final, peso_total_tonelada) VALUES
    ('BRFISH-TIL-2024-001', '2024-04-01 08:00:00', '2024-04-03 14:00:00', 12.500),
    ('BRFISH-TIL-2024-002', '2024-04-02 10:30:00', '2024-04-04 16:20:00', 10.200),
    ('GENES-TIL-2024-055', '2024-04-01 07:45:00', '2024-04-02 20:00:00', 15.750),
    ('GENES-TIL-2024-056', '2024-04-03 09:15:00', '2024-04-05 11:30:00', 11.000);

-- 4. Inserindo registros na tabela 'container'
INSERT INTO container (apelido, codigo_conteiner, dt_cadastro_container, fk_lote, fk_empresa) VALUES
    ('CONT-BR-10', 'CTN-001', '2024-03-15 14:00:00', 1, 2),
    ('CONT-BR-20', 'CTN-002', '2024-03-15 14:30:00', 2, 2),
    ('CONT-GS-01', 'CTN-003', '2024-03-20 09:00:00', 3, 1),
    ('CONT-GS-02', 'CTN-004', '2024-03-20 09:15:00', 4, 1);

-- Inserindo registros na tabela 'parametro'

INSERT INTO parametro (temperatura_min, temperatura_max, umidade_min, umidade_max) VALUES
    (-25.00, -15.00,  5.00, 20.00),  -- congelado
    (0.00, 4.00, 35.00, 60.00);  -- refrigerado

-- Inserindo registros na tabela 'sensor'

INSERT INTO sensor (apelido, codigo_sensor, dt_cadastro_sensor, fk_container, fk_parametro) VALUES
    ('DHT11-L01', 'SN-A1', '2024-03-21 10:00:00', 1, 1),
    ('DHT11-L02', 'SN-B2', '2024-03-21 10:05:00', 2, 1),
    ('DHT11-L03', 'SN-C3', '2024-03-21 10:10:00', 3, 2),
    ('DHT11-L04', 'SN-D4', '2024-03-21 10:15:00', 4, 2);

-- Inserindo registros na tabela 'alerta' (leituras fora do parâmetro)
INSERT INTO alerta (tipo, dt_inicio, dt_fim, resolvido) VALUES
    ('TEMP_ALTA', '2024-04-01 15:00:00', '2024-04-01 15:45:00', 1),  -- resolvido
    ('UMID_ALTA', '2024-04-01 16:00:00', NULL, 0); -- ainda ativo

-- Inserindo registros na tabela 'registro'
INSERT INTO registro (temperatura, umidade, dt_registro, fk_sensor, fk_alerta) VALUES
    (-18.50, 10.00, '2024-04-01 12:00:00', 1, NULL),-- normal
    (-19.20,  9.50, '2024-04-01 13:00:00', 1, NULL),-- normal
    (-10.00, 10.50, '2024-04-01 15:00:00', 1, 1),-- TEMP_ALTA (fora do limite)
    (1.50, 40.00, '2024-04-01 12:00:00', 3, NULL),-- normal
    (2.10, 42.00, '2024-04-01 13:00:00', 3, NULL),-- normal
    (2.80, 65.00, '2024-04-01 16:00:00', 3, 2);-- UMID_ALTA (fora do limite)
    
-- CONSULTAS --

-- Mostrar tabelas separadas
SELECT * FROM empresa;
SELECT * FROM usuario;
SELECT * FROM lote;
SELECT * FROM container;
SELECT * FROM parametro;
SELECT * FROM sensor;
SELECT * FROM alerta;
SELECT * FROM registro;

-- Exibindo a mercadoria da empresa Brazilian Fish
SELECT
    e.nome_empresa AS 'Empresa',
    c.apelido AS 'Contêiner',
    l.codigo_lote AS 'Código do Lote',
    s.codigo_sensor AS 'Sensor',
    r.temperatura AS 'Temperatura (°C)',
    r.umidade AS 'Umidade (%)',
    r.dt_registro AS 'Data do Registro'
FROM empresa e
    JOIN container c ON c.fk_empresa  = e.id_empresa
    JOIN lote l ON l.id_lote = c.fk_lote
    JOIN sensor s ON s.fk_container = c.id_container
    JOIN registro r ON r.fk_sensor = s.id_sensor
WHERE e.nome_empresa = 'Brazilian Fish';

-- Exibindo a mercadoria da empresa GeneSeas
SELECT
    e.nome_empresa AS 'Empresa',
    c.apelido AS 'Contêiner',
    l.codigo_lote AS 'Código do Lote',
    s.codigo_sensor AS 'Sensor',
    r.temperatura AS 'Temperatura (°C)',
    r.umidade AS 'Umidade (%)',
    r.dt_registro AS 'Data do Registro'
FROM empresa e
    JOIN container c ON c.fk_empresa = e.id_empresa
    JOIN lote l ON l.id_lote = c.fk_lote
    JOIN sensor s ON s.fk_container = c.id_container
    JOIN registro r ON r.fk_sensor = s.id_sensor
WHERE e.nome_empresa = 'GeneSeas';

-- Exibindo apenas administradores por empresa
SELECT
    e.nome_empresa AS 'Empresa',
    u.nome_usuario AS 'Usuário',
    u.email AS 'E-mail',
    u.nome_completo AS 'Nome Completo'
FROM usuario u
    JOIN empresa e ON u.fk_empresa = e.id_empresa
WHERE u.adm = 1;

-- Exibindo alertas ativos com detalhes do sensor e contêiner
SELECT
    a.tipo AS 'Tipo de Alerta',
    a.dt_inicio AS 'Início do Alerta',
    s.codigo_sensor AS 'Sensor',
    c.apelido AS 'Contêiner',
    e.nome_empresa AS 'Empresa'
FROM alerta a
    JOIN registro r ON r.fk_alerta = a.id_alerta
    JOIN sensor s ON s.id_sensor = r.fk_sensor
    JOIN container c ON c.id_container = s.fk_container
    JOIN empresa e ON e.id_empresa = c.fk_empresa
WHERE a.resolvido = 0;
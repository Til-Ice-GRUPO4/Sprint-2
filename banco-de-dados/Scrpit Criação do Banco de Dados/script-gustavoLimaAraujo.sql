-- Criando  o banco de dados
CREATE DATABASE TLI_ICE;

-- Usando o banco de dados 
USE TIL_ICE;

	-- Criando a tabela 'usuario'
	CREATE TABLE usuario (
		id_usuario INT PRIMARY KEY AUTO_INCREMENT,
		nome_usuario VARCHAR(45) NOT NULL,
		email VARCHAR(45) NOT NULL UNIQUE,
		nome_completo VARCHAR(45)  NOT NULL,
		senha VARCHAR(45) NOT NULL,
		cpf CHAR(11) NOT NULL UNIQUE,
		dtCadastro_usuario DATETIME DEFAULT CURRENT_TIMESTAMP(),
		fkChefe INT,
		CONSTRAINT ctFkChefe FOREIGN KEY (fkChefe) REFERENCES usuario(id_usuario),
		-- Validação de email
		CONSTRAINT ctEmail CHECK (email LIKE '%@%' AND email LIKE '%.%')
	);

	-- Criando a tabela 'empresa'
	CREATE TABLE empresa (
		id_empresa INT PRIMARY KEY AUTO_INCREMENT,
		nome_empresa VARCHAR(45) NOT NULL,
		cnpj VARCHAR(20) UNIQUE NOT NULL,
		dtCadastro_empresa DATETIME DEFAULT CURRENT_TIMESTAMP(),
		fkUsuario INT,
		CONSTRAINT ctFkUsuario FOREIGN KEY (fkUsuario) REFERENCES usuario(id_usuario)
	);

	-- Criando a tabela 'container'
	CREATE TABLE container (
		id_container INT AUTO_INCREMENT,
		codigo_sensor VARCHAR(45) NOT NULL,
		dtContainer DATETIME,
		fkEmpresa INT,
		-- Criando o relacionamento fraco entre as tabelas 'empresa' e container'
		PRIMARY KEY (id_container, fkEmpresa),
		CONSTRAINT ctFkEmpresa FOREIGN KEY (fkEmpresa) REFERENCES empresa(id_empresa)
	);

	-- Criando a tabela 'registro'
	CREATE TABLE registro (
		id_registro INT AUTO_INCREMENT,
		temperatura DECIMAL(5,2),
		umidade DECIMAL(5,2),
		dtRegistro DATETIME DEFAULT CURRENT_TIMESTAMP(),
		fkContainer INT,
		-- Criando o relacionamento fraco entre as tabelas 'container' e 'registro'
		PRIMARY KEY (id_registro, fkContainer),
		CONSTRAINT ctFkContainer FOREIGN KEY (fkContainer) REFERENCES container(id_container)
	);

-- Inserindo registros a tabela 'usuario'
INSERT INTO usuario (nome_usuario, email, nome_completo, senha, cpf) VALUES
	('chefe1', 'chefe1@empresa.com', 'Chefe 1', '@Senha242', '12345678901'),
    ('chefe2', 'chefe2@empresa.com', 'Chefe 2', '@Senha243', '12345678902'),
    ('funcionario1', 'funcionario1@empresa.com', 'Funcionario 1', '@Senha241', '12345678903'),
    ('funcionario2', 'funcionario2@empresa.com', 'Funcionario 2', '@Senha244', '12345678904'),
    ('funcionario3', 'funcionario3@empresa.com', 'Funcionario 3', '@Senha267', '12345678905'),
    ('funcionario4', 'funcionario4@empresa.com', 'Funcionario 4', '@Senha2', '12345678906');
    
    
-- Atualizando adicionando aos funcionários seus respectivos chefes
UPDATE usuario
SET fkChefe = 1
WHERE id_usuario IN (3, 4);    

UPDATE usuario
SET fkChefe = 2
WHERE id_usuario IN (5, 6);    

-- Inserindo registros a tabela 'empresa'
INSERT INTO empresa (nome_empresa, cnpj, fkUsuario) VALUES
	('GeneSeas', '04459073000105', 1),
	('Brazilian Fish', '33628460000118', 2); 
    
-- Inserindo registros a tabela 'container'
INSERT INTO container (codigo_sensor, fkEmpresa) VALUES 
	('CONT-A100', 1),
	('CONT-B200', 1),
	('CONT-C300', 1),
	('CONT-BA15', 2),
	('CONT-A234', 2),
	('CONT-F029', 2);

-- Inserindo registros a tabela 'registro'
INSERT INTO registro (temperatura, umidade, fkContainer) VALUES
	(22.50, 60.00, 1),
	(-5.20, 15.30, 2),
	(18.00, 45.50, 3),
	(9.50, 13.40, 4),
	(-11.83, 22.30, 5),
	(27.31, 65.50, 6);

-- Exibindo dados

-- Exibindo dados da tabela 'usuario'
SELECT 
f.nome_usuario AS 'Nome do Usuário',
f.email AS 'Email do Usuário',
f.cpf AS 'CPF do Usuário',
f.nome_completo AS 'Nome Completo do Usuário',
IFNULL(c.nome_completo, 'Não possui Chefe') AS 'Nome Completo do Chefe',
IFNULL(c.email, 'Não possui Chefe') AS 'Email do Chefe',
f.dtCadastro_usuario AS 'Data de Cadastro'
FROM usuario AS f
LEFT JOIN usuario AS c ON f.fkChefe = c.id_usuario;

-- Exibindo dados da tabela 'empresa'
SELECT 
e.nome_empresa AS 'Nome da Empresa',
e.cnpj AS 'CNPJ da Empresa',
e.dtCadastro_empresa AS 'Data de Cadastro da Empresa',
u.nome_usuario AS 'Dono da Empresa'
FROM empresa AS e
JOIN usuario AS u ON e.fkUsuario = u.id_usuario;

-- Exibindo dados da tabela 'container'
SELECT 
c.codigo_sensor AS 'Código do Sensor',
c.dtContainer AS 'Data da chegada do Container',
e.nome_empresa AS 'Empresa proprietaria do Container',
e.cnpj AS 'CNPJ da Empresa'
FROM container AS c
JOIN empresa AS e ON c.fkEmpresa = e.id_empresa;

-- Exibindo dados da tabela 'registro'
SELECT 
c.codigo_sensor AS 'Código do Sensor',
r.temperatura AS 'Temperatura',
r.umidade AS 'Umidade',
r.dtRegistro AS 'Data do Registro'
FROM registro AS r
JOIN container AS c ON r.fkContainer = c.id_container;
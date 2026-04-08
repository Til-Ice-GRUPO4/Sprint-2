CREATE USER 'user_insert'@'%' IDENTIFIED BY '@Senha242';
GRANT INSERT ON TIL_ICE.registro TO 'user_insert'@'%';

FLUSH PRIVILEGES;

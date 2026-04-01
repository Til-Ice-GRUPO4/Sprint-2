create database dht11;

use dht11;

create table Registro(
idRegistro int primary key auto_increment,
temperatura decimal(5,2),
umidade decimal(5,2),
horario datetime default now()
);
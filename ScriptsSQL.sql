DROP DATABASE IF EXISTS Editora;

CREATE DATABASE IF NOT EXISTS Editora;

USE Editora;

CREATE TABLE Livrarias
(
  idlivraria int not null,
  nomelivraria varchar(50) not null,
  endereco varchar (100) not null,
  telefone varchar(13) not null,
  PRIMARY KEY (idlivraria)
);

DESC Livrarias;

CREATE TABLE Livros
(
  idlivro int not null,
  titulolivro varchar(150) not null,
  autor varchar(150) not null,
  precounitario decimal (5,2) not null,
  PRIMARY KEY (idlivro)
);

DESC Livros;

CREATE TABLE NotasFiscais
(
  idvenda int not null,
  datavenda date not null,
  idlivraria int not null,
  PRIMARY KEY (idvenda),
  FOREIGN KEY (idlivraria) REFERENCES Livrarias(idlivraria)
);

DESC NotasFiscais;

CREATE TABLE ItensNF
(
  idvenda int not null,
  idlivro int not null,
  qtdevendida tinyint not null,
  PRIMARY KEY (idvenda, idlivro),
  FOREIGN KEY (idvenda)
    REFERENCES NotasFiscais (idvenda),
  FOREIGN KEY (idlivro)
    REFERENCES Livros(idlivro)
);

DESC ItensNF;

INSERT INTO Livrarias
VALUES
(1,'Livraria Francesa','Rua Barão de Itapetininga,275','11 3231-4555'),
(2,'Livraria da Vila','Rua Fradique Coutinho, 915','11 3814-5811'),
(3,'Devir Livraria Ltda','Rua Teodureto Soutro, 624','11 2127-8787'),
(4,'Livraria Cultura','Avenida Paulista, 2073','11 3266-3916'),
(5,'Moonshadows Livraria','Rua Treze de Maio, 966','11 3266-3916');

SELECT * FROM Livrarias;

INSERT INTO Livros
VALUES
(1,'Windows Vista','Suriani, Rogério Massaro',35.00),
(2,'Organizacão de Sistemas','Fernandes, Leila Maria Pinheiro',34.00),
(3,'Logica de Programacao','Xavier, Gley Fabiano Cardoso',87.00),
(4,'Linkania: Uma teoria de redes','Dimantas, Hernani',299.00),
(5,'Internet: Navegando melhor na WEB','Filho, Ozeas Vieira Santana',40.00),
(6,'Inclusao Digital: Uma visao critica','Cazeloto, Edison',47.00),
(7,'Guia Internet de Conectividade','Cyclades Brasil',47.00),
(8,'Estrategias Para A Midia Digital 2.0','Correa, Elizabeth Saad',87.00),
(9,'Coreal Draw X4','Andrade, Maria Angel Serafim de',74.00),
(10,'Comunidades Vistuais','Filho, Jayme Teixeira',32.00);

SELECT * FROM Livros;

INSERT INTO NotasFiscais
VALUES
(1,'2021-08-09', 4),
(2,'2021-08-09', 5),
(3,'2021-08-10', 2),
(4,'2021-08-15',1);

INSERT INTO ItensNF
VALUES
(1,3,5),
(1,9,10),
(1,1,20),
(2,10,2),
(3,8,15),
(3,2,15),
(4,5,10),
(4,7,5),
(4,6,10),
(4,2,5);

SELECT * FROM NotasFiscais;
SELECT * FROM ItensNF;

SELECT * FROM Livros WHERE precounitario >= 40.50;

SELECT * FROM Livrarias WHERE telefone LIKE '___32%';

SELECT idvenda, datavenda, nomelivraria FROM NotasFiscais 
INNER JOIN Livrarias
ON NotasFiscais.idlivraria = Livrarias.idlivraria
ORDER BY  idvenda;

SELECT idvenda, titulolivro, qtdevendida FROM ItensNF
INNER JOIN Livros
ON ItensNF.idlivro = Livros.idlivro
ORDER BY idvenda;

SELECT idvenda, titulolivro, qtdevendida, precounitario FROM ItensNF
INNER JOIN Livros
ON ItensNF.idlivro = Livros.idlivro
ORDER BY  idvenda;

SELECT * FROM Livros WHERE precounitario BETWEEN 50 and 100;

SELECT * FROM Livrarias WHERE nomelivraria between 'C' and 'J';

SELECT * FROM Livros limit 5;

SELECT MIN(precounitario) FROM Livros;

SELECT MAX(precounitario) FROM Livros;

SELECT MIN(autor) FROM Livros;

SELECT MAX(titulolivro) FROM Livros;

SELECT COUNT(idlivro) FROM Livros;

SELECT AVG(precounitario) AS 'Média dos preços' FROM Livros;

SELECT SUM(qtdevendida) FROM ItensNF;

SELECT nf.idvenda AS Venda,
nf.datavenda AS 'Data',
la.nomelivraria AS Nome,
la.telefone AS Contato
FROM NotasFiscais AS nf 
INNER JOIN Livrarias AS la
ON nf.idlivraria = la.idlivraria
ORDER BY nf.idvenda;

SELECT inf.idvenda as Venda,
lo.titulolivro as Título,
inf.qtdevendida as Qtde,
lo.precounitario as Valor,
inf.qtdevendida * lo.precounitario as Subtotal
FROM ItensNF as inf 
INNER JOIN Livros as lo
ON inf.idlivro = lo.idlivro
ORDER BY inf.idvenda;

SELECT inf.idvenda AS Venda,
lo.titulolivro AS Título,
inf.qtdevendida * lo.precounitario AS Subtotal
FROM ItensNF as inf
INNER JOIN Livros AS lo
ON inf.idlivro = lo.idlivro
ORDER BY Subtotal DESC
LIMIT 3;

/*Aula dia 29/09 
*
*
*
*
* Criação do banco de dados Chevrowagen
*
*
*
*
*/

DROP DATABASE IF EXISTS chevrowagen;

CREATE DATABASE IF NOT EXISTS chevrowagen;

USE chevrowagen;

CREATE TABLE clientes
(
	idcliente int NOT NULL,
	nomecliente varchar(40) NOT NULL,
	estado char(2) NOT NULL,
	PRIMARY KEY(idcliente)
);

CREATE TABLE veiculos
(
	idveiculo int NOT NULL,
	fabricante varchar(30) NOT NULL,
	modelo varchar(50) NOT NULL,
	ano year NOT NULL,
	preco decimal(10,2) NOT NULL,
	PRIMARY KEY(idveiculo)
);

CREATE TABLE vendas
(
	idvenda int NOT NULL,
	datavenda date NOT NULL,
	idcliente int NOT NULL,
	PRIMARY KEY(idvenda),
	FOREIGN KEY(idcliente) REFERENCES clientes(idcliente)
);

CREATE TABLE itensvendidos
(
	idvenda int NOT NULL,
	idveiculo int NOT NULL,
	qtdevendida tinyint NOT NULL,
	PRIMARY KEY(idvenda,idveiculo),
	FOREIGN KEY(idvenda) REFERENCES vendas(idvenda),
	FOREIGN KEY(idveiculo) REFERENCES veiculos(idveiculo)
);

INSERT INTO clientes
VALUES('1','Joaquim José da Silva Xavier','MG');

INSERT INTO clientes
VALUES('2','Alberto Santos Dumont','MG');

INSERT INTO clientes
VALUES('3','José Abelardo Barbosa de Medeiros','PE');

INSERT INTO clientes
VALUES('4','Raul Santos Seixas','BA');

INSERT INTO clientes
VALUES('5','Tancredo de Almeida Neves','MG');

INSERT INTO clientes
VALUES('6','Jânio da Silva Quadros','MS');

INSERT INTO clientes
VALUES('7','Renato Manfredini Júnior','RJ');

INSERT INTO veiculos
VALUES('200','Chevrolet','Corsa','1995','11704.00');

INSERT INTO veiculos
VALUES('201','Chevrolet','Vectra','2005','27009.00');

INSERT INTO veiculos
VALUES('203','Chevrolet','Celta','2006','17888.00');

INSERT INTO veiculos
VALUES('204','Fiat','Fiorino','1997','11136.00');

INSERT INTO veiculos
VALUES('205','Fiat','Palio','1999','11258.00');

INSERT INTO veiculos
VALUES('206','Ford','EcoSport','2009','48913.00');

INSERT INTO veiculos
VALUES('207','Ford','Fiesta','1998','10355.00');

INSERT INTO veiculos
VALUES('208','Ford','KA','2006','16707.00');

INSERT INTO veiculos
VALUES('209','Volkswagen','Fusca','1985','5855.00');

INSERT INTO vendas
VALUES ('400','2010-06-11','5');

INSERT INTO vendas
VALUES ('401','2010-06-11','1');

INSERT INTO vendas
VALUES ('402','2010-06-13','3');

INSERT INTO vendas
VALUES ('403','2010-06-21','2');

INSERT INTO vendas
VALUES ('404','2010-07-07','7');

INSERT INTO itensvendidos
VALUES('400','203','5');

INSERT INTO itensvendidos
VALUES('400','208','5');

INSERT INTO itensvendidos
VALUES('401','204','10');

INSERT INTO itensvendidos
VALUES('401','205','10');

INSERT INTO itensvendidos
VALUES('401','209','15');

INSERT INTO itensvendidos
VALUES('402','206','30');

INSERT INTO itensvendidos
VALUES('403','201','2');

INSERT INTO itensvendidos
VALUES('403','207','4');

INSERT INTO itensvendidos
VALUES('404','200','10');

INSERT INTO itensvendidos
VALUES('404','205','5');

INSERT INTO itensvendidos
VALUES('404','208','5');

INSERT INTO itensvendidos
VALUES('404','209','10');
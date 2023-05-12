/*Modelagem de uma panificadora*/

create database panificadora;
use panificadora;

/* Criação de tabelas */

CREATE TABLE Ingrediente (
    id_ingrediente INT NOT NULL AUTO_INCREMENT,
    nome_ingrediente VARCHAR(100) NOT NULL,
    PRIMARY KEY (id_ingrediente)
);

CREATE TABLE Produto (
    id_produto INT NOT NULL AUTO_INCREMENT,
    nome_produto VARCHAR(100) NOT NULL,
    categoria_produto VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_produto)
);

CREATE TABLE Receita (
    id_receita INT NOT NULL AUTO_INCREMENT,
    id_produto INT NOT NULL,
    id_ingrediente INT NOT NULL,
    quantidade_ingrediente DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (id_receita),
    FOREIGN KEY (id_produto) REFERENCES Produto(id_produto),
    FOREIGN KEY (id_ingrediente) REFERENCES Ingrediente(id_ingrediente)
);

CREATE TABLE Lote (
    id_lote INT NOT NULL AUTO_INCREMENT,
    id_produto INT NOT NULL,
    data_producao DATE NOT NULL,
    quantidade_produzida INT NOT NULL,
    PRIMARY KEY (id_lote),
    FOREIGN KEY (id_produto) REFERENCES Produto(id_produto)
);

/* 3 - Alterar a tabela produto e incluir o tempo de validade na tabela de Produtos */
ALTER TABLE Produto ADD tempo_validade DATE;

/* 4 -Scripts gerados para insercao de registros*/
/* inserção de ingredientes primeiro */

INSERT INTO Ingrediente (nome_ingrediente)
VALUES
('Farinha de Trigo'),
('Sal'),
('Açúcar'),
('Leite em Pó'),
('Água'),
('Fermento Biológico'),
('Gordura Vegetal'),
('Cenoura Ralada'),
('Ovos'),
('Canela em Pó'),
('Margarina'),
('Chocolate em Pó'),
('Fermento em Pó');

/* inserção tabela produto */
INSERT INTO Produto (nome_produto, categoria_produto)
VALUES
('Pão de Forma', 'Pães'),
('Bolo de Cenoura', 'Bolos'),
('Croissant', 'Pães'),
('Bolo de Chocolate', 'Bolos');

/* Inserção de Receitas */

/* Pão de Forma */
INSERT INTO Receita (id_produto, id_ingrediente, quantidade_ingrediente)
VALUES
(1, 1, 500), -- Farinha de Trigo
(1, 2, 10), -- Sal
(1, 3, 20), -- Açúcar
(1, 4, 50), -- Leite em Pó
(1, 5, 300), -- Água
(1, 6, 50), -- Fermento Biológico
(1, 7, 30); -- Gordura Vegetal

/* Bolo de Cenoura */
INSERT INTO Receita (id_produto, id_ingrediente, quantidade_ingrediente)
VALUES
(2, 1, 300), -- Farinha de Trigo
(2, 2, 5), -- Sal
(2, 3, 20), -- Açúcar
(2, 4, 50), -- Leite em Pó
(2, 5, 200), -- Óleo
(2, 8, 200), -- Cenoura Ralada
(2, 9, 4), -- Ovos
(2, 6, 10), -- Fermento em Pó
(2, 10, 5); -- Canela em Pó

/* Croissant */
INSERT INTO Receita (id_produto, id_ingrediente, quantidade_ingrediente)
VALUES
(3, 1, 250), -- Farinha de Trigo
(3, 2, 5), -- Sal
(3, 3, 20), -- Açúcar
(3, 4, 50), -- Leite em Pó
(3, 5, 100), -- Água
(3, 6, 20), -- Fermento em pó
(3, 7, 50), -- Gordura Vegetal
(3, 11, 100); -- Margarina

/* Bolo de Chocolate */
INSERT INTO Receita (id_produto, id_ingrediente, quantidade_ingrediente)
VALUES
(4, 1, 300), -- Farinha de Trigo
(4, 2, 5), -- Sal
(4, 3, 20), -- Açúcar
(4, 4, 50), -- Chocolate em Pó
(4, 5, 150), -- Óleo
(4, 6, 300), -- Água
(4, 7, 5), -- Fermento em Pó
(4, 8, 4), -- Ovo
(4, 9, 200); -- Leite

/*5 -a */
/* exibir por categoria*/
SELECT categoria_produto, COUNT(*) AS quantidade_produtos
FROM Produto
GROUP BY categoria_produto;

/*5 -b PRODUTOS E INGREDIENTES UTILIZADOS */
SELECT p.nome_produto, i.nome_ingrediente, r.quantidade_ingrediente
FROM Produto p
INNER JOIN Receita r ON r.id_produto = p.id_produto
INNER JOIN Ingrediente i ON i.id_ingrediente = r.id_ingrediente
ORDER BY p.nome_produto;

/* TABELA CRIADA PARA PERMANECER DADOS  */
CREATE TABLE Produtos_Receitas (
  nome_produto VARCHAR(255),
  nome_ingrediente VARCHAR(255),
  quantidade_ingrediente DECIMAL(10,2),
  data_consulta DATETIME
);

INSERT INTO Produtos_Receitas (nome_produto, nome_ingrediente, quantidade_ingrediente, data_consulta)
SELECT p.nome_produto, i.nome_ingrediente, r.quantidade_ingrediente, NOW() AS data_consulta
FROM Produto p
INNER JOIN Receita r ON r.id_produto = p.id_produto
INNER JOIN Ingrediente i ON i.id_ingrediente = r.id_ingrediente
ORDER BY p.nome_produto;
/*5 -c ULTIMOS 30 DIAS*/
SELECT *
FROM Produtos_Receitas
WHERE data_consulta >= DATE_SUB(NOW(), INTERVAL 30 DAY);

/*5 -D PARA DOBRAR A PRODUCAO PARA PROXIMO MES */

SELECT i.nome_ingrediente, SUM(r.quantidade_ingrediente * 2) as quantidade_necessaria
FROM Receita r
INNER JOIN Ingrediente i ON i.id_ingrediente = r.id_ingrediente
GROUP BY i.nome_ingrediente;

/*5 -E MOSTRAR INGREDIENTES QUE NUNCA FORAM UTILIZADOS */
SELECT i.nome_ingrediente
FROM Ingrediente i
WHERE NOT EXISTS (
    SELECT 1
    FROM Receita r
    WHERE r.id_ingrediente = i.id_ingrediente
);

CREATE TABLE Producao (
    producao_id INT PRIMARY KEY AUTO_INCREMENT,
    data DATE NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL,
    observacao VARCHAR(255),
    FOREIGN KEY (id_produto) REFERENCES Product (id_produto)
);










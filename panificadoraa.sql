/*Modelagem de uma panificadora*/

create database panificadora;
use panificadora;

/* Criação de tabelas */

CREATE TABLE Produto (
    id_produto INT NOT NULL AUTO_INCREMENT,
    nome_produto VARCHAR(100) NOT NULL,
    categoria_produto VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_produto)
);

CREATE TABLE Ingrediente (
    id_ingrediente INT NOT NULL AUTO_INCREMENT,
    nome_ingrediente VARCHAR(100) NOT NULL,
    PRIMARY KEY (id_ingrediente)
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

/* Populando a tabela receita */

/*pao de forma */
INSERT INTO Receita (id_produto, id_ingrediente, quantidade_ingrediente)
VALUES
    (1, 1, 500), -- farinha de trigo
    (1, 2, 10), -- sal
    (1, 3, 20), -- açúcar
    (1, 4, 50), -- leite em pó
    (1, 5, 300), -- água
    (1, 6, 50), -- fermento biológico
    (1, 7, 30); -- gordura vegetal
    
    
/*bolo de cenoura */
INSERT INTO Receita (id_produto, id_ingrediente, quantidade_ingrediente)
VALUES
    (2, 1, 300), -- farinha de trigo
    (2, 2, 5), -- sal
    (2, 3, 20), -- açúcar
    (2, 4, 50), -- leite em pó
    (2, 5, 200), -- óleo
    (2, 8, 200), -- cenoura ralada
    (2, 9, 4), -- ovos
    (2, 6, 10), -- fermento em pó
    (2, 10, 5); -- canela em pó
    
    /* croissant */
    INSERT INTO Receita (id_produto, id_ingrediente, quantidade_ingrediente)
VALUES
    (3, 1, 250), -- farinha de trigo
    (3, 2, 5), -- sal
    (3, 3, 20), -- açúcar
    (3, 4, 50), -- leite em pó
    (3, 5, 100), -- água
    (3, 6, 20), -- fermento biológico
    (3, 7, 50), -- gordura vegetal
    (3, 11, 100); -- margarina

/* bolo de chocolate */

/* - Gerar os scripts de inserção para os registros, populando a tabela */
INSERT INTO Produto (nome_produto, categoria_produto, tempo_validade) VALUES 
('Pão de forma', 'Pães', '2023-05-31'),
('Bolo de cenoura', 'Bolos', '2023-05-25'),
('Croissant', 'Pães', '2023-06-02'),
('Bolo de chocolate', 'Bolos', '2023-05-28');


/* - Exibir quantos produtos há para cada categoria */

SELECT categoria_produto, COUNT(*) as qtd_produtos FROM Produto GROUP BY categoria_produto;


/* Exibir todos os produtos, quais ingredientes e em que quantidade são  utilizados para produzi-lo */

SELECT p.nome_produto, i.nome_ingrediente, r.quantidade_ingrediente 
FROM Produto p 
JOIN Receita r ON p.id_produto = r.id_produto 
JOIN Ingrediente i ON r.id_ingrediente = i.id_ingrediente;


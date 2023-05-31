-- 	Excluir o usuário e banco de dados caso existam.

-- 	Criação do usuário.

--	Criação do banco de dados.

-- 	Conexão com o banco de dados.


-- 	Criação das tabelas e comentários das tabelas.

CREATE TABLE produtos (
                produto_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                preco_unitario NUMERIC(10,2),
                detalhes LONGBLOB,
                imagem LONGBLOB,
                imagem_mime_type VARCHAR(512),
                imagem_arquivo VARCHAR(512),
                imagem_charset VARCHAR(512),
                imagem_ultima_atualizacao DATE,
                PRIMARY KEY (produto_id)
);

ALTER TABLE produtos COMMENT 'Tabela que armazena os produtos.';

ALTER TABLE produtos MODIFY COLUMN produto_id NUMERIC(38) COMMENT 'Primary key da tabela produtos que com o id de um produto.';

ALTER TABLE produtos MODIFY COLUMN nome VARCHAR(255) COMMENT 'Nome de um produto.';

ALTER TABLE produtos MODIFY COLUMN preco_unitario NUMERIC(10, 2) COMMENT 'Preço de uma unidade de um determinado produto.';

ALTER TABLE produtos MODIFY COLUMN detalhes BLOB COMMENT 'Arquivo com detalhes de um produto.';

ALTER TABLE produtos MODIFY COLUMN imagem BLOB COMMENT 'Imagem de um produto.';

ALTER TABLE produtos MODIFY COLUMN imagem_mime_type VARCHAR(512) COMMENT 'Tipo de arquivo da imagem do produto.';

ALTER TABLE produtos MODIFY COLUMN imagem_arquivo VARCHAR(512) COMMENT 'Arquivo da imagem do produto.';

ALTER TABLE produtos MODIFY COLUMN imagem_charset VARCHAR(512) COMMENT 'Metadados referentes a imagem do produto.';

ALTER TABLE produtos MODIFY COLUMN imagem_ultima_atualizacao DATE COMMENT 'Data da última modificação da imagem do produto.';


CREATE TABLE lojas (
                loja_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                endereco_web VARCHAR(100),
                endereco_fisico VARCHAR(512),
                latitude NUMERIC,
                longitude NUMERIC,
                logo LONGBLOB,
                logo_mime_type VARCHAR(512),
                logo_arquivo VARCHAR(512),
                logo_charset VARCHAR(512),
                logo_ultima_atualizacao DATE,
                PRIMARY KEY (loja_id)
);

ALTER TABLE lojas COMMENT 'Tabela que armazena as informações de cada loja.';

ALTER TABLE lojas MODIFY COLUMN loja_id NUMERIC(38) COMMENT 'Primary key da tabela lojas que contem o id de uma loja.';

ALTER TABLE lojas MODIFY COLUMN nome VARCHAR(255) COMMENT 'Nome da loja.';

ALTER TABLE lojas MODIFY COLUMN endereco_web VARCHAR(100) COMMENT 'Endereco da pagina na internet da loja.';

ALTER TABLE lojas MODIFY COLUMN endereco_fisico VARCHAR(512) COMMENT 'Endereco fisico da loja.';

ALTER TABLE lojas MODIFY COLUMN latitude NUMERIC COMMENT 'Latitude referente a localizacao geografica da loja.';

ALTER TABLE lojas MODIFY COLUMN longitude NUMERIC COMMENT 'longitude referente a localizacao geografica da loja.';

ALTER TABLE lojas MODIFY COLUMN logo BLOB COMMENT 'imagem da logo da loja.';

ALTER TABLE lojas MODIFY COLUMN logo_mime_type VARCHAR(512) COMMENT 'Tipo de arquivo da imagem da logo.';

ALTER TABLE lojas MODIFY COLUMN logo_arquivo VARCHAR(512) COMMENT 'Arquivo da imagem da logo.';

ALTER TABLE lojas MODIFY COLUMN logo_charset VARCHAR(512) COMMENT 'Metadados referentes a logo.';

ALTER TABLE lojas MODIFY COLUMN logo_ultima_atualizacao DATE COMMENT 'Data da ultima modificacao da logo.';


CREATE TABLE estoques (
                estoque_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                PRIMARY KEY (estoque_id)
);

ALTER TABLE estoques COMMENT 'Tabela que armazena a disponibilidade de um produto.';

ALTER TABLE estoques MODIFY COLUMN estoque_id NUMERIC(38) COMMENT 'Primary key da tabela estoques que com o id do estoque.';

ALTER TABLE estoques MODIFY COLUMN loja_id NUMERIC(38) COMMENT 'Foreign key que identifica a loja em que está o estoque.';

ALTER TABLE estoques MODIFY COLUMN produto_id NUMERIC(38) COMMENT 'Foreign key que identifica o produto estocado.';

ALTER TABLE estoques MODIFY COLUMN quantidade NUMERIC(38) COMMENT 'Quantidade de um determinado produto em um estoque';


CREATE TABLE clientes (
                cliente_id NUMERIC(38) NOT NULL,
                email VARCHAR(255) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                telefone1 VARCHAR(20),
                telefone2 VARCHAR(20),
                telefone3 VARCHAR(20),
                PRIMARY KEY (cliente_id)
);

ALTER TABLE clientes COMMENT 'Tabela que armazena os dados dos clientes.';

ALTER TABLE clientes MODIFY COLUMN cliente_id NUMERIC(38) COMMENT 'Primary key da tabela clientes que contem o id do cliente.';

ALTER TABLE clientes MODIFY COLUMN email VARCHAR(255) COMMENT 'Email cadastrado pelo cliente.';

ALTER TABLE clientes MODIFY COLUMN nome VARCHAR(255) COMMENT 'Nome completo do cliente.';

ALTER TABLE clientes MODIFY COLUMN telefone1 VARCHAR(20) COMMENT 'Primeiro número de telefone cadastrado pelo cliente.';

ALTER TABLE clientes MODIFY COLUMN telefone2 VARCHAR(20) COMMENT 'Segundo número de telefone cadastrado pelo cliente.';

ALTER TABLE clientes MODIFY COLUMN telefone3 VARCHAR(20) COMMENT 'Terceiro número de telefone cadastrado pelo cliente.';


CREATE TABLE envios (
                envio_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                endereco_entrega VARCHAR(512) NOT NULL,
                status VARCHAR(15) NOT NULL,
                PRIMARY KEY (envio_id)
);

ALTER TABLE envios COMMENT 'Tabela que armazena dados dos envios pedidos.';

ALTER TABLE envios MODIFY COLUMN envio_id NUMERIC(38) COMMENT 'Primary key da tabela envios que contem o id do envio.';

ALTER TABLE envios MODIFY COLUMN loja_id NUMERIC(38) COMMENT 'Foreign key referente a loja que fará o envio.';

ALTER TABLE envios MODIFY COLUMN cliente_id NUMERIC(38) COMMENT 'Foreing key referente ao cliente que recebe o envio.';

ALTER TABLE envios MODIFY COLUMN endereco_entrega VARCHAR(512) COMMENT 'Endereço que o pedido sera enviado.';

ALTER TABLE envios MODIFY COLUMN status VARCHAR(15) COMMENT 'Situação do envio.';


CREATE TABLE pedidos (
                pedido_id NUMERIC(38) NOT NULL,
                data_hora DATETIME NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                status VARCHAR(15) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                PRIMARY KEY (pedido_id)
);

ALTER TABLE pedidos COMMENT 'Tabela com os pedidos solicitados pelos clientes.';

ALTER TABLE pedidos MODIFY COLUMN pedido_id NUMERIC(38) COMMENT 'Primary key da tabela pedidos que com o id de um pedido.';

ALTER TABLE pedidos MODIFY COLUMN data_hora TIMESTAMP COMMENT 'Horário e data em que o pedido foi realizado.';

ALTER TABLE pedidos MODIFY COLUMN cliente_id NUMERIC(38) COMMENT 'Id do cliente que realizou o pedido.';

ALTER TABLE pedidos MODIFY COLUMN status VARCHAR(15) COMMENT 'Situação da solicitação do pedido.';

ALTER TABLE pedidos MODIFY COLUMN loja_id NUMERIC(38) COMMENT 'Foreign key da tabela lojas referente ao id da loja.';


CREATE TABLE pedidos_itens (
                pedido_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                numero_da_linha NUMERIC(38) NOT NULL,
                preco_unitario NUMERIC(10,2) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                envio_id NUMERIC(38),
                PRIMARY KEY (pedido_id, produto_id)
);

ALTER TABLE pedidos_itens COMMENT 'Tabela que armazena dados dos itens de um pedido.';

ALTER TABLE pedidos_itens MODIFY COLUMN pedido_id NUMERIC(38) COMMENT 'Primary key e foreign key referente ao id do pedido.';

ALTER TABLE pedidos_itens MODIFY COLUMN produto_id NUMERIC(38) COMMENT 'Primary key e foreign key referente ao id do produto.';

ALTER TABLE pedidos_itens MODIFY COLUMN numero_da_linha NUMERIC(38) COMMENT 'Número da linha do item de um pedido.';

ALTER TABLE pedidos_itens MODIFY COLUMN preco_unitario NUMERIC(10, 2) COMMENT 'Preço unitário do item pedido.';

ALTER TABLE pedidos_itens MODIFY COLUMN quantidade NUMERIC(38) COMMENT 'Quantidade solicitada de um produto em um pedido.';

ALTER TABLE pedidos_itens MODIFY COLUMN envio_id NUMERIC(38) COMMENT 'Foreign key referente ao envio.';

--	Criação dos relacionamentos e foreign keys

ALTER TABLE estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

-- 	Checagens.

--	Excluir o Banco de dados e o usuário, caso existam.

DROP DATABASE IF EXISTS uvv;
DROP USER IF EXISTS welington;

--	Criação do usuário.

CREATE USER welington WITH
SUPERUSER
CREATEDB
CREATEROLE
ENCRYPTED PASSWORD '12345';


--	Criação do banco de dados.

CREATE DATABASE uvv WITH
OWNER = welington
TEMPLATE = template0
ENCODING = 'UTF8'
LC_COLLATE = 'pt_BR.UTF-8'
LC_CTYPE = 'pt_BR.UTF-8'
ALLOW_CONNECTIONS = true;

--	Conexão com o banco de dados

\c 'dbname=uvv host=localhost user= welington password=12345';

--	Criação do esquema e troca para esquema padrão.

CREATE SCHEMA lojas AUTHORIZATION welington;
ALTER USER welington
SET SEARCH_PATH TO lojas,"$user",public;

-- 	Criação das tabelas com os comentários:
--	Criação da tabela produtos com comentários.

CREATE TABLE lojas.produtos (
                produto_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                preco_unitario NUMERIC(10,2),
                detalhes BYTEA,
                imagem BYTEA,
                imagem_mime_type VARCHAR(512),
                imagem_arquivo VARCHAR(512),
                imagem_charset VARCHAR(512),
                imagem_ultima_atualizacao DATE,
                CONSTRAINT pk_produtos PRIMARY KEY (produto_id)
);
COMMENT ON TABLE lojas.produtos IS 'Tabela que armazena os produtos.';
COMMENT ON COLUMN lojas.produtos.produto_id IS 'Primary key da tabela produtos que contem o id de um determinado produto.';
COMMENT ON COLUMN lojas.produtos.nome IS 'Nome de um produto.';
COMMENT ON COLUMN lojas.produtos.preco_unitario IS 'Preço de uma unidade de um determinado produto.';
COMMENT ON COLUMN lojas.produtos.detalhes IS 'Arquivo com detalhes de um produto.';
COMMENT ON COLUMN lojas.produtos.imagem IS 'Imagem de um produto.';
COMMENT ON COLUMN lojas.produtos.imagem_mime_type IS 'Tipo de arquivo da imagem do produto.';
COMMENT ON COLUMN lojas.produtos.imagem_arquivo IS 'Arquivo da imagem do produto.';
COMMENT ON COLUMN lojas.produtos.imagem_charset IS 'Metadados referentes a imagem do produto.';
COMMENT ON COLUMN lojas.produtos.imagem_ultima_atualizacao IS 'Data da última modificação da imagem do produto.';

--	Criação da tabela lojas com comentários.

CREATE TABLE lojas.lojas (
                loja_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                endereco_web VARCHAR(100),
                endereco_fisico VARCHAR(512),
                latitude NUMERIC,
                longitude NUMERIC,
                logo BYTEA,
                logo_mime_type VARCHAR(512),
                logo_arquivo VARCHAR(512),
                logo_charset VARCHAR(512),
                logo_ultima_atualizacao DATE,
                CONSTRAINT pk_lojas PRIMARY KEY (loja_id)
);
COMMENT ON TABLE lojas.lojas IS 'Tabela que armazena as informações de cada loja.';
COMMENT ON COLUMN lojas.lojas.loja_id IS 'Primary key da tabela lojas que contem o id de uma loja.';
COMMENT ON COLUMN lojas.lojas.nome IS 'Nome da loja.';
COMMENT ON COLUMN lojas.lojas.endereco_web IS 'Endereco da pagina na internet da loja.';
COMMENT ON COLUMN lojas.lojas.endereco_fisico IS 'Endereco fisico da loja.';
COMMENT ON COLUMN lojas.lojas.latitude IS 'Latitude referente a localizacao geografica da loja.';
COMMENT ON COLUMN lojas.lojas.longitude IS 'longitude referente a localizacao geografica da loja.';
COMMENT ON COLUMN lojas.lojas.logo IS 'imagem da logo da loja.';
COMMENT ON COLUMN lojas.lojas.logo_mime_type IS 'Tipo de arquivo da imagem da logo.';
COMMENT ON COLUMN lojas.lojas.logo_arquivo IS 'Arquivo da imagem da logo.';
COMMENT ON COLUMN lojas.lojas.logo_charset IS 'Metadados referentes a logo.';
COMMENT ON COLUMN lojas.lojas.logo_ultima_atualizacao IS 'Data da ultima modificacao da logo.';

--	Criação da tabela estoques com comentários.

CREATE TABLE lojas.estoques (
                estoque_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                CONSTRAINT pk_estoques PRIMARY KEY (estoque_id)
);
COMMENT ON TABLE lojas.estoques IS 'Tabela que armazena a disponibilidade de um produto.';
COMMENT ON COLUMN lojas.estoques.estoque_id IS 'Primary key da tabela estoques que contem o id de um estoque.';
COMMENT ON COLUMN lojas.estoques.loja_id IS 'Foreign key que identifica a loja em que está o estoque.';
COMMENT ON COLUMN lojas.estoques.produto_id IS 'Foreign key que identifica o produto estocado.';
COMMENT ON COLUMN lojas.estoques.quantidade IS 'Quantidade de um determinado produto em um estoque';

--	Criação da tabela clientes com comentários.

CREATE TABLE lojas.clientes (
                cliente_id NUMERIC(38) NOT NULL,
                email VARCHAR(255) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                telefone1 VARCHAR(20),
                telefone2 VARCHAR(20),
                telefone3 VARCHAR(20),
                CONSTRAINT pk_clientes PRIMARY KEY (cliente_id)
);
COMMENT ON TABLE lojas.clientes IS 'Tabela que armazena os dados dos clientes.';
COMMENT ON COLUMN lojas.clientes.cliente_id IS 'Primary key da tabela clientes que contem o id do cliente.';
COMMENT ON COLUMN lojas.clientes.email IS 'Email cadastrado pelo cliente.';
COMMENT ON COLUMN lojas.clientes.nome IS 'Nome completo do cliente.';
COMMENT ON COLUMN lojas.clientes.telefone1 IS 'Primeiro número de telefone cadastrado pelo cliente.';
COMMENT ON COLUMN lojas.clientes.telefone2 IS 'Segundo número de telefone cadastrado pelo cliente.';
COMMENT ON COLUMN lojas.clientes.telefone3 IS 'Terceiro número de telefone cadastrado pelo cliente.';

--	Criação da tabela envios com comentários.

CREATE TABLE lojas.envios (
                envio_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                endereco_entrega VARCHAR(512) NOT NULL,
                status VARCHAR(15) NOT NULL,
                CONSTRAINT pk_envios PRIMARY KEY (envio_id)
);
COMMENT ON TABLE lojas.envios IS 'Tabela que armazena dados dos envios pedidos.'
COMMENT ON COLUMN lojas.envios.envio_id IS 'Primary key da tabela envios que contem o id do envio.';
COMMENT ON COLUMN lojas.envios.loja_id IS 'Foreign key referente a loja que fará o envio.';
COMMENT ON COLUMN lojas.envios.cliente_id IS 'Foreing key referente ao cliente que receberá/recebeu o envio';
COMMENT ON COLUMN lojas.envios.endereco_entrega IS 'Endereço que o pedido será enviado.';
COMMENT ON COLUMN lojas.envios.status IS 'Situação do envio.';

--	Criação da tabela pedidos com comentários.

CREATE TABLE lojas.pedidos (
                pedido_id NUMERIC(38) NOT NULL,
                data_hora TIMESTAMP NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                status VARCHAR(15) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                CONSTRAINT pk_pedidos PRIMARY KEY (pedido_id)
);
COMMENT ON TABLE lojas.pedidos IS 'Tabela com os pedidos solicitados pelos clientes.';
COMMENT ON COLUMN lojas.pedidos.pedido_id IS 'Primary key da tabela pedidos que contem o id de um determinado pedido.';
COMMENT ON COLUMN lojas.pedidos.data_hora IS 'Horário e data em que o pedido foi realizado.';
COMMENT ON COLUMN lojas.pedidos.cliente_id IS 'Id do cliente que realizou o pedido.';
COMMENT ON COLUMN lojas.pedidos.status IS 'Situação da solicitação do pedido.';
COMMENT ON COLUMN lojas.pedidos.loja_id IS 'Foreign key da tabela lojas referente ao id da loja em que foi solicitado o pedido.';

--	Criação da tabela pedidos_itens com comentários.

CREATE TABLE lojas.pedidos_itens (
                pedido_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                numero_da_linha NUMERIC(38) NOT NULL,
                preco_unitario NUMERIC(10,2) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                envio_id NUMERIC(38),
                CONSTRAINT pk_pedidos_itens PRIMARY KEY (pedido_id, produto_id)
);
COMMENT ON TABLE lojas.envios IS 'Tabela que armazena dados dos itens de um pedido.'
COMMENT ON COLUMN lojas.pedidos_itens.pedido_id IS 'Primary key da tabela pedidos_itens e foreign key referente ao id do pedido.';
COMMENT ON COLUMN lojas.pedidos_itens.produto_id IS 'Primary key da tabela pedidos_itens e foreign key referente ao id do produto.';
COMMENT ON COLUMN lojas.pedidos_itens.numero_da_linha IS 'Número da linha do item de um pedido.';
COMMENT ON COLUMN lojas.pedidos_itens.preco_unitario IS 'Preço unitário do item pedido.';
COMMENT ON COLUMN lojas.pedidos_itens.quantidade IS 'Quantidade solicitada de um produto em um pedido.';
COMMENT ON COLUMN lojas.pedidos_itens.envio_id IS 'Foreign key referente ao envio.';

-- 	Criação das chaves estrangeiras

ALTER TABLE lojas.estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES lojas.envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES lojas.pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Checagens.

ALTER TABLE lojas.pedidos
ADD CONSTRAINT cc_pedidos_status
CHECK(
status in ('CANCELADO','COMPLETO','ABERTO','PAGO','REEMBOLSO','ENVIADO')
);

ALTER TABLE lojas.envios
ADD CONSTRAINT cc_envios_status
CHECK(
status in ('CRIADO','ENVIADO','TRANSITO','ENTREGUE')
);

ALTER TABLE lojas.lojas
ADD CONSTRAINT cc_lojas
CHECK(
(endereco_web is not null) or (endereco_fisico is not null)
);

ALTER TABLE lojas.produtos
ADD CONSTRAINT cc_produtos_preco_unitario
CHECK(
preco_unitario >= 0
);

ALTER TABLE lojas.pedidos_itens
ADD CONSTRAINT cc_pedidos_itens_preco_unitario
CHECK(
preco_unitario >= 0
);

ALTER TABLE lojas.pedidos_itens
ADD CONSTRAINT cc_pedidos_itens_quantidade
CHECK(
quantidade >= 0
);

ALTER TABLE lojas.estoques
ADD CONSTRAINT cc_estoque_quantidade
CHECK(
quantidade >= 0
);

-- Deleta o banco de dados "uuv", se já estiver criado.
DROP DATABASE IF EXISTS uvv;

-- Comando para criar nova database nomeada uvv 
CREATE DATABASE uvv
CHARACTER SET = 'UTF8';

-- Comando para criar o user com liberdade para criar banco de dados 
CREATE USER rafael_bueno IDENTIFIED BY 'rafael';

GRANT CREATE, ALTER, DROP, REFERENCES, DELETE, UPDATE, INDEX, INSERT, SELECT 
ON uvv.* TO rafael_bueno;

-- Comando para entrar e usar o banco de dados criado anteriormente
USE uvv;

-- No MySql não conseguímos criar um esquema específico.

-- Criação e comentação da tabela produtos
CREATE TABLE produtos (
                produto_id                  NUMERIC(38)     NOT NULL,
                nome                        VARCHAR(255)    NOT NULL,
                preco_unitario              NUMERIC(10,2)   NOT NULL,
                detalhes 					LONGBLOB,
                imagem 						LONGBLOB,
                imagem_mime_type            VARCHAR(512),
                imagem_arquivo              VARCHAR(512)    NOT NULL,
                imagem_charset              VARCHAR(512),
                imagem_ultima_atualizacao   DATE,
                PRIMARY KEY (produto_id)
);

ALTER TABLE produtos COMMENT 'Registro dos produtos';

ALTER TABLE produtos MODIFY COLUMN produto_id NUMERIC(38) COMMENT 'Id do produto';

ALTER TABLE produtos MODIFY COLUMN nome VARCHAR(255) COMMENT 'Nome do produto';

ALTER TABLE produtos MODIFY COLUMN preco_unitario NUMERIC(10, 2) COMMENT 'Preço do produto';

ALTER TABLE produtos MODIFY COLUMN detalhes BLOB COMMENT 'Detalhes do produto';

ALTER TABLE produtos MODIFY COLUMN imagem BLOB COMMENT 'Imagem do produto';

ALTER TABLE produtos MODIFY COLUMN imagem_mime_type VARCHAR(512) COMMENT 'Formato da imagem';

ALTER TABLE produtos MODIFY COLUMN imagem_arquivo VARCHAR(512) COMMENT 'Arquivo da imagem';

ALTER TABLE produtos MODIFY COLUMN imagem_charset VARCHAR(512) COMMENT 'Tipo de codificação da imagem';

ALTER TABLE produtos MODIFY COLUMN imagem_ultima_atualizacao DATE COMMENT 'Data da última atualização da imagem do produto';

-- Criação e comentação da tabela clientes
CREATE TABLE clientes (
                cliente_id                  NUMERIC(38)     NOT NULL,
                email                       VARCHAR(255)    NOT NULL,
                nome                        VARCHAR(255)    NOT NULL,
                telefone1                   VARCHAR(20),
                telefone2                   VARCHAR(20),
                telefone3                   VARCHAR(20),
                PRIMARY KEY (cliente_id)
);

ALTER TABLE clientes COMMENT 'Registro dos dados dos clientes';

ALTER TABLE clientes MODIFY COLUMN cliente_id NUMERIC(38) COMMENT 'Id do cliente';

ALTER TABLE clientes MODIFY COLUMN email VARCHAR(255) COMMENT 'Email do cliente';

ALTER TABLE clientes MODIFY COLUMN nome VARCHAR(255) COMMENT 'Nome do cliente';

ALTER TABLE clientes MODIFY COLUMN telefone1 VARCHAR(20) COMMENT 'Primeiro telefone do cliente';

ALTER TABLE clientes MODIFY COLUMN telefone2 VARCHAR(20) COMMENT 'Segundo telefone do cliente';

ALTER TABLE clientes MODIFY COLUMN telefone3 VARCHAR(20) COMMENT 'Terceiro telefone do cliente';

-- Criação e comentação da tabela pedidos
CREATE TABLE pedidos (
                pedido_id                   NUMERIC(38)     NOT NULL,
                data_hora                   DATETIME        NOT NULL,
                cliente_id                  NUMERIC(38)     NOT NULL,
                status                      VARCHAR(15)     NOT NULL,
                loja_id                     NUMERIC(38)     NOT NULL,
                PRIMARY KEY (pedido_id)
);

ALTER TABLE pedidos COMMENT 'Tabela de pedidos';

ALTER TABLE pedidos MODIFY COLUMN pedido_id NUMERIC(38) COMMENT 'Id do pedido do cliente';

ALTER TABLE pedidos MODIFY COLUMN data_hora TIMESTAMP COMMENT 'Data e horário do pedido';

ALTER TABLE pedidos MODIFY COLUMN cliente_id NUMERIC(38) COMMENT 'Id do cliente';

ALTER TABLE pedidos MODIFY COLUMN status VARCHAR(15) COMMENT 'Status do pedido';

ALTER TABLE pedidos MODIFY COLUMN loja_id NUMERIC(38) COMMENT 'Id da loja vendedora';

-- Criação e comentação da tabela lojas
CREATE TABLE lojas (
                loja_id                     NUMERIC(38)     NOT NULL,
                nome                        VARCHAR(255)    NOT NULL,
                endereco_web                VARCHAR(100),
                endereco_fisico             VARCHAR(512),
                latitude                    NUMERIC,
                longitude                   NUMERIC,
                logo                        LONGBLOB,
                logo_mime_type              VARCHAR(512),
                logo_arquivo                VARCHAR(512),
                logo_charset                VARCHAR(512),
                logo_ultima_atualizacao     DATE,
                pedido_id                   NUMERIC(38)     NOT NULL,
                PRIMARY KEY (loja_id)
);

ALTER TABLE lojas COMMENT 'Tabela das lojas registradas';

ALTER TABLE lojas MODIFY COLUMN loja_id NUMERIC(38) COMMENT 'Id da loja registrada';

ALTER TABLE lojas MODIFY COLUMN nome VARCHAR(255) COMMENT 'Nome da loja';

ALTER TABLE lojas MODIFY COLUMN endereco_web VARCHAR(100) COMMENT 'Link da loja';

ALTER TABLE lojas MODIFY COLUMN endereco_fisico VARCHAR(512) COMMENT 'Endereço físico da loja';

ALTER TABLE lojas MODIFY COLUMN latitude NUMERIC COMMENT 'Latitude';

ALTER TABLE lojas MODIFY COLUMN longitude NUMERIC COMMENT 'Longitude';

ALTER TABLE lojas MODIFY COLUMN logo BLOB COMMENT 'Logo da loja';

ALTER TABLE lojas MODIFY COLUMN logo_mime_type VARCHAR(512) COMMENT 'Tipo do arquivo da imagem';

ALTER TABLE lojas MODIFY COLUMN logo_arquivo VARCHAR(512) COMMENT 'Arquivo da logo';

ALTER TABLE lojas MODIFY COLUMN logo_charset VARCHAR(512) COMMENT 'Codificação do arquivo da logo';

ALTER TABLE lojas MODIFY COLUMN logo_ultima_atualizacao DATE COMMENT 'Data da última atualização da logo';

ALTER TABLE lojas MODIFY COLUMN pedido_id NUMERIC(38) COMMENT 'Id do pedido do cliente';

-- Criação e comentação da tabela estoques
CREATE TABLE estoques (
                estoque_id              NUMERIC(38)     NOT NULL,
                loja_id                 NUMERIC(38)     NOT NULL,
                produto_id              NUMERIC(38)     NOT NULL,
                quantidade              NUMERIC(38)     NOT NULL,
                PRIMARY KEY (estoque_id)
);

ALTER TABLE estoques COMMENT 'Registro do estoque';

ALTER TABLE estoques MODIFY COLUMN estoque_id NUMERIC(38) COMMENT 'Id do estoque';

ALTER TABLE estoques MODIFY COLUMN loja_id NUMERIC(38) COMMENT 'Id da loja registrada';

ALTER TABLE estoques MODIFY COLUMN produto_id NUMERIC(38) COMMENT 'Id do produto';

ALTER TABLE estoques MODIFY COLUMN quantidade NUMERIC(38) COMMENT 'Quantidade do produto';

-- Criação e comentação da tabela envios
CREATE TABLE envios (
                envio_id                NUMERIC(38)     NOT NULL,
                loja_id                 NUMERIC(38)     NOT NULL,
                cliente_id              NUMERIC(38)     NOT NULL,
                endereco_entrega        VARCHAR(512)    NOT NULL,
                status                  VARCHAR(15)     NOT NULL,
                PRIMARY KEY (envio_id)
);

ALTER TABLE envios COMMENT 'Registro dos envios realizados';

ALTER TABLE envios MODIFY COLUMN envio_id NUMERIC(38) COMMENT 'Id do envio';

ALTER TABLE envios MODIFY COLUMN loja_id NUMERIC(38) COMMENT 'Id da loja';

ALTER TABLE envios MODIFY COLUMN cliente_id NUMERIC(38) COMMENT 'Id do cliente';

ALTER TABLE envios MODIFY COLUMN endereco_entrega VARCHAR(512) COMMENT 'Endereço de entrega do cliente';

ALTER TABLE envios MODIFY COLUMN status VARCHAR(15) COMMENT 'Status do envio';

-- Criação e comentação da tabela pedido_itens
CREATE TABLE pedidos_itens (
                pedido_id               NUMERIC(38)     NOT NULL,
                produto_id              NUMERIC(38)     NOT NULL,
                numero_da_linha         NUMERIC(38)     NOT NULL,
                preco_unitario          NUMERIC(10,2)   NOT NULL,
                quantidade              NUMERIC(38)     NOT NULL,
                envio_id                NUMERIC(38)     NOT NULL,
                PRIMARY KEY (pedido_id, produto_id)
);

ALTER TABLE pedidos_itens COMMENT 'Tabela dos pedidos';

ALTER TABLE pedidos_itens MODIFY COLUMN pedido_id NUMERIC(38) COMMENT 'Id de pedido';

ALTER TABLE pedidos_itens MODIFY COLUMN produto_id NUMERIC(38) COMMENT 'Id do produto';

ALTER TABLE pedidos_itens MODIFY COLUMN numero_da_linha NUMERIC(38) COMMENT 'Número da linha';

ALTER TABLE pedidos_itens MODIFY COLUMN preco_unitario NUMERIC(10, 2) COMMENT 'Preço unitário do produto';

ALTER TABLE pedidos_itens MODIFY COLUMN quantidade NUMERIC(38) COMMENT 'Quantidade de itens no pedido';

ALTER TABLE pedidos_itens MODIFY COLUMN envio_id NUMERIC(38) COMMENT 'Id do envio';

-- Fim da criação de tabelas.

-- Constraint de verificação status do pedido.
ALTER TABLE pedidos
ADD CONSTRAINT verif_status_pedidos
CHECK (status IN ('COMPLETO', 'CANCELADO', 'REEMBOLSADO', 'ABERTO', 'PAGO', 'ENVIADO'));

-- Constraint de verificação status do envio.
ALTER TABLE envios
ADD CONSTRAINT verif_status_envios
CHECK (status IN ('TRANSITO', 'ENTREGUE', 'ENVIADO', 'CRIADO'));

-- Constriant para verificar se ou o endereço físico ou o endereço web está preenchido, se nenhum dos dois estiverem, vai dar erro.
ALTER TABLE lojas
ADD CONSTRAINT verif_endereco
CHECK ((endereco_fisico IS NOT NULL AND endereco_web IS NULL) OR
       (endereco_fisico IS NULL AND endereco_web IS NOT NULL));

-- Configuração das Primary Key's e Foreign Key's
ALTER TABLE estoques ADD CONSTRAINT produtos_estoque_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE lojas ADD CONSTRAINT pedidos_lojas_fk
FOREIGN KEY (pedido_id)
REFERENCES pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE estoques ADD CONSTRAINT lojas_estoque_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

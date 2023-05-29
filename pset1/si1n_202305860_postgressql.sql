-- ALUNO: RAFAEL DE JESUS BUENO PEREIRA
-- TURMA: SI1N

-- Criei uma condicional para a exclusão do banco de dados UVV, caso já exista.
DROP DATABASE IF EXISTS uvv;

-- Criei uma condicional para a exclusão do usuário, caso já exista.
DROP USER IF EXISTS rafael_bueno;

-- Criei meu usuário com a senha encriptada, já com o atributo de login e com a permissão de criação de banco de dados.

CREATE USER     rafael_bueno
                WITH ENCRYPTED PASSWORD 'admin'
                LOGIN
                CREATEDB
               	CREATEROLE;

-- Cria um banco de dados, com os atributos solicitados pelo professor, já com o dono no meu usuário criado anteriormente.

CREATE DATABASE uvv
                OWNER=rafael_bueno
                TEMPLATE template0
                ENCODING 'UTF8'
                LC_COLLATE 'pt_BR.UTF-8'
                LC_CTYPE 'pt_BR.UTF-8'
                ALLOW_CONNECTIONS TRUE;
               
COMMENT ON DATABASE uvv IS 'Banco de dados para ter controle das vendas e das lojas registradas no sistema UVV.';

-- Conecto no banco de dados criado usando meu usuário já com a senha.

\c "dbname=uvv user=rafael_bueno password=admin";

-- Crio o esquema lojas, dando autorização de uso para o meu usuário criado.

CREATE SCHEMA lojas
AUTHORIZATION rafael_bueno;

-- Comando para saber qual esquema esta sendo usado

SELECT CURRENT_SCHEMA ();

-- Comando para saber qual path esta sendo usado

SHOW SEARCH_PATH;

-- Comando para setar "lojas" como path principal a ser usado

SET SEARCH_PATH TO lojas, "$user", public;

-- Comando para confirmar que o path a estar sendo usado é o "lojas"

SHOW SEARCH_PATH;

-- Comando para alterar o user que esta sendo usado para fazer os comandos

ALTER USER rafael_bueno
SET SEARCH_PATH TO lojas, "$user", public;

-- comando para alterar o user que esta sendo usado para fazer os comandos
-- Criação da tabela produtos para ter controle dos produtos registrados.
CREATE TABLE produtos (
                produto_id 					NUMERIC(38) 	NOT NULL,
                nome 					VARCHAR(255) 	NOT NULL,
                preco_unitario 			       NUMERIC(10,2),
                detalhes 					BYTEA,
                imagem 					BYTEA,
                imagem_mime_type 				VARCHAR(512),
                imagem_arquivo 				VARCHAR(512),
                imagem_charset 				VARCHAR(512),
                imagem_ultima_atualizacao 		DATE,
                CONSTRAINT produto_id_pk PRIMARY KEY (produto_id)
);

COMMENT ON TABLE produtos IS 'Registro dos produtos';
COMMENT ON COLUMN produtos.produto_id IS 'SKU do produto';
COMMENT ON COLUMN produtos.nome IS 'Nome do produto';
COMMENT ON COLUMN produtos.preco_unitario IS 'Preço do produto';
COMMENT ON COLUMN produtos.detalhes IS 'Detalhes do produto';
COMMENT ON COLUMN produtos.imagem IS 'Imagem do produto';
COMMENT ON COLUMN produtos.imagem_mime_type IS 'Formato da imagem';
COMMENT ON COLUMN produtos.imagem_arquivo IS 'Arquivo da imagem';
COMMENT ON COLUMN produtos.imagem_charset IS 'Tipo de codificação da imagem';
COMMENT ON COLUMN produtos.imagem_ultima_atualizacao IS 'Data da última atualização da imagem do produto';

-- Criação da tabela lojas com todo o registro que cada loja precisa para operar.

CREATE TABLE lojas (
                loja_id 					NUMERIC(38) 	NOT NULL,
                nome 					VARCHAR(255) 	NOT NULL,
                endereco_web 				VARCHAR(100),
                endereco_fisico 				VARCHAR(512),
                latitude 					NUMERIC,
                longitude 					NUMERIC,
                logo 					BYTEA,
                logo_mime_type 			       VARCHAR(512),
                logo_arquivo 			       VARCHAR(512),
                logo_charset 				VARCHAR(512),
                logo_ultima_atualizacao 		       DATE,
                CONSTRAINT loja_id_pk PRIMARY KEY (loja_id)
);

COMMENT ON TABLE lojas IS 'Lojas registradas';
COMMENT ON COLUMN lojas.loja_id IS 'Id da loja registrada';
COMMENT ON COLUMN lojas.nome IS 'Nome da loja';
COMMENT ON COLUMN lojas.endereco_web IS 'Link web da loja';
COMMENT ON COLUMN lojas.endereco_fisico IS 'Endereço físico da loja';
COMMENT ON COLUMN lojas.latitude IS 'Latitude';
COMMENT ON COLUMN lojas.longitude IS 'Longitude';
COMMENT ON COLUMN lojas.logo IS 'Logo da loja';
COMMENT ON COLUMN lojas.logo_mime_type IS 'Tipo do arquivo da logo';
COMMENT ON COLUMN lojas.logo_arquivo IS 'Arquivo da logo';
COMMENT ON COLUMN lojas.logo_charset IS 'Codificação do arquivo da logo';
COMMENT ON COLUMN lojas.logo_ultima_atualizacao IS 'Data da última atualização da logo';

-- Criação da tabela estoques para cada loja ter controle de cada produto no estoque de cada loja.

CREATE TABLE estoques (
                estoque_id 					NUMERIC(38) 	NOT NULL,
                loja_id 					NUMERIC(38) 	NOT NULL,
                produto_id 					NUMERIC(38) 	NOT NULL,
                quantidade 					NUMERIC(38) 	NOT NULL,
                CONSTRAINT estoque_id_pk PRIMARY KEY (estoque_id)
);

COMMENT ON TABLE estoques IS 'Registro do estoque';
COMMENT ON COLUMN estoques.estoque_id IS 'Id do estoque';
COMMENT ON COLUMN estoques.loja_id IS 'Id da loja registrada';
COMMENT ON COLUMN estoques.produto_id IS 'SKU do produto';
COMMENT ON COLUMN estoques.quantidade IS 'Quantidade do produto';

-- Criação da tabela clientes para ter controle dos dados de contato de cada cliente.

CREATE TABLE clientes (
                cliente_id 					NUMERIC(38) 	NOT NULL,
                email 					VARCHAR(255) 	NOT NULL,
                nome 					VARCHAR(255) 	NOT NULL,
                telefone1 					VARCHAR(20),
                telefone2 					VARCHAR(20),
                telefone3 					VARCHAR(20),
                CONSTRAINT cliente_id_pk PRIMARY KEY (cliente_id)
);

COMMENT ON TABLE clientes IS 'Registro dos clientes';
COMMENT ON COLUMN clientes.cliente_id IS 'Id do cliente';
COMMENT ON COLUMN clientes.email IS 'Email do cliente';
COMMENT ON COLUMN clientes.nome IS 'Nome do cliente';
COMMENT ON COLUMN clientes.telefone1 IS 'Telefone primário do cliente';
COMMENT ON COLUMN clientes.telefone2 IS 'Telefone secundário do cliente';
COMMENT ON COLUMN clientes.telefone3 IS 'Telefone terciário  do cliente';

-- Criação da tabela pedidos com os dados referente a cada pedido específico.

CREATE TABLE pedidos (
                pedido_id 					NUMERIC(38) 	NOT NULL,
                data_hora 					TIMESTAMP 	NOT NULL,
                cliente_id 					NUMERIC(38) 	NOT NULL,
                status 					VARCHAR(15) 	NOT NULL,
                loja_id 					NUMERIC(38) 	NOT NULL,
                CONSTRAINT pedido_id_pk PRIMARY KEY (pedido_id)
);

COMMENT ON TABLE pedidos IS 'Tabela de pedidos';
COMMENT ON COLUMN pedidos.pedido_id IS 'Id do pedido do cliente';
COMMENT ON COLUMN pedidos.data_hora IS 'Data e horário do pedido';
COMMENT ON COLUMN pedidos.cliente_id IS 'Id do cliente';
COMMENT ON COLUMN pedidos.status IS 'Status do pedido';
COMMENT ON COLUMN pedidos.loja_id IS 'Id da loja registrada';

-- Criação da tabela envios, da loja para controle dos envios.

CREATE TABLE envios (
                envio_id 					NUMERIC(38) 	NOT NULL,
                loja_id 					NUMERIC(38) 	NOT NULL,
                cliente_id 					NUMERIC(38) 	NOT NULL,
                endereco_entrega 				VARCHAR(512) 	NOT NULL,
                status 					VARCHAR(15) 	NOT NULL,
                CONSTRAINT envio_id_pk PRIMARY KEY (envio_id)
);

COMMENT ON TABLE envios IS 'Dados de entrega';
COMMENT ON COLUMN envios.envio_id IS 'id do envio';
COMMENT ON COLUMN envios.loja_id IS 'Id da loja';
COMMENT ON COLUMN envios.cliente_id IS 'Id do cliente';
COMMENT ON COLUMN envios.endereco_entrega IS 'Endereço de entrega do cliente';
COMMENT ON COLUMN envios.status IS 'Status do envio';

-- Criação da tabela referente aos itens presente no pedido.

CREATE TABLE pedidos_itens (
                pedido_id 					NUMERIC(38) 	NOT NULL,
                produto_id 					NUMERIC(38) 	NOT NULL,
                numero_da_linha 				NUMERIC(38) 	NOT NULL,
                preco_unitario 				NUMERIC(10,2) NOT NULL,
                quantidade 					NUMERIC(38) 	NOT NULL,
                envio_id 					NUMERIC(38),
                CONSTRAINT pedido_id_pk_1 PRIMARY KEY (pedido_id, produto_id)
);

COMMENT ON TABLE pedidos_itens IS 'Tabela dos pedidos';
COMMENT ON COLUMN pedidos_itens.pedido_id IS 'Id de pedido';
COMMENT ON COLUMN pedidos_itens.produto_id IS 'Id do produto';
COMMENT ON COLUMN pedidos_itens.numero_da_linha IS 'Número da linha';
COMMENT ON COLUMN pedidos_itens.preco_unitario IS 'Preço unitário do produto';
COMMENT ON COLUMN pedidos_itens.quantidade IS 'Quantidade de itens no pedido';
COMMENT ON COLUMN pedidos_itens.envio_id IS 'Id do envio';

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
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE estoques ADD CONSTRAINT lojas_estoque_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
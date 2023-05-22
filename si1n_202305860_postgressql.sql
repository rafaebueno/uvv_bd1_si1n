-- ALUNO: RAFAEL DE JESUS BUENO PEREIRA
-- TURMA: SI1N

CREATE USER     rafael_bueno
                WITH ENCRYPTED PASSWORD 'admin'
                LOGIN
                CREATEDB;

-- Criei meu usuário com a senha encriptada, já com o atributo de login e com a permissão de criação de banco de dados.

DROP DATABASE IF EXISTS uvv;

-- Criei uma condicional para a exclusão do banco de dados UVV, caso já exista.

CREATE DATABASE uvv
                OWNER=rafael_bueno
                TEMPLATE template0
                ENCODING 'UTF8'
                LC_COLLATE 'pt_BR.UTF-8'
                LC_CTYPE 'pt_BR.UTF-8'
                ALLOW_CONNECTIONS TRUE;

-- Cria um banco de dados, com os atributos solicitados pelo professor, já com o dono no meu usuário criado anteriormente.

GRANT ALL PRIVILEGES ON DATABASE uvv TO rafael_bueno;

-- Dou todas as permissões e privilégios do banco de dados para meu usuário.

\c "dbname=uvv user=rafael_bueno password=admin";

-- Conecto no banco de dados criado usando meu usuário já com a senha.

DROP SCHEMA IF EXISTS lojas;

-- Condicional para exclusão do esquema Lojas, se já estiver criado.

CREATE SCHEMA lojas
AUTHORIZATION rafael_bueno;

-- Crio o esquema lojas.

SELECT CURRENT_SCHEMA ();

-- Comando para saber qual esquema esta sendo usado.

SHOW SEARCH_PATH;

-- Comando para saber qual path esta sendo usado.

SET SEARCH_PATH TO lojas, "$user", public;

-- Comando para setar o hr como path principal a ser usado.

SHOW SEARCH_PATH;

-- Comando para confirmar que o path a estar sendo usado é o hr.

SET SEARCH_PATH TO lojas, "$user", public;

-- Comando para alterar o user que esta sendo usado para fazer os comandos.


-- Criação das tabelas em geral.
CREATE TABLE    produtos (
                produto_id 						NUMERIC(38) NOT NULL,
                nome 							VARCHAR(255) NOT NULL,
                preco_unitario 					        NUMERIC(10,2) NOT NULL,
                detalhes                                                BYTEA,
                imagem                                                  BYTEA,
                imagem_mime_type 				        VARCHAR(512),
                imagem_arquivo 					        VARCHAR(512) NOT NULL,
                imagem_charset 					        VARCHAR(512),
                imagem_ultima_atualizacao 		                DATE,
                CONSTRAINT produto_id_pk PRIMARY KEY (produto_id)
);

COMMENT ON TABLE produtos IS 'Tabela dos produtos';

COMMENT ON COLUMN produtos.produto_id IS 'Id do produto registrado';

COMMENT ON COLUMN produtos.nome IS 'Nome do produto';

COMMENT ON COLUMN produtos.preco_unitario IS 'Preço unitário do produto';

COMMENT ON COLUMN produtos.detalhes IS 'Detalhes do produto';

COMMENT ON COLUMN produtos.imagem IS 'Imagem do produto';

COMMENT ON COLUMN produtos.imagem_mime_type IS 'Formato da imagem';

COMMENT ON COLUMN produtos.imagem_arquivo IS 'Arquivo da imagem';

COMMENT ON COLUMN produtos.imagem_charset IS 'Codificação da imagem do produto';

COMMENT ON COLUMN produtos.imagem_ultima_atualizacao IS 'Última atualização da imagem do produto';

-- Criação da tabela produtos, com as especificações de cada produto registrado.

CREATE TABLE    clientes (
                cliente_id 						NUMERIC(38) NOT NULL,
                email 							VARCHAR(255) NOT NULL,
                nome 							VARCHAR(255) NOT NULL,
                telefone1 						VARCHAR(20),
                telefone2 						VARCHAR(20),
                telefone3 						VARCHAR(20),
                CONSTRAINT cliente_id_pk PRIMARY KEY (cliente_id)
);

COMMENT ON TABLE clientes IS 'Registro dos clientes';

COMMENT ON COLUMN clientes.cliente_id IS 'Id do cliente';

COMMENT ON COLUMN clientes.email IS 'Email do cliente';

COMMENT ON COLUMN clientes.nome IS 'Nome do cliente';

COMMENT ON COLUMN clientes.telefone1 IS 'Telefone primário do cliente';

COMMENT ON COLUMN clientes.telefone2 IS 'Telefone secundário do cliente';

COMMENT ON COLUMN clientes.telefone3 IS 'Telefone terciário  do cliente';

-- Criação da tabela clientes, com os dados individuais de cada cliente.

CREATE TABLE    pedidos (
                pedido_id 						NUMERIC(38) NOT NULL,
                data_hora 						TIMESTAMP NOT NULL,
                cliente_id 						NUMERIC(38) NOT NULL,
                status 							VARCHAR(15) NOT NULL,
                loja_id 						NUMERIC(38) NOT NULL,
                CONSTRAINT pedido_id_pk PRIMARY KEY (pedido_id)
);

COMMENT ON TABLE pedidos IS 'Registro dos pedidos criados';

COMMENT ON COLUMN pedidos.pedido_id IS 'Id do pedido do cliente';

COMMENT ON COLUMN pedidos.data_hora IS 'Data e horário do pedido';

COMMENT ON COLUMN pedidos.cliente_id IS 'Id do cliente';

COMMENT ON COLUMN pedidos.status IS 'Status de andamento do pedido';

COMMENT ON COLUMN pedidos.loja_id IS 'Id da loja';

-- Criação da tabela pedidos, com os dados de cada pedido especificado.

CREATE TABLE    lojas (
                loja_id 						NUMERIC(38) NOT NULL,
                nome 							VARCHAR(255) NOT NULL,
                endereco_web 					        VARCHAR(100),
                endereco_fisico 				        VARCHAR(512),
                latitude 						NUMERIC,
                longitude 						NUMERIC,
                logo                                                    BYTEA,
                logo_mime_type 					        VARCHAR(512),
                logo_arquivo 					        VARCHAR(512),
                logo_charset 					        VARCHAR(512),
                logo_ultima_atualizacao 		                DATE,
                pedido_id 						NUMERIC(38) NOT NULL,
                CONSTRAINT loja_id_pk PRIMARY KEY (loja_id)
);

COMMENT ON TABLE lojas IS 'Tabela das lojas registradas';

COMMENT ON COLUMN lojas.loja_id IS 'Id da loja registrada';

COMMENT ON COLUMN lojas.nome IS 'Nome da loja';

COMMENT ON COLUMN lojas.endereco_web IS 'Link da loja na internet';

COMMENT ON COLUMN lojas.endereco_fisico IS 'Endereço físico da loja';

COMMENT ON COLUMN lojas.latitude IS 'Coordenada latitude';

COMMENT ON COLUMN lojas.longitude IS 'Coordenada longitude';

COMMENT ON COLUMN lojas.logo IS 'Logo da loja';

COMMENT ON COLUMN lojas.logo_mime_type IS 'Tipo do arquivo da logo em imagem';

COMMENT ON COLUMN lojas.logo_arquivo IS 'Arquivo da logo';

COMMENT ON COLUMN lojas.logo_charset IS 'Codificação do arquivo da logo';

COMMENT ON COLUMN lojas.logo_ultima_atualizacao IS 'Última atualização da logo';

COMMENT ON COLUMN lojas.pedido_id IS 'Id do pedido do cliente';

-- Criação da tabela lojas com todo o registro que cada loja precisa para operar.

CREATE TABLE    estoques (
                estoque_id 						NUMERIC(38) NOT NULL,
                loja_id 						NUMERIC(38) NOT NULL,
                produto_id 						NUMERIC(38) NOT NULL,
                quantidade 						NUMERIC(38) NOT NULL,
                CONSTRAINT estoque_id_pk PRIMARY KEY (estoque_id)
);

COMMENT ON TABLE estoques IS 'Registro do estoque - Entrada e Saída';

COMMENT ON COLUMN estoques.estoque_id IS 'Id do estoque';

COMMENT ON COLUMN estoques.loja_id IS 'Id da loja registrada';

COMMENT ON COLUMN estoques.produto_id IS 'Id do produto';

COMMENT ON COLUMN estoques.quantidade IS 'Quantidade do produto em estoque';

-- Criação da tabela estoques para ter controle do estoque de cada produto de cada loja.

CREATE TABLE    envios (
                envio_id 						NUMERIC(38) NOT NULL,
                loja_id 						NUMERIC(38) NOT NULL,
                cliente_id 						NUMERIC(38) NOT NULL,
                endereco_entrega 				        VARCHAR(512) NOT NULL,
                status 							VARCHAR(15) NOT NULL,
                CONSTRAINT envio_id_pk PRIMARY KEY (envio_id)
);

COMMENT ON TABLE envios IS 'Dados para entrega';

COMMENT ON COLUMN envios.envio_id IS 'Id do envio';

COMMENT ON COLUMN envios.loja_id IS 'Id da loja';

COMMENT ON COLUMN envios.cliente_id IS 'Id do cliente';

COMMENT ON COLUMN envios.endereco_entrega IS 'Endereço de entrega do cliente';

COMMENT ON COLUMN envios.status IS 'Status do andamento do envio';

-- Criação da tabela envios para controle dos envios dos pedidos.

CREATE TABLE    pedidos_itens (
                pedido_id 						NUMERIC(38) NOT NULL,
                produto_id 						NUMERIC(38) NOT NULL,
                numero_da_linha 				        NUMERIC(38) NOT NULL,
                preco_unitario 					        NUMERIC(10,2) NOT NULL,
                quantidade 						NUMERIC(38) NOT NULL,
                envio_id 						NUMERIC(38),
                CONSTRAINT pedido_id_pk_1 PRIMARY KEY (pedido_id, produto_id)
);

COMMENT ON TABLE pedidos_itens IS 'Tabela dos itens do pedido';

COMMENT ON COLUMN pedidos_itens.pedido_id IS 'Id de pedido';

COMMENT ON COLUMN pedidos_itens.produto_id IS 'Id do produto';

COMMENT ON COLUMN pedidos_itens.numero_da_linha IS 'Número da linha';

COMMENT ON COLUMN pedidos_itens.preco_unitario IS 'Preço unitário do produto';

COMMENT ON COLUMN pedidos_itens.quantidade IS 'Quantidade de itens no pedido';

COMMENT ON COLUMN pedidos_itens.envio_id IS 'Id do envio';

-- Criação da tabela pedidos para ver quais os itens que estão incluídos no pedido.

-- Final da criação das tabelas e dos comentários.

ALTER TABLE pedidos 
ADD CONSTRAINT verif_status_pedidos
CHECK (status IN ('CANCELADO', 'COMPLETO', 'ABERTO', 'PAGO', 'REEMBOLSADO', 'ENVIADO'));

-- Constraint de checagem para verificação do status do pedido para ver tem um status válido.

ALTER TABLE envios 
ADD CONSTRAINT verif_status_envios
CHECK (status IN ('CRIADO', 'ENVIADO', 'TRANSITO', 'ENTREGUE'));

-- Constraint para checar se o status do envio do pedido foi feito e checar a última atuaização.

ALTER TABLE lojas
ADD CONSTRAINT verif_endereco
CHECK ((endereco_fisico IS NOT NULL AND endereco_web IS NULL) OR
       (endereco_fisico IS NULL AND endereco_web IS NOT NULL));
      
-- Constraint de checagem, ou o endereço físico está preenchido ou o endereço web está preenchido, não pode os dois estarem vazios.

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

ALTER TABLE lojas ADD CONSTRAINT pedidos_lojas_fk
FOREIGN KEY (pedido_id)
REFERENCES pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES pedidos (pedido_id)
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

ALTER TABLE pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

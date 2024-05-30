/*
Empresa LeadTech

Bianca Leticia Román Caldeira - RM552267 - Turma : 2TDSPH
Charlene Aparecida Estevam Mendes Fialho - RM552252 - Turma : 2TDSPH
Lais Alves Da Silva Cruz - RM 552258 - Turma : 2TDSPH
Lucca Raphael Pereira dos Santos - RM 99675 - Turma : 2TDSPW
Fabrico Torres Antonio - RM 97916 - Turma : 2TDSPH
*/

-- DDL (DROP,CREATE, ALTER)
-- Comandos para definição de dados, incluindo a remoção de tabelas existentes, criações, alterações e suas restrições.

/* DROPS */
/* Remove a tabela 'categoria' e quaisquer restrições que dependem dela */
DROP TABLE categoria CASCADE CONSTRAINTS;

/* Remove a tabela 'deteccao' e quaisquer restrições que dependem dela */
DROP TABLE deteccao CASCADE CONSTRAINTS;

/* Remove a tabela 'especie' e quaisquer restrições que dependem dela */
DROP TABLE especie CASCADE CONSTRAINTS;

/* Remove a tabela 'localizacao' e quaisquer restrições que dependem dela */
DROP TABLE localizacao CASCADE CONSTRAINTS;

/* Remove a tabela 'ong' e quaisquer restrições que dependem dela */
DROP TABLE ong CASCADE CONSTRAINTS;

/* Remove a tabela 'situacao' e quaisquer restrições que dependem dela */
DROP TABLE situacao CASCADE CONSTRAINTS;

/* Remove a tabela 'usuario' e quaisquer restrições que dependem dela */
DROP TABLE usuario CASCADE CONSTRAINTS;

/* CREATES TABLES */

/* Tabela para armazenar informações dos usuários */
CREATE TABLE usuario (
    id_usuario NUMBER(8) PRIMARY KEY,     -- ID único do usuário
    nome VARCHAR2(60),                     -- Nome do usuário
    email VARCHAR2(30),                    -- Endereço de e-mail do usuário
    senha VARCHAR2(20)                     -- Senha do usuário
);

/* Tabela para armazenar informações das organizações não governamentais (ONGs) */
CREATE TABLE ong (
    id_ong NUMBER(8) PRIMARY KEY,          -- ID único da ONG
    cnpj VARCHAR2(14),                      -- CNPJ da ONG
    nome VARCHAR2(60),                      -- Nome da ONG
    email VARCHAR2(30),                     -- Endereço de e-mail da ONG
    telefone VARCHAR2(12)                   -- Número de telefone da ONG
);

/* Tabela para armazenar informações de localização geográfica */
CREATE TABLE localizacao (
    id_localizacao NUMBER(8) PRIMARY KEY,   -- ID único da localização
    latitude NUMBER(9,6),                   -- Coordenada de latitude
    longitude NUMBER(9,6),                  -- Coordenada de longitude
    cidade VARCHAR2(40),                    -- Nome da cidade
    estado VARCHAR2(40),                    -- Nome do estado
    pais VARCHAR2(40)                       -- Nome do país
);

/* Tabela para armazenar informações de categorias de espécies */
CREATE TABLE categoria (
    id_categoria NUMBER(8) PRIMARY KEY,     -- ID único da categoria
    nome VARCHAR2(60),                      -- Nome da categoria
    habitat VARCHAR2(30),                   -- Tipo de habitat da categoria
    reino VARCHAR2(30),                     -- Reino da categoria
    familia VARCHAR2(30)                    -- Família taxonômica da categoria
);

/* Tabela para armazenar informações sobre a situação de uma espécie */
CREATE TABLE situacao (
    id_situacao NUMBER(8) PRIMARY KEY,      -- ID único da situação
    risco_extincao CHAR(1),                 -- Indica se a espécie está em risco de extinção (S/N)
    invasora CHAR(1)                        -- Indica se a espécie é invasora (S/N)
);

/* Tabela para armazenar informações sobre espécies */
CREATE TABLE especie (
    id_especie NUMBER(8) PRIMARY KEY,       -- ID único da espécie
    nome_comum VARCHAR2(60),                -- Nome comum da espécie
    nome_cientifico VARCHAR2(60),           -- Nome científico da espécie
    descricao VARCHAR2(150),                -- Descrição da espécie
    situacao_id NUMBER(8) NOT NULL,         -- ID da situação da espécie (chave estrangeira)
    categoria_id NUMBER(8) NOT NULL         -- ID da categoria da espécie (chave estrangeira)
);

/* Tabela para armazenar informações sobre detecções de espécies */
CREATE TABLE deteccao (
    id_deteccao NUMBER(8) PRIMARY KEY,      -- ID único da detecção
    url_imagem VARCHAR2(60),                 -- URL da imagem da detecção
    data_deteccao DATE,                      -- Data da detecção
    usuario_id NUMBER(8) NOT NULL,           -- ID do usuário que fez a detecção (chave estrangeira)
    especie_id NUMBER(8) NOT NULL,           -- ID da espécie detectada (chave estrangeira)
    ong_id NUMBER(8) NOT NULL,               -- ID da ONG que registrou a detecção (chave estrangeira)
    localizacao_id NUMBER(8) NOT NULL        -- ID da localização da detecção (chave estrangeira)
);


/* ALTERS TABLES */
/*ADD Chaves Extrangeiras - relacionamentos*/

-- Chave estrangeira para relacionamento com a tabela especie
ALTER TABLE deteccao ADD CONSTRAINT fk_deteccao_especie FOREIGN KEY ( especie_id )REFERENCES especie ( id_especie );
-- Chave estrangeira para relacionamento com a tabela localizacao
ALTER TABLE deteccao ADD CONSTRAINT fk_deteccao_localizacao FOREIGN KEY ( localizacao_id ) REFERENCES localizacao ( id_localizacao );
-- Chave estrangeira para relacionamento com a tabela ong
ALTER TABLE deteccao ADD CONSTRAINT fk_deteccao_ong FOREIGN KEY ( ong_id ) REFERENCES ong ( id_ong );
-- Chave estrangeira para relacionamento com a tabela usuario
ALTER TABLE deteccao ADD CONSTRAINT fk_deteccao_usuario FOREIGN KEY ( usuario_id ) REFERENCES usuario ( id_usuario );
-- Chave estrangeira para relacionamento com a tabela categoria
ALTER TABLE especie ADD CONSTRAINT fk_especie_categoria FOREIGN KEY ( categoria_id ) REFERENCES categoria ( id_categoria );
-- Chave estrangeira para relacionamento com a tabela situacao
ALTER TABLE especie ADD CONSTRAINT fk_especie_situacao FOREIGN KEY ( situacao_id ) REFERENCES situacao ( id_situacao );


/* CREATE TABLE DE REGISTROS DE LOGS*/
DROP TABLE registro_log CASCADE CONSTRAINTS; -- DROP da tabela log
CREATE TABLE registro_log (
    log_id NUMBER(8) GENERATED ALWAYS AS IDENTITY, -- Coluna de ID autoincrementável
    nome_procedure VARCHAR2(100),              -- Nome da Procedure
    username VARCHAR2(50),                     -- nome do user
    error_date DATE,                            -- Data do erro
    error_code VARCHAR2(10),                    -- Código de erro
    error_message VARCHAR2(200)               -- Mensagem de erro
);

-- CARGA DE DADOS -> Criação e Procedures 
SET SERVEROUTPUT ON;
SET VERIFY OFF;

/*DROPS PROCEDURES DE CARGA DE DADOS*/
DROP PROCEDURE carregar_usuario;
DROP PROCEDURE carregar_ong;
DROP PROCEDURE carregar_localizacao;
DROP PROCEDURE carregar_categoria;
DROP PROCEDURE carregar_situacao;
DROP PROCEDURE carregar_especie;
DROP PROCEDURE carregar_deteccao;

-- RELATÓRIOS

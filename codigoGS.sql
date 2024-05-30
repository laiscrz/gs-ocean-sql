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
CREATE TABLE usuario (
    id_usuario NUMBER(8) PRIMARY KEY,
    nome VARCHAR2(60),
    email VARCHAR2(30),
    senha VARCHAR2(20)
);

CREATE TABLE ong (
    id_ong NUMBER(8) PRIMARY KEY,
    cnpj VARCHAR2(14),
    nome VARCHAR2(60),
    email VARCHAR2(30),
    telefone VARCHAR2(12)
);

CREATE TABLE localizacao (
    id_localizacao NUMBER(8)PRIMARY KEY,
    latitude NUMBER(9,6),
    longitude NUMBER(9,6),
    cidade VARCHAR2(40),
    estado VARCHAR2(40),
    pais VARCHAR2(40)
);

CREATE TABLE categoria (
    id_categoria NUMBER(8) PRIMARY KEY,
    nome VARCHAR2(60),
    habitat VARCHAR2(30),
    reino VARCHAR2(30),
    familia VARCHAR2(30)
);

CREATE TABLE situacao (
    id_situacao NUMBER(8) PRIMARY KEY,
    risco_extincao CHAR(1),
    invasora CHAR(1)
);

CREATE TABLE especie (
    id_especie NUMBER(8) PRIMARY KEY,
    nome_comum VARCHAR2(60),
    nome_cientifico VARCHAR2(60),
    descricao VARCHAR2(150),
    situacao_id NUMBER(8) NOT NULL,
    categoria_id NUMBER(8) NOT NULL
);

CREATE TABLE deteccao (
    id_deteccao NUMBER(8) PRIMARY KEY,
    url_imagem VARCHAR2(60),
    data_deteccao DATE,
    usuario_id NUMBER(8) NOT NULL,
    especie_id NUMBER(8) NOT NULL,
    ong_id NUMBER(8) NOT NULL,
    localizacao_id NUMBER(8) NOT NULL
);

/* ALTERS TABLES */

/* CREATE TABLE DE LOG*/
DROP TABLE log CASCADE CONSTRAINTS; -- DROP da tabela log
CREATE TABLE log (
    log_id NUMBER(8) GENERATED ALWAYS AS IDENTITY, -- Coluna de ID autoincrementável
    procedure_name VARCHAR2(100),              -- Nome da Procedure
    error_date DATE,                            -- Data do erro
    error_code VARCHAR2(10),                    -- Código de erro
    error_message VARCHAR2(200)               -- Mensagem de erro
);

-- CARGA DE DADOS


-- RELATÓRIOS

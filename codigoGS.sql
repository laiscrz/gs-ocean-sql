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

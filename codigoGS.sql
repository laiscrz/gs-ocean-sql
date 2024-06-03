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
    genero CHAR(1),                        -- Genero do usuario (F/M)
    email VARCHAR2(30),                    -- Endereço de e-mail do usuário
    senha VARCHAR2(20)                     -- Senha do usuário
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
    localizacao_id NUMBER(8) NOT NULL        -- ID da localização da detecção (chave estrangeira)
);

/* Tabela para armazenar informações das organizações não governamentais (ONGs) */
CREATE TABLE ong (
    id_ong NUMBER(8) PRIMARY KEY,          -- ID único da ONG
    cnpj VARCHAR2(14),                      -- CNPJ da ONG
    nome VARCHAR2(60),                      -- Nome da ONG
    email VARCHAR2(30),                     -- Endereço de e-mail da ONG
    telefone VARCHAR2(12),                   -- Número de telefone da ONG
    deteccao_id NUMBER(8) NOT NULL           -- ID da DETECCAO que ong recebe (chave estrangeira)
);

/* ALTERS TABLES */
/*ADD Chaves Extrangeiras - relacionamentos*/

/*Tabela -> deteccao*/
-- Chave estrangeira para relacionamento com a tabela especie
ALTER TABLE deteccao ADD CONSTRAINT fk_deteccao_especie FOREIGN KEY ( especie_id )REFERENCES especie ( id_especie );
-- Chave estrangeira para relacionamento com a tabela localizacao
ALTER TABLE deteccao ADD CONSTRAINT fk_deteccao_localizacao FOREIGN KEY ( localizacao_id ) REFERENCES localizacao ( id_localizacao );
-- Chave estrangeira para relacionamento com a tabela usuario
ALTER TABLE deteccao ADD CONSTRAINT fk_deteccao_usuario FOREIGN KEY ( usuario_id ) REFERENCES usuario ( id_usuario );
/*Tabela -> ong*/
-- Chave estrangeira para relacionamento com a tabela deteccao
ALTER TABLE ong ADD CONSTRAINT fk_ong_deteccao FOREIGN KEY ( deteccao_id ) REFERENCES deteccao ( id_deteccao );
/*Tabela -> especie*/
-- Chave estrangeira para relacionamento com a tabela categoria
ALTER TABLE especie ADD CONSTRAINT fk_especie_categoria FOREIGN KEY ( categoria_id ) REFERENCES categoria ( id_categoria );
-- Chave estrangeira para relacionamento com a tabela situacao
ALTER TABLE especie ADD CONSTRAINT fk_especie_situacao FOREIGN KEY ( situacao_id ) REFERENCES situacao ( id_situacao );

/* CREATE TABLE DE REGISTROS DE LOGS*/
DROP TABLE registro_log CASCADE CONSTRAINTS; -- DROP da tabela log
CREATE TABLE registro_log (
    log_id NUMBER(8) GENERATED ALWAYS AS IDENTITY, -- Coluna de ID autoincrementável
    nome_procedure VARCHAR2(100),              -- Nome da Procedure
    username VARCHAR2(50),                     -- Nome do Usuario do banco
    error_date DATE,                            -- Data do erro
    error_code VARCHAR2(10),                    -- Código de erro
    error_message VARCHAR2(200)               -- Mensagem de erro
);

-- CARGA DE DADOS -> Criação e Procedures 
SET SERVEROUTPUT ON;
SET VERIFY OFF;

/*DROPS PROCEDURES DE CARGA DE DADOS*/
DROP PROCEDURE carregar_usuario;
DROP PROCEDURE carregar_localizacao;
DROP PROCEDURE carregar_categoria;
DROP PROCEDURE carregar_situacao;
DROP PROCEDURE carregar_especie;
DROP PROCEDURE carregar_deteccao;
DROP PROCEDURE carregar_ong;

/* USUARIO */
-- Procedure para inserir/carregar dados na tabela usuario
CREATE OR REPLACE PROCEDURE carregar_usuario (
    p_id_usuario IN NUMBER,p_nome IN VARCHAR2, p_genero IN CHAR,p_email IN VARCHAR2,p_senha IN VARCHAR2)
AS 
    v_sqlcode NUMBER;
    v_sqlerrm VARCHAR2(200); -- Ajustando para limitar a mensagem a 200 caracteres
BEGIN
    INSERT INTO usuario (id_usuario, nome, genero, email, senha)
    VALUES (p_id_usuario, p_nome, p_genero, p_email, p_senha);  
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Usuario: ' || p_nome || ' inserido com sucesso.');
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        v_sqlcode := SQLCODE;
        v_sqlerrm := SUBSTR(SQLERRM, 1, 200);
        INSERT INTO registro_log (username, nome_procedure, error_date, error_message, error_code)
        VALUES (USER, 'carregar_usuario', SYSDATE, v_sqlerrm, v_sqlcode);
        DBMS_OUTPUT.PUT_LINE('Erro ao inserir usuario: Já existe um usuario com este ID. Para mais detalhes consulte a tabela registro_log.');
    WHEN VALUE_ERROR THEN
        v_sqlcode := SQLCODE;
        v_sqlerrm := SUBSTR(SQLERRM, 1, 200); 
        INSERT INTO registro_log (username, nome_procedure, error_date, error_message, error_code)
        VALUES (USER, 'carregar_usuario', SYSDATE,  v_sqlerrm, v_sqlcode);
        DBMS_OUTPUT.PUT_LINE('Erro ao inserir usuario: Verifique se os tipos de dados estão corretos. Para mais detalhes consulte a tabela registro_log.');
    WHEN OTHERS THEN
        v_sqlcode := SQLCODE;
        v_sqlerrm := SUBSTR(SQLERRM, 1, 200); -- Limitando a mensagem a 200 caracteres
        INSERT INTO registro_log (username, nome_procedure, error_date, error_message, error_code)
        VALUES (USER, 'carregar_usuario', SYSDATE, v_sqlerrm, v_sqlcode);
        DBMS_OUTPUT.PUT_LINE('Erro ao inserir usuário: O erro foi inserido na tabela de registro_log.');
END carregar_usuario;

/* LOCALIZACAO */
-- Procedure para inserir/carregar dados na tabela localizacao
CREATE OR REPLACE PROCEDURE carregar_localizacao (
    p_id_localizacao IN NUMBER, p_latitude IN NUMBER, p_longitude IN NUMBER,
    p_cidade IN VARCHAR2, p_estado IN VARCHAR2,p_pais IN VARCHAR2)
AS 
    v_sqlcode NUMBER;
    v_sqlerrm VARCHAR2(200); 
BEGIN
    INSERT INTO localizacao (id_localizacao, latitude, longitude, cidade, estado, pais)
    VALUES (p_id_localizacao, p_latitude, p_longitude, p_cidade, p_estado, p_pais);  
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Localização: ' || p_cidade || ', ' || p_estado || ', ' || p_pais || ' inserida com sucesso.');
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        v_sqlcode := SQLCODE;
        v_sqlerrm := SUBSTR(SQLERRM, 1, 200); 
        INSERT INTO registro_log (username, nome_procedure, error_date, error_message, error_code)
        VALUES (USER, 'carregar_localizacao', SYSDATE, v_sqlerrm, v_sqlcode);
        DBMS_OUTPUT.PUT_LINE('Erro ao inserir localização: Já existe uma localização com este ID. Para mais detalhes consulte a tabela registro_log.');
    WHEN VALUE_ERROR THEN
        v_sqlcode := SQLCODE;
        v_sqlerrm := SUBSTR(SQLERRM, 1, 200); 
        INSERT INTO registro_log (username, nome_procedure, error_date, error_message, error_code)
        VALUES (USER, 'carregar_localizacao', SYSDATE,  v_sqlerrm, v_sqlcode);
        DBMS_OUTPUT.PUT_LINE('Erro ao inserir localização: Verifique se os tipos de dados estão corretos. Para mais detalhes consulte a tabela registro_log.');
    WHEN OTHERS THEN
        v_sqlcode := SQLCODE;
        v_sqlerrm := SUBSTR(SQLERRM, 1, 200); 
        INSERT INTO registro_log (username, nome_procedure, error_date, error_message, error_code)
        VALUES (USER, 'carregar_localizacao', SYSDATE, v_sqlerrm, v_sqlcode);
        DBMS_OUTPUT.PUT_LINE('Erro ao inserir localização: O erro foi inserido na tabela de registro_log.');
END carregar_localizacao;

/* CATEGORIA */
-- Procedure para inserir/carregar dados na tabela categoria
CREATE OR REPLACE PROCEDURE carregar_categoria (
    p_id_categoria IN NUMBER, p_nome IN VARCHAR2,p_habitat IN VARCHAR2,
    p_reino IN VARCHAR2,p_familia IN VARCHAR2)
AS 
    v_sqlcode NUMBER;
    v_sqlerrm VARCHAR2(200); 
BEGIN
    INSERT INTO categoria (id_categoria, nome, habitat, reino, familia)
    VALUES (p_id_categoria, p_nome, p_habitat, p_reino, p_familia);  
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Categoria: ' || p_nome || ' inserida com sucesso.');
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        v_sqlcode := SQLCODE;
        v_sqlerrm := SUBSTR(SQLERRM, 1, 200); 
        INSERT INTO registro_log (username, nome_procedure, error_date, error_message, error_code)
        VALUES (USER, 'carregar_categoria', SYSDATE, v_sqlerrm, v_sqlcode);
        DBMS_OUTPUT.PUT_LINE('Erro ao inserir categoria: Já existe uma categoria com este ID. Para mais detalhes consulte a tabela registro_log.');
    WHEN VALUE_ERROR THEN
        v_sqlcode := SQLCODE;
        v_sqlerrm := SUBSTR(SQLERRM, 1, 200); 
        INSERT INTO registro_log (username, nome_procedure, error_date, error_message, error_code)
        VALUES (USER, 'carregar_categoria', SYSDATE,  v_sqlerrm, v_sqlcode);
        DBMS_OUTPUT.PUT_LINE('Erro ao inserir categoria: Verifique se os tipos de dados estão corretos. Para mais detalhes consulte a tabela registro_log.');
    WHEN OTHERS THEN
        v_sqlcode := SQLCODE;
        v_sqlerrm := SUBSTR(SQLERRM, 1, 200); 
        INSERT INTO registro_log (username, nome_procedure, error_date, error_message, error_code)
        VALUES (USER, 'carregar_categoria', SYSDATE, v_sqlerrm, v_sqlcode);
        DBMS_OUTPUT.PUT_LINE('Erro ao inserir categoria: O erro foi inserido na tabela de registro_log.');
END carregar_categoria;

/* SITUACAO */
-- Procedure para inserir/carregar dados na tabela situacao
CREATE OR REPLACE PROCEDURE carregar_situacao (
    p_id_situacao IN NUMBER,p_risco_extincao IN CHAR,p_invasora IN CHAR)
AS 
    v_sqlcode NUMBER;
    v_sqlerrm VARCHAR2(200); 
BEGIN
    INSERT INTO situacao (id_situacao, risco_extincao, invasora)
    VALUES (p_id_situacao, p_risco_extincao, p_invasora);  
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Situação inserida com sucesso.');
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        v_sqlcode := SQLCODE;
        v_sqlerrm := SUBSTR(SQLERRM, 1, 200); 
        INSERT INTO registro_log (username, nome_procedure, error_date, error_message, error_code)
        VALUES (USER, 'carregar_situacao', SYSDATE, v_sqlerrm, v_sqlcode);
        DBMS_OUTPUT.PUT_LINE('Erro ao inserir situação: Já existe uma situação com este ID. Para mais detalhes consulte a tabela registro_log.');
    WHEN VALUE_ERROR THEN
        v_sqlcode := SQLCODE;
        v_sqlerrm := SUBSTR(SQLERRM, 1, 200); 
        INSERT INTO registro_log (username, nome_procedure, error_date, error_message, error_code)
        VALUES (USER, 'carregar_situacao', SYSDATE,  v_sqlerrm, v_sqlcode);
        DBMS_OUTPUT.PUT_LINE('Erro ao inserir situação: Verifique se os tipos de dados estão corretos. Para mais detalhes consulte a tabela registro_log.');
    WHEN OTHERS THEN
        v_sqlcode := SQLCODE;
        v_sqlerrm := SUBSTR(SQLERRM, 1, 200); 
        INSERT INTO registro_log (username, nome_procedure, error_date, error_message, error_code)
        VALUES (USER, 'carregar_situacao', SYSDATE, v_sqlerrm, v_sqlcode);
        DBMS_OUTPUT.PUT_LINE('Erro ao inserir situacao: O erro foi inserido na tabela de registro_log.');
END carregar_situacao;

/* ESPECIE */
-- Procedure para inserir/carregar dados na tabela especie
CREATE OR REPLACE PROCEDURE carregar_especie (
    p_id_especie IN NUMBER, p_nome_comum IN VARCHAR2, p_nome_cientifico IN VARCHAR2,
    p_descricao IN VARCHAR2, p_situacao_id IN NUMBER, p_categoria_id IN NUMBER)
AS 
    v_sqlcode NUMBER;
    v_sqlerrm VARCHAR2(200); 
BEGIN
    INSERT INTO especie (id_especie, nome_comum, nome_cientifico, descricao, situacao_id, categoria_id)
    VALUES (p_id_especie, p_nome_comum, p_nome_cientifico, p_descricao, p_situacao_id, p_categoria_id);  
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Espécie ' || p_nome_comum || ' inserida (o) com sucesso.');
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        v_sqlcode := SQLCODE;
        v_sqlerrm := SUBSTR(SQLERRM, 1, 200); 
        INSERT INTO registro_log (username, nome_procedure, error_date, error_message, error_code)
        VALUES (USER, 'carregar_especie', SYSDATE, v_sqlerrm, v_sqlcode);
        DBMS_OUTPUT.PUT_LINE('Erro ao inserir espécie: Já existe uma espécie com este ID. Para mais detalhes consulte a tabela registro_log.');
    WHEN VALUE_ERROR THEN
        v_sqlcode := SQLCODE;
        v_sqlerrm := SUBSTR(SQLERRM, 1, 200); 
        INSERT INTO registro_log (username, nome_procedure, error_date, error_message, error_code)
        VALUES (USER, 'carregar_especie', SYSDATE,  v_sqlerrm, v_sqlcode);
        DBMS_OUTPUT.PUT_LINE('Erro ao inserir espécie: Verifique se os tipos de dados estão corretos. Para mais detalhes consulte a tabela registro_log.');
    WHEN OTHERS THEN
        v_sqlcode := SQLCODE;
        v_sqlerrm := SUBSTR(SQLERRM, 1, 200); 
        INSERT INTO registro_log (username, nome_procedure, error_date, error_message, error_code)
        VALUES (USER, 'carregar_especie', SYSDATE, v_sqlerrm, v_sqlcode);
        DBMS_OUTPUT.PUT_LINE('Erro ao inserir espécie: O erro foi inserido na tabela de registro_log.');
END carregar_especie;

/* DETECCAO */
-- Procedure para inserir/carregar dados na tabela deteccao
CREATE OR REPLACE PROCEDURE carregar_deteccao (
    p_id_deteccao IN NUMBER, p_url_imagem IN VARCHAR2, p_data_deteccao IN DATE,
    p_usuario_id IN NUMBER, p_especie_id IN NUMBER,p_localizacao_id IN NUMBER)
AS 
    v_sqlcode NUMBER;
    v_sqlerrm VARCHAR2(200); 
BEGIN
    INSERT INTO deteccao (id_deteccao, url_imagem, data_deteccao, usuario_id, especie_id, localizacao_id)
    VALUES (p_id_deteccao, p_url_imagem, p_data_deteccao, p_usuario_id, p_especie_id, p_localizacao_id);  
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Detecção inserida com sucesso.');
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        v_sqlcode := SQLCODE;
        v_sqlerrm := SUBSTR(SQLERRM, 1, 200); 
        INSERT INTO registro_log (username, nome_procedure, error_date, error_message, error_code)
        VALUES (USER, 'carregar_deteccao', SYSDATE, v_sqlerrm, v_sqlcode);
        DBMS_OUTPUT.PUT_LINE('Erro ao inserir detecção: Já existe uma detecção com este ID. Para mais detalhes consulte a tabela registro_log.');
    WHEN VALUE_ERROR THEN
        v_sqlcode := SQLCODE;
        v_sqlerrm := SUBSTR(SQLERRM, 1, 200); 
        INSERT INTO registro_log (username, nome_procedure, error_date, error_message, error_code)
        VALUES (USER, 'carregar_deteccao', SYSDATE,  v_sqlerrm, v_sqlcode);
        DBMS_OUTPUT.PUT_LINE('Erro ao inserir detecção: Verifique se os tipos de dados estão corretos. Para mais detalhes consulte a tabela registro_log.');
    WHEN OTHERS THEN
        v_sqlcode := SQLCODE;
        v_sqlerrm := SUBSTR(SQLERRM, 1, 200); 
        INSERT INTO registro_log (username, nome_procedure, error_date, error_message, error_code)
        VALUES (USER, 'carregar_deteccao', SYSDATE, v_sqlerrm, v_sqlcode);
        DBMS_OUTPUT.PUT_LINE('Erro ao inserir detecção: O erro foi inserido na tabela de registro_log.');
END carregar_deteccao;

/* ONG */
-- Procedure para inserir/carregar dados na tabela ong
CREATE OR REPLACE PROCEDURE carregar_ong (
    p_id_ong IN NUMBER,p_cnpj IN VARCHAR2,p_nome IN VARCHAR2,
    p_email IN VARCHAR2,p_telefone IN VARCHAR2, p_deteccao_id IN NUMBER)
AS 
    v_sqlcode NUMBER;
    v_sqlerrm VARCHAR2(200); 
BEGIN
    INSERT INTO ong (id_ong, cnpj, nome, email, telefone, deteccao_id)
    VALUES (p_id_ong, p_cnpj, p_nome, p_email, p_telefone, p_deteccao_id);  
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('ONG: ' || p_nome || ' inserida com sucesso.');
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        v_sqlcode := SQLCODE;
        v_sqlerrm := SUBSTR(SQLERRM, 1, 200); -- Limitando a mensagem a 200 caracteres
        INSERT INTO registro_log (username, nome_procedure, error_date, error_message, error_code)
        VALUES (USER, 'carregar_ong', SYSDATE, v_sqlerrm, v_sqlcode);
        DBMS_OUTPUT.PUT_LINE('Erro ao inserir ONG: Já existe uma ONG com este ID. Para mais detalhes consulte a tabela registro_log.');
    WHEN VALUE_ERROR THEN
        v_sqlcode := SQLCODE;
        v_sqlerrm := SUBSTR(SQLERRM, 1, 200); -- Limitando a mensagem a 200 caracteres
        INSERT INTO registro_log (username, nome_procedure, error_date, error_message, error_code)
        VALUES (USER, 'carregar_ong', SYSDATE,  v_sqlerrm, v_sqlcode);
        DBMS_OUTPUT.PUT_LINE('Erro ao inserir ONG: Verifique se os tipos de dados estão corretos. Para mais detalhes consulte a tabela registro_log.');
    WHEN OTHERS THEN
        v_sqlcode := SQLCODE;
        v_sqlerrm := SUBSTR(SQLERRM, 1, 200); 
        INSERT INTO registro_log (username, nome_procedure, error_date, error_message, error_code)
        VALUES (USER, 'carregar_ong', SYSDATE, v_sqlerrm, v_sqlcode);
        DBMS_OUTPUT.PUT_LINE('Erro ao inserir ONG: O erro foi inserido na tabela de registro_log.');
END carregar_ong;

-- INSERIR através de parametros nos procedimentos
/* INSERINDO EM USUARIO */
BEGIN
    carregar_usuario(1, 'Alice dos Santos', 'F', 'alice@example.com', 'alice23');
    carregar_usuario(2, 'Miguel Alves', 'M', 'miguel@example.com', 'miguel78');
    carregar_usuario(3, 'Caio Silva', 'M', 'caio@example.com', 'caio84');
    carregar_usuario(4, 'Maria da Penha', 'F', 'maria@example.com', 'mari3399');
    carregar_usuario(5, 'Ana Ferreira', 'F', 'ana@example.com', 'anaferr90');
    COMMIT;
END;

/* INSERINDO EM LOCALIZACAO */
BEGIN
    carregar_localizacao(21, -23.967239, -46.330457, 'Santos', 'SP', 'Brasil');
    carregar_localizacao(22, -22.908333, -43.196388, 'Rio de Janeiro', 'RJ', 'Brasil');
    carregar_localizacao(23, -12.9714, -38.5014, 'Salvador', 'BA', 'Brasil');
    carregar_localizacao(24, -8.047562, -34.877, 'Recife', 'PE', 'Brasil');
    carregar_localizacao(25, -20.3155, -40.3128, 'Vitória', 'ES', 'Brasil');
    COMMIT;
END;

/* INSERINDO EM CATEGORIA */
BEGIN
    carregar_categoria(31, 'Peixes', 'Oceano', 'Animalia', 'Actinopterygii');
    carregar_categoria(32, 'Mamíferos Marinhos', 'Oceano', 'Animalia', 'Mammalia');
    carregar_categoria(33, 'Águas-vivas', 'Oceano', 'Animalia', 'Cnidaria');
    carregar_categoria(34, 'Moluscos', 'Oceano', 'Animalia', 'Mollusca');
    carregar_categoria(35, 'Tubarões', 'Oceano', 'Animalia', 'Chondrichthyes');
    COMMIT;
END;

/* INSERINDO EM SITUACAO */
BEGIN
    carregar_situacao(41, 'S', 'N');
    carregar_situacao(42, 'N', 'N');
    carregar_situacao(43, 'S', 'S');
    carregar_situacao(44, 'N', 'S');
    COMMIT;
END;

/* INSERINDO EM ESPECIE */
BEGIN
    carregar_especie(51, 'Tartaruga Verde', 'Chelonia mydas', 'Espécie de tartaruga marinha.', 41, 32);
    carregar_especie(52, 'Baleia Jubarte', 'Megaptera novaeangliae', 'Grande mamífero marinho.', 43, 32);
    carregar_especie(53, 'Polvo', 'Octopus vulgaris', 'Molusco marinho com oito tentáculos.', 42, 34);
    carregar_especie(54, 'Tubarão Branco', 'Carcharodon carcharias', 'Grande tubarão predador.', 44, 35);
    carregar_especie(55, 'Peixe-palhaço', 'Amphiprion ocellaris', 'Peixe popular em aquários.', 41, 31);
    carregar_especie(56, 'Água-viva Comum', 'Aurelia aurita', 'Espécie de água-viva.', 42, 33);
    COMMIT;
END;

/* INSERINDO EM DETECCAO */
BEGIN
    carregar_deteccao(61, 'https://example.com/tartaruga.jpg', TO_DATE('2023-05-01', 'YYYY-MM-DD'), 1, 51, 21);
    carregar_deteccao(62, 'https://example.com/baleia.jpg', TO_DATE('2023-06-15', 'YYYY-MM-DD'), 2, 52, 22);
    carregar_deteccao(63, 'https://example.com/polvo.jpg', TO_DATE('2023-07-20', 'YYYY-MM-DD'), 3, 53, 23);
    carregar_deteccao(64, 'https://example.com/tubarao.jpg', TO_DATE('2023-08-10', 'YYYY-MM-DD'), 4, 54,24);
    carregar_deteccao(65, 'https://example.com/peixe-palhaco.jpg', TO_DATE('2023-09-05', 'YYYY-MM-DD'), 5, 55,25);
    carregar_deteccao(66, 'https://example.com/agua-viva-comum.jpg', TO_DATE('2023-10-01', 'YYYY-MM-DD'), 1, 56, 21);
    COMMIT;
END;

/* INSERINDO EM ONG */
BEGIN
    carregar_ong(11, '12345678000100', 'ONG Oceano Azul', 'contato@oceanoazul.org', '11112222', 61);
    carregar_ong(12, '22345678000100', 'ONG Mar Limpo', 'contato@marlimpo.org', '22223333', 62);
    carregar_ong(13, '32345678000100', 'ONG Vida Marinha', 'contato@vidamarinha.org', '33334444', 63);
    carregar_ong(14, '42345678000100', 'ONG Guardiões do Mar', 'contato@guardioesdomar.org', '44445555', 64);
    carregar_ong(15, '52345678000100', 'ONG Protetores do Oceano', 'contato@protetoresdooceano.org', '55556666', 65);
    carregar_ong(16, '12456987000100', 'ONG Preservando a vida Maritima', 'contato@vidamaritima.org', '55556666', 66);
    COMMIT;
END;

-- RELATÓRIOS
/*
BLOCO ANONIMO 1: Detecções atraves das datas
- Uso de Cursor Explicito
- Tomada de Decisão
*/
DECLARE
    -- Declaração do cursor explícito para selecionar todas as detecções
    CURSOR c_deteccoes IS
        SELECT d.id_deteccao, d.url_imagem, d.data_deteccao, u.nome AS nome_usuario, e.nome_comum AS especie_detectada
        FROM deteccao d
        JOIN usuario u ON d.usuario_id = u.id_usuario
        JOIN especie e ON d.especie_id = e.id_especie;
    
    -- Variáveis para armazenar os dados de cada detecção
    v_id_deteccao deteccao.id_deteccao%TYPE;
    v_url_imagem deteccao.url_imagem%TYPE;
    v_data_deteccao deteccao.data_deteccao%TYPE;
    v_nome_usuario usuario.nome%TYPE;
    v_especie_detectada especie.nome_comum%TYPE;
    
BEGIN
    -- Imprimir relatório
    DBMS_OUTPUT.PUT_LINE('RELATÓRIO DETEÇÕES MAIS RECENTES(DATA):');
    DBMS_OUTPUT.PUT_LINE('-----------------------------');
    -- Abrindo o cursor
    OPEN c_deteccoes;
    
    -- Loop para iterar sobre as detecções
    LOOP
        -- Buscando os dados de cada detecção
        FETCH c_deteccoes INTO v_id_deteccao, v_url_imagem, v_data_deteccao, v_nome_usuario, v_especie_detectada;
        
        -- Saindo do loop quando não houver mais dados
        EXIT WHEN c_deteccoes%NOTFOUND;
        
        -- Tomada de decisão baseada na data da detecção
        IF v_data_deteccao > TO_DATE('2023-06-15', 'YYYY-MM-DD') THEN
            -- Exibindo informações das detecções feitas após 1 de janeiro de 2023
            DBMS_OUTPUT.PUT_LINE('ID da Detecção: ' || v_id_deteccao || ', URL da Imagem: ' || v_url_imagem || ', Data da Detecção: ' || v_data_deteccao || ', Nome do Usuário: ' || v_nome_usuario || ', Espécie Detectada: ' || v_especie_detectada);
        ELSE
            -- Exibindo informações das detecções feitas antes ou em 1 de janeiro de 2023
            DBMS_OUTPUT.PUT_LINE('Detecção anterior a 2023-06: ' || v_id_deteccao);
        END IF;
    END LOOP;
    
    -- Fechando o cursor
    CLOSE c_deteccoes;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Nenhum dado encontrado.');
    WHEN INVALID_CURSOR THEN
        DBMS_OUTPUT.PUT_LINE('Cursor inválido.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao processar as detecções: ' || SQLERRM);
END;


/*
BLOCO ANONIMO 2: Determinar o gênero com mais detecções usando cursor
- Uso de Cursor Explicito
- Tomada de Decisão
*/
DECLARE
    -- Declaração de cursores explícitos para os usuários masculinos e femininos
    CURSOR cur_masculinos IS
        SELECT nome, genero
        FROM usuario
        WHERE TRIM(genero) = 'M';

    CURSOR cur_femininos IS
        SELECT nome, genero
        FROM usuario
        WHERE TRIM(genero) = 'F';

    -- Variáveis para armazenar a quantidade de usuários masculinos e femininos
    v_qtd_masculinos INTEGER := 0;
    v_qtd_femininos INTEGER := 0;

    -- Variáveis para armazenar os resultados dos cursores
    v_nome_usuario usuario.nome%TYPE;
    v_genero_usuario usuario.genero%TYPE;

BEGIN
    -- Imprimir relatório
    DBMS_OUTPUT.PUT_LINE('RELATÓRIO USUÁRIO POR GÊNERO:');
    DBMS_OUTPUT.PUT_LINE('-----------------------------');

    -- Abrir o cursor de usuários masculinos
    OPEN cur_masculinos;
    -- Obtendo a quantidade de usuários masculinos
    LOOP
        FETCH cur_masculinos INTO v_nome_usuario, v_genero_usuario;
        EXIT WHEN cur_masculinos%NOTFOUND;
        v_qtd_masculinos := v_qtd_masculinos + 1;
    END LOOP;
    -- Fechar o cursor de usuários masculinos
    CLOSE cur_masculinos;

    -- Abrir o cursor de usuários femininos
    OPEN cur_femininos;
    -- Obtendo a quantidade de usuários femininos
    LOOP
        FETCH cur_femininos INTO v_nome_usuario, v_genero_usuario;
        EXIT WHEN cur_femininos%NOTFOUND;
        v_qtd_femininos := v_qtd_femininos + 1;
    END LOOP;
    -- Fechar o cursor de usuários femininos
    CLOSE cur_femininos;

    -- Verificando qual gênero tem mais usuários
    IF v_qtd_masculinos > v_qtd_femininos THEN
        -- Se o gênero masculino tem mais usuários, imprimir os nomes e gêneros dos usuários masculinos
        DBMS_OUTPUT.PUT_LINE('Gênero predominante: Masculino');
        -- Reabrir o cursor de usuários masculinos
        OPEN cur_masculinos;
        LOOP
            FETCH cur_masculinos INTO v_nome_usuario, v_genero_usuario;
            EXIT WHEN cur_masculinos%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('Nome: ' || v_nome_usuario || ', Gênero: ' || v_genero_usuario);
        END LOOP;
        -- Fechar o cursor de usuários masculinos
        CLOSE cur_masculinos;
        -- Imprimir a quantidade de usuários femininos
        DBMS_OUTPUT.PUT_LINE('Quantidade de usuárias femininas: ' || v_qtd_femininos);
    ELSIF v_qtd_femininos > v_qtd_masculinos THEN
        -- Se o gênero feminino tem mais usuários, imprimir os nomes e gêneros dos usuários femininos
        DBMS_OUTPUT.PUT_LINE('Gênero predominante: Feminino');
        -- Reabrir o cursor de usuários femininos
        OPEN cur_femininos;
        LOOP
            FETCH cur_femininos INTO v_nome_usuario, v_genero_usuario;
            EXIT WHEN cur_femininos%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('Nome: ' || v_nome_usuario || ', Gênero: ' || v_genero_usuario);
        END LOOP;
        -- Fechar o cursor de usuários femininos
        CLOSE cur_femininos;
        -- Imprimir a quantidade de usuários masculinos
        DBMS_OUTPUT.PUT_LINE('Quantidade de usuários masculinos: ' || v_qtd_masculinos);
    ELSE
        -- Se houver o mesmo número de usuários masculinos e femininos, imprimir a quantidade
        DBMS_OUTPUT.PUT_LINE('Há o mesmo número de usuários para ambos os gêneros, com um total de ' || v_qtd_masculinos || ' usuários masculinos e ' || v_qtd_femininos || ' usuárias femininas.');
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Nenhum dado encontrado.');
    WHEN INVALID_CURSOR THEN
        DBMS_OUTPUT.PUT_LINE('Cursor inválido.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao processar os usuários: ' || SQLERRM);
END;

/*
BLOCO ANONIMO 3: espécies estão em risco de extinção
- Uso de Cursor Explicito
- Tomada de Decisão
*/
DECLARE
    CURSOR c_especies_em_risco IS
        SELECT e.nome_comum, s.risco_extincao
        FROM especie e
        JOIN situacao s ON e.situacao_id = s.id_situacao;
        
    v_nome_especie especie.nome_comum%TYPE;
    v_em_risco_extincao situacao.risco_extincao%TYPE;
BEGIN
     -- Imprimir relatório
    DBMS_OUTPUT.PUT_LINE('RELATÓRIO ESPECIES EM RISCO:');
    DBMS_OUTPUT.PUT_LINE('-----------------------------');
    -- Abrir o cursor
    OPEN c_especies_em_risco;

    -- Iterar sobre as espécies
    LOOP
        -- Buscar próximo registro
        FETCH c_especies_em_risco INTO v_nome_especie, v_em_risco_extincao;
        
        -- Sair do loop quando não houver mais registros
        EXIT WHEN c_especies_em_risco%NOTFOUND;

        -- Tomada de decisão
        IF v_em_risco_extincao = 'S' THEN
            DBMS_OUTPUT.PUT_LINE('Espécie ' || v_nome_especie || ' está em risco de extinção.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Espécie ' || v_nome_especie || ' não está em risco de extinção.');
        END IF;
    END LOOP;

    -- Fechar o cursor
    CLOSE c_especies_em_risco;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Nenhum dado encontrado.');
    WHEN INVALID_CURSOR THEN
        DBMS_OUTPUT.PUT_LINE('Cursor inválido.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao processar as espécies: ' || SQLERRM);
END;

/*
BLOCO ANONIMO 4: Relatório sumarização de especies com situação
- Uso de Cursor Explicito
- Tomada de Decisão
- listando todos os dados
- mostrar os dado numericos sumarizados
- mostrar a sumarização dos dados agrupados por um critério definido pelo grupo
*/
DECLARE
    -- Variáveis para sumarização numérica
    total_registros NUMBER := 0;
    total_situacoes NUMBER := 0;
    
    subtotal NUMBER := 0;

    -- Variáveis para sumarização agrupada
    situacao_count VARCHAR2(4000) := '';

    -- Cursor para selecionar dados da tabela 'especie'
    CURSOR c_especie IS
        SELECT * FROM especie;

    -- Cursor para sumarização agrupada por situação
    CURSOR c_sumarizacao IS
        SELECT situacao_id, COUNT(*) AS situacao_count
        FROM especie
        GROUP BY situacao_id;

BEGIN
    -- Imprimir relatório
    DBMS_OUTPUT.PUT_LINE('RELATÓRIO ESPECIE SUMARIZADA COM BASE EM SITUAÇÃO:');
    DBMS_OUTPUT.PUT_LINE('-----------------------------');

    -- Título para listar os dados da tabela 'especie'
    DBMS_OUTPUT.PUT_LINE('| ID |    Nome Comum    |   Nome Científico    |     Descrição      | Situação ID |');

    -- Loop para percorrer os dados da tabela 'especie' usando o cursor
    FOR especie_rec IN c_especie LOOP
        -- Imprime os dados da espécie
        DBMS_OUTPUT.PUT_LINE('| ' || especie_rec.id_especie || ' |  ' || especie_rec.nome_comum || ' | ' || especie_rec.nome_cientifico || ' | ' || especie_rec.descricao || ' | ' || especie_rec.situacao_id || ' |');

        -- Incrementa o total de registros
        total_registros := total_registros + 1;

        -- Verifica se o situacao_id já foi contado anteriormente
        IF situacao_count = '' OR INSTR(',' || situacao_count || ',', ',' || especie_rec.situacao_id || ',') = 0 THEN
            -- Incrementa o total de situações distintas
            total_situacoes := total_situacoes + 1;
            -- Adiciona o situacao_id à lista de ids distintos
            situacao_count := situacao_count || ',' || especie_rec.situacao_id;
        END IF;

        -- Incrementa o contador de espécies por situação
        situacao_count := situacao_count || ',' || especie_rec.situacao_id;
    END LOOP;

    -- Imprime sumarizações agrupadas por situação
    DBMS_OUTPUT.PUT_LINE('-----------------------------');
    DBMS_OUTPUT.PUT_LINE('SUMARIZAÇÕES DAS ESPECIES AGRUPADAS POR SITUAÇÕES');
    DBMS_OUTPUT.PUT_LINE('-----------------------------');
    DBMS_OUTPUT.PUT_LINE('| Situação ID | Total de espécies |');

    -- Loop para sumarização agrupada por situação usando o cursor
    FOR situacao_rec IN c_sumarizacao LOOP
        -- Imprime sumarização agrupada por situação
        DBMS_OUTPUT.PUT_LINE('|       ' || situacao_rec.situacao_id || '    |         ' || situacao_rec.situacao_count || '         |');
         -- Verifica se o número de espécies é maior ou igual a 2 e imprime uma mensagem
        IF situacao_rec.situacao_count >= 2 THEN
            DBMS_OUTPUT.PUT_LINE('-> Mais de 2 espécies nesta situação.');
        END IF;
        -- Acumula o subtotal
        subtotal := subtotal + situacao_rec.situacao_count;
        
        -- Imprime o subtotal
        DBMS_OUTPUT.PUT_LINE('-> subtotal: ' || subtotal);
    END LOOP;
    
    -- Imprime sumarizações numéricas
    DBMS_OUTPUT.PUT_LINE('-----------------------------');
    DBMS_OUTPUT.PUT_LINE('--- SUMARIZAÇÕES NUMÉRICAS - Resultados ---');
    DBMS_OUTPUT.PUT_LINE('Total de registros de espécies geral: ' || total_registros);
    DBMS_OUTPUT.PUT_LINE('Total de situações distintas geral : ' || total_situacoes);
    DBMS_OUTPUT.PUT_LINE('-----------------------------');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Nenhum dado encontrado.');
    WHEN INVALID_CURSOR THEN
        DBMS_OUTPUT.PUT_LINE('Cursor inválido.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao processar os dados: ' || SQLERRM);
END;

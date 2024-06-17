/*
Empresa LeadTech - Banco Desenvolvido para a solução "OceanoVivo"

Bianca Leticia Román Caldeira - RM552267 - Turma : 2TDSPH
Charlene Aparecida Estevam Mendes Fialho - RM552252 - Turma : 2TDSPH
Lais Alves Da Silva Cruz - RM 552258 - Turma : 2TDSPH
Lucca Raphael Pereira dos Santos - RM 99675 - Turma : 2TDSPW
Fabrico Torres Antonio - RM 97916 - Turma : 2TDSPH
*/

-- CREATE PROCEDURES DE CARGA DE DADOS (DROP,CREATE -> PROCEDURES)
-- Comandos para remoção e criação das procedures de INSERT

-- CARGA DE DADOS -> Criação e Procedures 
/*DROPS PROCEDURES DE CARGA DE DADOS*/
DROP PROCEDURE carregar_usuario;
DROP PROCEDURE carregar_localizacao;
DROP PROCEDURE carregar_categoria;
DROP PROCEDURE carregar_situacao;
DROP PROCEDURE carregar_especie;
DROP PROCEDURE carregar_deteccao;
DROP PROCEDURE carregar_ong;
DROP PROCEDURE carregar_ong_deteccao;

/* USUARIO */
-- Procedure para inserir/carregar dados na tabela usuario
CREATE OR REPLACE PROCEDURE carregar_usuario (
    p_id_usuario IN NUMBER,p_nome IN VARCHAR2, p_genero IN CHAR,p_email IN VARCHAR2,p_senha IN VARCHAR2)
AS 
    v_sqlcode NUMBER;
    v_sqlerrm VARCHAR2(200); 
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
    p_email IN VARCHAR2,p_telefone IN VARCHAR2)
AS 
    v_sqlcode NUMBER;
    v_sqlerrm VARCHAR2(200); 
BEGIN
    INSERT INTO ong (id_ong, cnpj, nome, email, telefone)
    VALUES (p_id_ong, p_cnpj, p_nome, p_email, p_telefone);  
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

/* ONG_DETECCAO */
-- Procedure para inserir/carregar dados na tabela ong_deteccao
CREATE OR REPLACE PROCEDURE carregar_ong_deteccao (
    p_deteccao_id IN NUMBER,
    p_ong_id IN NUMBER)
AS 
    v_sqlcode NUMBER;
    v_sqlerrm VARCHAR2(200); 
BEGIN
    INSERT INTO ong_deteccao (deteccao_id, ong_id)
    VALUES (p_deteccao_id, p_ong_id);  
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Relação ONG-Detecção inserida com sucesso.');
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        v_sqlcode := SQLCODE;
        v_sqlerrm := SUBSTR(SQLERRM, 1, 200); 
        INSERT INTO registro_log (username, nome_procedure, error_date, error_message, error_code)
        VALUES (USER, 'carregar_ong_deteccao', SYSDATE, v_sqlerrm, v_sqlcode);
        DBMS_OUTPUT.PUT_LINE('Erro ao inserir relação ONG-Detecção: Já existe uma relação com este ID. Para mais detalhes consulte a tabela registro_log.');
    WHEN VALUE_ERROR THEN
        v_sqlcode := SQLCODE;
        v_sqlerrm := SUBSTR(SQLERRM, 1, 200); 
        INSERT INTO registro_log (username, nome_procedure, error_date, error_message, error_code)
        VALUES (USER, 'carregar_ong_deteccao', SYSDATE,  v_sqlerrm, v_sqlcode);
        DBMS_OUTPUT.PUT_LINE('Erro ao inserir relação ONG-Detecção: Verifique se os tipos de dados estão corretos. Para mais detalhes consulte a tabela registro_log.');
    WHEN OTHERS THEN
        v_sqlcode := SQLCODE;
        v_sqlerrm := SUBSTR(SQLERRM, 1, 200); 
        INSERT INTO registro_log (username, nome_procedure, error_date, error_message, error_code)
        VALUES (USER, 'carregar_ong_deteccao', SYSDATE, v_sqlerrm, v_sqlcode);
        DBMS_OUTPUT.PUT_LINE('Erro ao inserir relação ONG-Detecção: O erro foi inserido na tabela de registro_log.');
END carregar_ong_deteccao;

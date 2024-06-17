/*
Empresa LeadTech - Banco Desenvolvido para a solução "OceanoVivo"

Bianca Leticia Román Caldeira - RM552267 - Turma : 2TDSPH
Charlene Aparecida Estevam Mendes Fialho - RM552252 - Turma : 2TDSPH
Lais Alves Da Silva Cruz - RM 552258 - Turma : 2TDSPH
Lucca Raphael Pereira dos Santos - RM 99675 - Turma : 2TDSPW
Fabrico Torres Antonio - RM 97916 - Turma : 2TDSPH
*/

-- CRIAÇÃO DE 4 RELATÓRIOS COM USO DE CURSOR EXPLICITO E IF (COM BEGIN - END e SELECT)
-- Comandos para a criação de 4 relatórios utilizando cursor explicito, if, e blocos BEGIN...END com instruções SELECT.

SET SERVEROUTPUT ON;
SET VERIFY OFF;

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
    DBMS_OUTPUT.PUT_LINE('RELATÓRIO DETEÇÕES MAIS RECENTES(DATA):');
    DBMS_OUTPUT.PUT_LINE('-----------------------------');
    OPEN c_deteccoes; 
    LOOP
        FETCH c_deteccoes INTO v_id_deteccao, v_url_imagem, v_data_deteccao, v_nome_usuario, v_especie_detectada;

        EXIT WHEN c_deteccoes%NOTFOUND;
        
        -- Tomada de decisão baseada na data da detecção
        IF v_data_deteccao > TO_DATE('2023-06-15', 'YYYY-MM-DD') THEN
            DBMS_OUTPUT.PUT_LINE('ID da Detecção: ' || v_id_deteccao || ', URL da Imagem: ' || v_url_imagem || ', Data da Detecção: ' || v_data_deteccao || ', Nome do Usuário: ' || v_nome_usuario || ', Espécie Detectada: ' || v_especie_detectada);
        ELSE
            DBMS_OUTPUT.PUT_LINE('Detecção anterior a 2023-06: ' || v_id_deteccao);
        END IF;
    END LOOP;
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
        SELECT u.nome, u.genero, COUNT(d.id_deteccao) AS qtd_deteccoes
        FROM usuario u
        LEFT JOIN deteccao d ON u.id_usuario = d.usuario_id
        WHERE TRIM(u.genero) = 'M'
        GROUP BY u.nome, u.genero;

    CURSOR cur_femininos IS
        SELECT u.nome, u.genero, COUNT(d.id_deteccao) AS qtd_deteccoes
        FROM usuario u
        LEFT JOIN deteccao d ON u.id_usuario = d.usuario_id
        WHERE TRIM(u.genero) = 'F'
        GROUP BY u.nome, u.genero;

    -- Variáveis para armazenar a quantidade de usuários masculinos e femininos
    v_qtd_masculinos INTEGER := 0;
    v_qtd_femininos INTEGER := 0;

    -- Variáveis para armazenar os resultados dos cursores
    v_nome_usuario usuario.nome%TYPE;
    v_genero_usuario usuario.genero%TYPE;
    v_qtd_deteccoes NUMBER;

BEGIN
    DBMS_OUTPUT.PUT_LINE('RELATÓRIO USUÁRIO POR GÊNERO COM DETECÇÕES:');
    DBMS_OUTPUT.PUT_LINE('---------------------------------------------');

    OPEN cur_masculinos;
     DBMS_OUTPUT.PUT_LINE('USUÁRIOS DO GÊNERO MASCULINO:');
        -- Quebra de linha 
        DBMS_OUTPUT.PUT_LINE('');
    LOOP
        FETCH cur_masculinos INTO v_nome_usuario, v_genero_usuario, v_qtd_deteccoes;
        EXIT WHEN cur_masculinos%NOTFOUND;
        v_qtd_masculinos := v_qtd_masculinos + 1;
        DBMS_OUTPUT.PUT_LINE('Nome: ' || v_nome_usuario || ', Gênero: ' || v_genero_usuario || ', Quantidade de detecções: ' || v_qtd_deteccoes);
    END LOOP;
    CLOSE cur_masculinos;
    DBMS_OUTPUT.PUT_LINE('---------------------------------------------');
    OPEN cur_femininos;
    DBMS_OUTPUT.PUT_LINE('USUÁRIOS DO GÊNERO FEMININO:');
        -- Quebra de linha 
        DBMS_OUTPUT.PUT_LINE('');
    LOOP
        FETCH cur_femininos INTO v_nome_usuario, v_genero_usuario, v_qtd_deteccoes;
        EXIT WHEN cur_femininos%NOTFOUND;
        v_qtd_femininos := v_qtd_femininos + 1;
        DBMS_OUTPUT.PUT_LINE('Nome: ' || v_nome_usuario || ', Gênero: ' || v_genero_usuario || ', Quantidade de detecções: ' || v_qtd_deteccoes);
    END LOOP;
    CLOSE cur_femininos;
    DBMS_OUTPUT.PUT_LINE('---------------------------------------------');
    -- Verificando qual gênero tem mais usuários
    IF v_qtd_masculinos > v_qtd_femininos THEN
        -- Se o gênero masculino tem mais usuários, imprimir a quantidade de usuários femininos
        DBMS_OUTPUT.PUT_LINE('Gênero predominante: Masculino');
        DBMS_OUTPUT.PUT_LINE('Quantidade de usuárias femininas (não predominante): ' || v_qtd_femininos);
    ELSIF v_qtd_femininos > v_qtd_masculinos THEN
        -- Se o gênero feminino tem mais usuários, imprimir a quantidade de usuários masculinos
        DBMS_OUTPUT.PUT_LINE('Gênero predominante: Feminino');
        DBMS_OUTPUT.PUT_LINE('Quantidade de usuários masculinos (não predominante): ' || v_qtd_masculinos);
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
    OPEN c_especies_em_risco;

    LOOP
        FETCH c_especies_em_risco INTO v_nome_especie, v_em_risco_extincao;
        
        EXIT WHEN c_especies_em_risco%NOTFOUND;

        IF v_em_risco_extincao = 'S' THEN
            DBMS_OUTPUT.PUT_LINE('Espécie ' || v_nome_especie || ' está em risco de extinção.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Espécie ' || v_nome_especie || ' NÃO está em risco de extinção.');
        END IF;
    END LOOP;

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
BLOCO ANONIMO 4: Relatório sumarizado de espécies por situação com IDs de espécies
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
    -- Variável para guardar os IDs de situações distintas
    situacao_count VARCHAR2(100) := '';

    -- Cursor para sumarização agrupada por situação
    CURSOR c_sumarizacao IS
        SELECT s.id_situacao, COUNT(e.id_especie) AS situacao_count
        FROM situacao s
        LEFT JOIN especie e ON s.id_situacao = e.situacao_id
        GROUP BY s.id_situacao
        ORDER BY s.id_situacao;

    -- Cursor para recuperar IDs das espécies por situação
    CURSOR c_especies_situacao (p_situacao_id NUMBER) IS
        SELECT id_especie
        FROM especie
        WHERE situacao_id = p_situacao_id
        ORDER BY id_especie; 

    especie_id_rec c_especies_situacao%ROWTYPE; -- Variável para receber os dados do cursor
    situacao_rec c_sumarizacao%ROWTYPE; -- Variável para receber os dados do cursor c_sumarizacao

BEGIN
    -- Imprimir relatório
    DBMS_OUTPUT.PUT_LINE('RELATÓRIO DE ESPÉCIES SUMARIZADO POR SITUAÇÃO COM IDS DE ESPÉCIES:');
    DBMS_OUTPUT.PUT_LINE('---------------------------------------------------');

    -- Abertura explícita do cursor c_sumarizacao
    OPEN c_sumarizacao;

    -- Loop principal usando o cursor c_sumarizacao
    LOOP
        FETCH c_sumarizacao INTO situacao_rec;
        EXIT WHEN c_sumarizacao%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE('| Situação ID | Total de espécies |');
        DBMS_OUTPUT.PUT_LINE('|       ' || situacao_rec.id_situacao || '    |         ' || situacao_rec.situacao_count || '         |');

        -- Incrementa o total de registros
        total_registros := total_registros + situacao_rec.situacao_count;

        -- Verifica se o situacao_id já foi contado anteriormente
        IF situacao_count = '' OR INSTR(',' || situacao_count || ',', ',' || situacao_rec.id_situacao || ',') = 0 THEN
            -- Incrementa o total de situações distintas
            total_situacoes := total_situacoes + 1;
            -- Adiciona o situacao_id à lista de ids distintos
            situacao_count := situacao_count || ',' || situacao_rec.id_situacao;
        END IF;
        DBMS_OUTPUT.PUT_LINE('-----------------------------------');

        -- Abre o cursor explícito c_especies_situacao para a situação atual
        OPEN c_especies_situacao(situacao_rec.id_situacao);
        LOOP
            FETCH c_especies_situacao INTO especie_id_rec;
            EXIT WHEN c_especies_situacao%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('   - ID da Espécie: ' || especie_id_rec.id_especie);
        END LOOP;

        -- Fecha o cursor explícito c_especies_situacao após o uso
        CLOSE c_especies_situacao;

        DBMS_OUTPUT.PUT_LINE('-----------------------------------');
        -- Verifica se o número de espécies é maior ou igual a 2 e imprime uma mensagem
        IF situacao_rec.situacao_count >= 2 THEN
            DBMS_OUTPUT.PUT_LINE('-> 2 ou mais espécies nesta situação.');
        END IF;
        -- Acumula o subtotal
        subtotal := subtotal + situacao_rec.situacao_count;
        -- Imprime o subtotal
        DBMS_OUTPUT.PUT_LINE('-> subtotal: ' || subtotal);
        -- Quebra de linha 
        DBMS_OUTPUT.PUT_LINE('');
    END LOOP;

    -- Fechamento explícito do cursor c_sumarizacao
    CLOSE c_sumarizacao;

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

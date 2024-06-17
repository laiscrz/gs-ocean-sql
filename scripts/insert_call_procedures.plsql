/*
Empresa LeadTech - Banco Desenvolvido para a solução "OceanoVivo"

Bianca Leticia Román Caldeira - RM552267 - Turma : 2TDSPH
Charlene Aparecida Estevam Mendes Fialho - RM552252 - Turma : 2TDSPH
Lais Alves Da Silva Cruz - RM 552258 - Turma : 2TDSPH
Lucca Raphael Pereira dos Santos - RM 99675 - Turma : 2TDSPW
Fabrico Torres Antonio - RM 97916 - Turma : 2TDSPH
*/

-- CHAMADA DAS PROCEDURES DE CARGA DE DADOS (COM BEGIN - END)
-- Comandos para inserção de dados nas procedures de INSERT

-- INSERIR através de parametros nos procedimentos

SET SERVEROUTPUT ON;
SET VERIFY OFF;

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
    carregar_ong(11, '12345678000100', 'ONG Oceano Azul', 'contato@oceanoazul.org', '11112222');
    carregar_ong(12, '22345678000100', 'ONG Mar Limpo', 'contato@marlimpo.org', '22223333');
    carregar_ong(13, '32345678000100', 'ONG Vida Marinha', 'contato@vidamarinha.org', '33334444');
    carregar_ong(14, '42345678000100', 'ONG Guardiões do Mar', 'contato@guardioesdomar.org', '44445555');
    carregar_ong(15, '52345678000100', 'ONG Protetores do Oceano', 'contato@protetoresdooceano.org', '55556666');
    carregar_ong(16, '12456987000100', 'ONG Preservando a vida Maritima', 'contato@vidamaritima.org', '55556666');
    COMMIT;
END;

/* INSERINDO EM ONG_DETECCAO */
BEGIN
    carregar_ong_deteccao(61, 11);
    carregar_ong_deteccao(62, 12);
    carregar_ong_deteccao(63, 13);
    carregar_ong_deteccao(64, 14);
    carregar_ong_deteccao(65, 15);
    carregar_ong_deteccao(66, 16);
    COMMIT;
END;

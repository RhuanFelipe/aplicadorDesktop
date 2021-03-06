
BEGIN
  UPDATE INTEGRA.TI049_OBJETOS_INTEGRA_CAMPOS             
     SET TI049_CAMPO_CALCULADO = 'S'
   WHERE TI049_CODIGO_OBJETO_IE = 'T128_SAIDA_ITENS'
     AND TI049_CODIGO_OBJETO_INTEGRA_IE = 'TI042_NF_SAIDA_PRODUTOS'
     AND TI049_CAMPO_ORIGEM_DESTINO = 'TI042_DESCONTO_BONIFICACAO';
  UPDATE INTEGRA.TI049_OBJETOS_INTEGRA_CAMPOS             
     SET TI049_CAMPO_CALCULADO = 'S'
   WHERE TI049_CODIGO_OBJETO_IE = 'T128_SAIDA_ITENS'
     AND TI049_CODIGO_OBJETO_INTEGRA_IE = 'TI042_NF_SAIDA_PRODUTOS'
     AND TI049_CAMPO_ORIGEM_DESTINO = 'TI042_DESCONTO_BRINDE';
  INSERT INTO INTEGRA.TI061_CADASTRO_SCRIPT
                         (TI061_CODIGO_SCRIPT_IU,
                         TI061_EXPRESSAO_SQL)
                  VALUES(400,'SELECT NVL(T128_DESCONTO_BONIFICACAO#0) AS DESCONTO_BONIFICACAO, NVL(T128_DESCONTO_BRINDE#0) AS DESCONTO_BRINDE FROM T128_SAIDA_ITENS WHERE T128_UNIDADE_IE = :PAR1 AND T128_NOTA_FISCAL_IE = :PAR2 AND T128_SERIE_IE = :PAR3 AND T128_TIPO_NOTAFISC_IE = :PAR4 AND T128_DATA_EMISSAO_IE = :PAR5 AND T128_PRODUTO_IE = :PAR6');
  INSERT INTO INTEGRA.TI062_CADASTRO_SCRIPT_PARAM
   (TI062_CODIGO_SCRIPT_IE, TI062_NOME_PARAMETRO, TI062_VALOR_PARAMETRO, TI062_CHAVE_PESQUISA, TI062_TABELA_PESQUISA, 
    TI062_COLUNA_PESQUISA, TI062_FORMATO_PARAMETRO)
 VALUES
   (400, ':PAR1', 'T128_UNIDADE_IE', NULL, NULL, 
    NULL, 'N');
  INSERT INTO INTEGRA.TI062_CADASTRO_SCRIPT_PARAM
   (TI062_CODIGO_SCRIPT_IE, TI062_NOME_PARAMETRO, TI062_VALOR_PARAMETRO, TI062_CHAVE_PESQUISA, TI062_TABELA_PESQUISA, 
    TI062_COLUNA_PESQUISA, TI062_FORMATO_PARAMETRO)
 VALUES
   (400, ':PAR2', 'T128_NOTA_FISCAL_IE', NULL, NULL, 
    NULL, 'N');
  INSERT INTO INTEGRA.TI062_CADASTRO_SCRIPT_PARAM
   (TI062_CODIGO_SCRIPT_IE, TI062_NOME_PARAMETRO, TI062_VALOR_PARAMETRO, TI062_CHAVE_PESQUISA, TI062_TABELA_PESQUISA, 
    TI062_COLUNA_PESQUISA, TI062_FORMATO_PARAMETRO)
 VALUES
   (400, ':PAR3', 'T128_SERIE_IE', NULL, NULL, 
    NULL, 'S');
  INSERT INTO INTEGRA.TI062_CADASTRO_SCRIPT_PARAM
   (TI062_CODIGO_SCRIPT_IE, TI062_NOME_PARAMETRO, TI062_VALOR_PARAMETRO, TI062_CHAVE_PESQUISA, TI062_TABELA_PESQUISA, 
    TI062_COLUNA_PESQUISA, TI062_FORMATO_PARAMETRO)
 VALUES
   (400, ':PAR4', 'T128_TIPO_NOTAFISC_IE', NULL, NULL, 
    NULL, 'S');
  INSERT INTO INTEGRA.TI062_CADASTRO_SCRIPT_PARAM
   (TI062_CODIGO_SCRIPT_IE, TI062_NOME_PARAMETRO, TI062_VALOR_PARAMETRO, TI062_CHAVE_PESQUISA, TI062_TABELA_PESQUISA, 
    TI062_COLUNA_PESQUISA, TI062_FORMATO_PARAMETRO)
 VALUES
   (400, ':PAR5', 'T128_DATA_EMISSAO_IE', NULL, NULL, 
    NULL, 'S');
  INSERT INTO INTEGRA.TI062_CADASTRO_SCRIPT_PARAM
   (TI062_CODIGO_SCRIPT_IE, TI062_NOME_PARAMETRO, TI062_VALOR_PARAMETRO, TI062_CHAVE_PESQUISA, TI062_TABELA_PESQUISA, 
    TI062_COLUNA_PESQUISA, TI062_FORMATO_PARAMETRO)
 VALUES
   (400, ':PAR6', 'T128_PRODUTO_IE', NULL, NULL, 
    NULL, 'N');     
  INSERT INTO INTEGRA.TI057_CAMPO
   (TI057_OBJETO_IU, 
    TI057_CAMPO_IU, 
    TI057_DESCRICAO, 
    TI057_FORMATO, 
    TI057_TIPO, 
    TI057_TAMANHO)
  VALUES
   ('T128_SAIDA_ITENS', 
    'T128_DESCONTO_BONIFICACAO', 
    'Desconto de Bonificação', 
    'NUMBER', 
    'S', 
    23);
  INSERT INTO INTEGRA.TI058_CAMPO_VALOR
   (TI058_OBJETO_IE, 
    TI058_CAMPO_IE, 
    TI058_SISTEMA_DESTINO_IE, 
    TI058_VALOR, 
    TI058_CODIGO_SCRIPT_E, 
    TI058_CAMPO_SCRIPT)
  VALUES
   ('T128_SAIDA_ITENS', 
    'T128_DESCONTO_BONIFICACAO', 
    9, 
    NULL, 
    400, 
    'DESCONTO_BONIFICACAO');
  INSERT INTO INTEGRA.TI058_CAMPO_VALOR
   (TI058_OBJETO_IE, 
    TI058_CAMPO_IE, 
    TI058_SISTEMA_DESTINO_IE, 
    TI058_VALOR, 
    TI058_CODIGO_SCRIPT_E, 
    TI058_CAMPO_SCRIPT)
  VALUES
   ('T128_SAIDA_ITENS', 
    'T128_DESCONTO_BONIFICACAO', 
    13, 
    NULL, 
    400, 
    'DESCONTO_BONIFICACAO');
  INSERT INTO INTEGRA.TI058_CAMPO_VALOR
   (TI058_OBJETO_IE, 
    TI058_CAMPO_IE, 
    TI058_SISTEMA_DESTINO_IE, 
    TI058_VALOR, 
    TI058_CODIGO_SCRIPT_E, 
    TI058_CAMPO_SCRIPT)
  VALUES
   ('T128_SAIDA_ITENS', 
    'T128_DESCONTO_BONIFICACAO', 
    15, 
    NULL, 
    400, 
    'DESCONTO_BONIFICACAO');
  INSERT INTO INTEGRA.TI057_CAMPO
   (TI057_OBJETO_IU, 
    TI057_CAMPO_IU, 
    TI057_DESCRICAO, 
    TI057_FORMATO, 
    TI057_TIPO, 
    TI057_TAMANHO)
  VALUES
   ('T128_SAIDA_ITENS', 
    'T128_DESCONTO_BRINDE', 
    'Desconto de Brinde', 
    'NUMBER', 
    'S', 
    23);
  INSERT INTO INTEGRA.TI058_CAMPO_VALOR
   (TI058_OBJETO_IE, 
    TI058_CAMPO_IE, 
    TI058_SISTEMA_DESTINO_IE, 
    TI058_VALOR, 
    TI058_CODIGO_SCRIPT_E, 
    TI058_CAMPO_SCRIPT)
  VALUES
   ('T128_SAIDA_ITENS', 
    'T128_DESCONTO_BRINDE', 
    9, 
    NULL, 
    400, 
    'DESCONTO_BRINDE');
  INSERT INTO INTEGRA.TI058_CAMPO_VALOR
   (TI058_OBJETO_IE, 
    TI058_CAMPO_IE, 
    TI058_SISTEMA_DESTINO_IE, 
    TI058_VALOR, 
    TI058_CODIGO_SCRIPT_E, 
    TI058_CAMPO_SCRIPT)
  VALUES
   ('T128_SAIDA_ITENS', 
    'T128_DESCONTO_BRINDE', 
    13, 
    NULL, 
    400, 
    'DESCONTO_BRINDE');
  INSERT INTO INTEGRA.TI058_CAMPO_VALOR
   (TI058_OBJETO_IE, 
    TI058_CAMPO_IE, 
    TI058_SISTEMA_DESTINO_IE, 
    TI058_VALOR, 
    TI058_CODIGO_SCRIPT_E, 
    TI058_CAMPO_SCRIPT)
  VALUES
   ('T128_SAIDA_ITENS', 
    'T128_DESCONTO_BRINDE', 
    15, 
    NULL, 
    400, 
    'DESCONTO_BRINDE');                    
  COMMIT;
END;
/

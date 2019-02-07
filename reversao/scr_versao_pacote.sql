PROMPT ATUALIZANDO VERSAO DO SISTEMA
DECLARE
ID_USARIO        VARCHAR2(50);
ID_MAQUINA       VARCHAR2(64);
ID_TERMINAL      VARCHAR2(20);
BEGIN
   SELECT
     TRIM(MACHINE),      -- NOME DO COMPUTADOR NA REDE
     TRIM(OSUSER),       -- NOME DO USUARIO DA REDE
     TRIM(TERMINAL)     -- NOME DO COMPUTADOR
   INTO
     ID_MAQUINA,
     ID_USARIO,
     ID_TERMINAL
   FROM V$SESSION
   WHERE AUDSID = SYS_CONTEXT('USERENV','SESSIONID');
  -- COLOCAR TODAS OUTRAS VERSOES COMO NAO ATUAIS
  UPDATE DBAMDATA.T994_VERSAO_SISTEMA SET T994_ATUALIZADO = 'N' WHERE T994_ATUALIZADO = 'S';
  -- INSERIR A VERSAO QUE SERA A VALIDA - ATUAL
  INSERT INTO DBAMDATA.T994_VERSAO_SISTEMA
            ( T994_VERSAO,
              T994_SISTEMA_IE,
              T994_DATA_APLICACAO,
              T994_USUARIO_SO,
              T994_MAQUINA,
              T994_TERMINAL,
              T994_ATUALIZADO,
              T994_TIPO_RELEASE,
              T994_RELEASE_NOTES,
              T994_NOME_VERSAO )
     VALUES ( '30.113.02.00',
              '30',
              SYSDATE,
              ID_USARIO,
              ID_MAQUINA,
              ID_TERMINAL,
              'S',
              'R',
              NULL,
              'PRJ');
  -- SALVAR
  COMMIT;
END;
/

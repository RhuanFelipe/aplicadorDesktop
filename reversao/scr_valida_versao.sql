SET LINES500
SET SERVEROUTPUT ON
SPOOL OFF
SPOOL valida_versao.sql
Declare
   preVersao VARCHAR2(50);
Begin
 BEGIN
   SELECT NVL(T994_VERSAO,'NEW')
     INTO preVersao
     FROM DBAMDATA.T994_VERSAO_SISTEMA 
    WHERE T994_ATUALIZADO = 'S'
    AND  T994_SISTEMA_IE = 30;
  EXCEPTION WHEN NO_DATA_FOUND THEN
                                      preVersao := 'NEW';
                                    END;
 IF preVersao <> '30.113.03.00' AND preVersao <> 'NEW' THEN
dbms_output.put_line(chr(10)||'set serveroutput on;'||chr(10)||'spool SCR_EXECUCAO_PACOTE.LOG'||chr(10)||chr(10)||'PROMPT *** PARA A REVERSAO DO PACOTE 30.113.03.00, SE FAZ NECESSARIO ESTAR NA VERSAO 30.113.03.00. ***'||chr(10)||chr(10)||'set serveroutput off;'||chr(10)||chr(10)||'exit;'||chr(10)||'SPOOL OFF');
ELSE
dbms_output.put_line('set serveroutput off'||chr(10)||'spool SCR_EXECUCAO_PACOTE.LOG'||chr(10)||'PROMPT * PARA A REVERSAO DO PACOTE 30.113.03.00, TODOS OS PRE-REQUISITOS FORAM ATENDIDOS. *');
END IF;
END;
/
SPOOL OFF
@valida_versao.sql


spool VALIDACAO.LOG
Prompt /******************************************************************************/
Prompt /* Aguarde...                                                                 */
Prompt /* Re-Compilando objetos inv�lidos do Pacote 30.113.03.00                    */
Prompt /* Relat�rio de objetos inv�lidos ser� mostrado no arquivo VALIDACAO.LOG      */
Prompt /******************************************************************************/
Prompt 
SET serveroutput on SIZE 1000000

Declare
   obj_invalid INTEGER;
   comando_w   VARCHAR2(1000);
   nome_objeto varchar2(100) := 'X';
   v_quebra_linha varchar2(10) := chr(13)||chr(10);

   PROCEDURE compila(comando VARCHAR2) IS
   BEGIN
      execute immediate (comando);
   EXCEPTION
      WHEN OTHERS THEN   
         Null;
   END;

   FUNCTION REMOVE_ACT(P_TEXTO IN VARCHAR2) RETURN VARCHAR2 IS
      RESULT VARCHAR2(2000);
   BEGIN
      RESULT := P_TEXTO;
      RESULT := REPLACE(RESULT,'�','A');
      RESULT := REPLACE(RESULT,'�','A');
      RESULT := REPLACE(RESULT,'�','A');
      RESULT := REPLACE(RESULT,'�','A');
      RESULT := REPLACE(RESULT,'�','A');
      RESULT := REPLACE(RESULT,'�','C');
      RESULT := REPLACE(RESULT,'�','E');
      RESULT := REPLACE(RESULT,'�','E');
      RESULT := REPLACE(RESULT,'�','E');
      RESULT := REPLACE(RESULT,'�','E');
      RESULT := REPLACE(RESULT,'�','I');
      RESULT := REPLACE(RESULT,'�','I');
      RESULT := REPLACE(RESULT,'�','I');
      RESULT := REPLACE(RESULT,'�','I');
      RESULT := REPLACE(RESULT,'�','N');
      RESULT := REPLACE(RESULT,'�','O');
      RESULT := REPLACE(RESULT,'�','O');
      RESULT := REPLACE(RESULT,'�','O');
      RESULT := REPLACE(RESULT,'�','O');
      RESULT := REPLACE(RESULT,'�','O');
      RESULT := REPLACE(RESULT,'�','U');
      RESULT := REPLACE(RESULT,'�','U');
      RESULT := REPLACE(RESULT,'�','U');
      RESULT := REPLACE(RESULT,'�','U');
      RESULT := REPLACE(RESULT,'�','Y');
      RESULT := REPLACE(RESULT,'�','a');
      RESULT := REPLACE(RESULT,'�','a');
      RESULT := REPLACE(RESULT,'�','a');
      RESULT := REPLACE(RESULT,'�','a');
      RESULT := REPLACE(RESULT,'�','a');
      RESULT := REPLACE(RESULT,'�','c');
      RESULT := REPLACE(RESULT,'�','e');
      RESULT := REPLACE(RESULT,'�','e');
      RESULT := REPLACE(RESULT,'�','e');
      RESULT := REPLACE(RESULT,'�','e');
      RESULT := REPLACE(RESULT,'�','i');
      RESULT := REPLACE(RESULT,'�','i');
      RESULT := REPLACE(RESULT,'�','i');
      RESULT := REPLACE(RESULT,'�','i');
      RESULT := REPLACE(RESULT,'�','n');
      RESULT := REPLACE(RESULT,'�','o');
      RESULT := REPLACE(RESULT,'�','o');
      RESULT := REPLACE(RESULT,'�','o');
      RESULT := REPLACE(RESULT,'�','o');
      RESULT := REPLACE(RESULT,'�','o');
      RESULT := REPLACE(RESULT,'�','u');
      RESULT := REPLACE(RESULT,'�','u');
      RESULT := REPLACE(RESULT,'�','u');
      RESULT := REPLACE(RESULT,'�','u');
      RESULT := REPLACE(RESULT,'�','y');
      RESULT := REPLACE(RESULT,'�','y');
                                          
      -- Caracteres especiais
      RESULT := REPLACE(RESULT,chr(10),' ');
      RESULT := REPLACE(RESULT,chr(13),' ');
      RESULT := REPLACE(RESULT,chr(9),' ');
                                          
      RETURN(RESULT);
   END REMOVE_ACT;
Begin
   -- por problemas de referencias cruzadas entre packages e pack body
   -- vou compilar todas as packages primeiro
   FOR c1 IN (SELECT owner, 
                     object_name
                FROM dba_objects
          WHERE object_type = 'PACKAGE BODY'
       AND status      = 'INVALID'
       AND owner in ('DBAMDATA', 'FARMA', 'INFOCSI', 'INFOMLOG', 'INTEGRA', 'MEDI','DBAGESTAO','INFOGESTAO','COMERCIAL') )
   LOOP
      comando_w := 'alter package ' || c1.owner ||'.'||v_quebra_linha|| c1.object_name || ' compile body';
      compila(comando_w);
   END LOOP;

   -- a rotina tentar� recompilar os objetos principais (chamadores)
   FOR c1 IN (SELECT DISTINCT c.owner, c.object_type, c.object_name
                FROM dba_objects c
          WHERE c.status = 'INVALID'
       AND c.object_type <> 'PACKAGE BODY'
       AND c.owner in ('DBAMDATA', 'FARMA', 'INFOCSI', 'INFOMLOG', 'INTEGRA', 'MEDI','DBAGESTAO','INFOGESTAO','COMERCIAL') 
       AND Not Exists (SELECT NULL
                         FROM all_dependencies b
                        WHERE b.referenced_name = c.object_name))
   LOOP
      comando_w := 'alter ' || c1.object_type || ' ' || c1.owner || '.' || c1.object_name || ' compile';
      compila(comando_w);
   END LOOP;

   --  recompilar tudo o invalido
   FOR c1 IN (SELECT DISTINCT c.owner, c.object_type, c.object_name
                FROM dba_objects c
               WHERE c.status = 'INVALID'
                 AND c.object_type <> 'PACKAGE BODY'
                 AND c.owner in ('DBAMDATA', 'FARMA', 'INFOCSI', 'INFOMLOG', 'INTEGRA', 'MEDI','DBAGESTAO','INFOGESTAO','COMERCIAL'))
   LOOP
      comando_w := 'alter ' || c1.object_type || ' ' || c1.owner || '.' || c1.object_name || ' compile';
      compila(comando_w);
   END LOOP;

   --  recompilar tudo o invalido
   FOR c1 IN (SELECT DISTINCT c.owner, c.object_type, c.object_name
                FROM dba_objects c
               WHERE c.status = 'INVALID'
                 AND c.object_type <> 'PACKAGE BODY'
                 AND c.owner in ('DBAMDATA', 'FARMA', 'INFOCSI', 'INFOMLOG', 'INTEGRA', 'MEDI','DBAGESTAO','INFOGESTAO','COMERCIAL'))
   LOOP
      comando_w := 'alter ' || c1.object_type || ' ' || c1.owner || '.' || c1.object_name || ' compile';
      compila(comando_w);
   END LOOP;
                                       
   -- verifica se ainda existem objetos inv�lidos
   SELECT COUNT(*) 
     INTO obj_invalid
     FROM dba_objects o
    WHERE status = 'INVALID'
      AND owner in ('DBAMDATA', 'FARMA', 'INFOCSI', 'INFOMLOG', 'INTEGRA', 'MEDI','DBAGESTAO','INFOGESTAO','COMERCIAL')
      AND EXISTS (SELECT 1 
                    FROM ALL_ERRORS E
                   WHERE O.OWNER       = E.OWNER
                     AND O.OBJECT_NAME = E.NAME);
                                         
   IF obj_invalid = 0 THEN
      dbms_output.put_line('*********************************************************************************');   
      dbms_output.put_line('* Todos os objetos foram recompilados com sucesso, n�o existem objetos inv�lidos*');   
      dbms_output.put_line('*********************************************************************************');   
   ELSE
      dbms_output.put_line('********************************************************************************');   
      dbms_output.put_line('* Rela��o de Objetos Inv�lidos                                                 *');   

      FOR C IN (SELECT O.Owner,
                       E.NAME,
                       E.TYPE,
                       E.LINE,
                       E.POSITION,
                       E.TEXT
                  FROM all_ERRORS  E,
                       dba_objects O
                 WHERE E.NAME = O.OBJECT_NAME
              AND E.owner= O.owner
                   AND O.STATUS = 'INVALID'
                   AND O.owner in ('DBAMDATA', 'FARMA', 'INFOCSI', 'INFOMLOG', 'INTEGRA', 'MEDI','DBAGESTAO','INFOGESTAO','COMERCIAL')
                 order by O.Owner,E.NAME)
      LOOP
         if nome_objeto <> c.name then
            nome_objeto := c.name;
            dbms_output.put_line('********************************************************************************');    
            dbms_output.put_line(RPAD('OWNER: '||v_quebra_linha||C.Owner||' OBJETO: ' || RPAD(C.NAME,30) || ' TIPO: '   || C.TYPE ,100));
         end if;
         dbms_output.put_line(RPAD('(' || C.LINE || ') ' || REMOVE_ACT(SUBSTR(C.TEXT,1,95)),100));
      END LOOP;

      dbms_output.put_line('********************************************************************************');
      dbms_output.put_line('* ATEN��O: Existem ' || to_char(obj_invalid) || ' objetos inv�lidos.         *');
      dbms_output.put_line('********************************************************************************');
      dbms_output.put_line('* Enviar este arquivo de log gerado para INFORMATA CONSULTORIA DADOS LTDA.     *');
      dbms_output.put_line('********************************************************************************');
   END IF;
END;
/

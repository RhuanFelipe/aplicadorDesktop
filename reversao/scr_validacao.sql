spool VALIDACAO.LOG
Prompt /******************************************************************************/
Prompt /* Aguarde...                                                                 */
Prompt /* Re-Compilando objetos inválidos do Pacote 30.113.03.00                    */
Prompt /* Relatório de objetos inválidos será mostrado no arquivo VALIDACAO.LOG      */
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
      RESULT := REPLACE(RESULT,'À','A');
      RESULT := REPLACE(RESULT,'Á','A');
      RESULT := REPLACE(RESULT,'Â','A');
      RESULT := REPLACE(RESULT,'Ã','A');
      RESULT := REPLACE(RESULT,'Ä','A');
      RESULT := REPLACE(RESULT,'Ç','C');
      RESULT := REPLACE(RESULT,'È','E');
      RESULT := REPLACE(RESULT,'É','E');
      RESULT := REPLACE(RESULT,'Ê','E');
      RESULT := REPLACE(RESULT,'Ë','E');
      RESULT := REPLACE(RESULT,'Ì','I');
      RESULT := REPLACE(RESULT,'Í','I');
      RESULT := REPLACE(RESULT,'Î','I');
      RESULT := REPLACE(RESULT,'Ï','I');
      RESULT := REPLACE(RESULT,'Ñ','N');
      RESULT := REPLACE(RESULT,'Ò','O');
      RESULT := REPLACE(RESULT,'Ó','O');
      RESULT := REPLACE(RESULT,'Ô','O');
      RESULT := REPLACE(RESULT,'Õ','O');
      RESULT := REPLACE(RESULT,'Ö','O');
      RESULT := REPLACE(RESULT,'Ù','U');
      RESULT := REPLACE(RESULT,'Ú','U');
      RESULT := REPLACE(RESULT,'Û','U');
      RESULT := REPLACE(RESULT,'Ü','U');
      RESULT := REPLACE(RESULT,'Ý','Y');
      RESULT := REPLACE(RESULT,'à','a');
      RESULT := REPLACE(RESULT,'á','a');
      RESULT := REPLACE(RESULT,'â','a');
      RESULT := REPLACE(RESULT,'ã','a');
      RESULT := REPLACE(RESULT,'ä','a');
      RESULT := REPLACE(RESULT,'ç','c');
      RESULT := REPLACE(RESULT,'è','e');
      RESULT := REPLACE(RESULT,'é','e');
      RESULT := REPLACE(RESULT,'ê','e');
      RESULT := REPLACE(RESULT,'ë','e');
      RESULT := REPLACE(RESULT,'ì','i');
      RESULT := REPLACE(RESULT,'í','i');
      RESULT := REPLACE(RESULT,'î','i');
      RESULT := REPLACE(RESULT,'ï','i');
      RESULT := REPLACE(RESULT,'ñ','n');
      RESULT := REPLACE(RESULT,'ò','o');
      RESULT := REPLACE(RESULT,'ó','o');
      RESULT := REPLACE(RESULT,'ô','o');
      RESULT := REPLACE(RESULT,'õ','o');
      RESULT := REPLACE(RESULT,'ö','o');
      RESULT := REPLACE(RESULT,'ù','u');
      RESULT := REPLACE(RESULT,'ú','u');
      RESULT := REPLACE(RESULT,'û','u');
      RESULT := REPLACE(RESULT,'ü','u');
      RESULT := REPLACE(RESULT,'ý','y');
      RESULT := REPLACE(RESULT,'ÿ','y');
                                          
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

   -- a rotina tentará recompilar os objetos principais (chamadores)
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
                                       
   -- verifica se ainda existem objetos inválidos
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
      dbms_output.put_line('* Todos os objetos foram recompilados com sucesso, não existem objetos inválidos*');   
      dbms_output.put_line('*********************************************************************************');   
   ELSE
      dbms_output.put_line('********************************************************************************');   
      dbms_output.put_line('* Relação de Objetos Inválidos                                                 *');   

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
      dbms_output.put_line('* ATENÇÃO: Existem ' || to_char(obj_invalid) || ' objetos inválidos.         *');
      dbms_output.put_line('********************************************************************************');
      dbms_output.put_line('* Enviar este arquivo de log gerado para INFORMATA CONSULTORIA DADOS LTDA.     *');
      dbms_output.put_line('********************************************************************************');
   END IF;
END;
/

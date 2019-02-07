
SET serveroutput on SIZE 1000000

Declare
   obj_pre_invalid INTEGER;
Begin

   -- verifica se ainda existem objetos inválidos
   SELECT COUNT(*) 
     INTO obj_pre_invalid
     FROM dba_objects o
    WHERE status = 'INVALID'
      AND owner in ('DBAMDATA', 'FARMA', 'INFOCSI', 'INFOMLOG', 'INTEGRA', 'MEDI','DBAGESTAO','INFOGESTAO','COMERCIAL')
      AND EXISTS (SELECT 1 
                    FROM ALL_ERRORS E
                   WHERE O.OWNER       = E.OWNER
                     AND O.OBJECT_NAME = E.NAME);
dbms_output.put_line('********************************************************************************');
dbms_output.put_line('* ATENÇAO: JA Existem ' || to_char(obj_pre_invalid) || ' objetos invalidos.         *');
dbms_output.put_line('********************************************************************************');
END;
/

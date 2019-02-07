SET ECHO OFF
SET TERM ON
SET TIMING ON TIME ON
SET TRIMOUT ON
SET TRIMSPOOL ON

SPOOL SCR_LOGON_PACOTE.LOG

PROMPT #########################################################################
PROMPT # Script de aplicação do pacote 30.113.03.00_R                          #
PROMPT # Atualizado usando login do usuario                                    #
PROMPT # DBAMDATA.                                                             #
PROMPT # Favor inserir a senha do DBAMDATA seguido do                          #
PROMPT # alias de conexao para o banco de dados(TNSNAMES)                      #
PROMPT #                                                                       #
PROMPT #########################################################################
PROMPT 
PROMPT 

accept PSWD  char prompt 'Digite a senha do DBAMDATA:' HIDE
accept SIDDB char prompt 'Digite a alias do BANCO   :'

connect DBAMDATA/&PSWD.@&SIDDB

SELECT SYSDATE AS "HORA INICIAL" FROM DUAL;
@scr_valida_versao.sql
@scr_pre_validacao.sql

@scr_aplica_pacote_30.113.03.00_R.sql
@scr_versao_pacote.sql
@scr_validacao.sql

SELECT SYSDATE AS "HORA FINAL" FROM DUAL;

spool off
exit

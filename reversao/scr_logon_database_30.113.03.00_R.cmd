@echo off
TITLE 30.113.03.00_R
SET NLS_DATE_FORMAT=DD MON YYYY HH24:MI:SS
REM Script de aplicação de pacotes
REM repositorio de dados MDLOG
REM Data: 23/11/2018
sqlplus /nolog @scr_logon_database_30.113.03.00_R.sql

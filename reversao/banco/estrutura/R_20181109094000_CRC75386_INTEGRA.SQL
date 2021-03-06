
/* ************************************************************************************
Schema       : DBAMDATA
Analista     : Lenilton Marques
Data         : 09 de novembro de 2018
Descricao    : Criação de campos no cadastro de configurações de impostos
CRC          : 75386
************************************************************************************* */
ALTER TABLE INTEGRA.TI045_NF_ENTRADA DROP COLUMN TI045_BASE_PIS_ISENTO   ;
ALTER TABLE INTEGRA.TI045_NF_ENTRADA DROP COLUMN TI045_BASE_PIS_RETIDO   ;
ALTER TABLE INTEGRA.TI045_NF_ENTRADA DROP COLUMN TI045_BASE_PIS_NORMAL   ;
ALTER TABLE INTEGRA.TI045_NF_ENTRADA DROP COLUMN TI045_BASE_COFINS_ISENTO;
ALTER TABLE INTEGRA.TI045_NF_ENTRADA DROP COLUMN TI045_BASE_COFINS_RETIDO;
ALTER TABLE INTEGRA.TI045_NF_ENTRADA DROP COLUMN TI045_BASE_COFINS_NORMAL;
ALTER TABLE INTEGRA.TI046_NF_ENTRADA_PRODUTOS DROP COLUMN TI046_BASE_PIS_ISENTO   ;
ALTER TABLE INTEGRA.TI046_NF_ENTRADA_PRODUTOS DROP COLUMN TI046_BASE_PIS_RETIDO   ;
ALTER TABLE INTEGRA.TI046_NF_ENTRADA_PRODUTOS DROP COLUMN TI046_BASE_PIS_NORMAL   ;
ALTER TABLE INTEGRA.TI046_NF_ENTRADA_PRODUTOS DROP COLUMN TI046_BASE_COFINS_ISENTO;
ALTER TABLE INTEGRA.TI046_NF_ENTRADA_PRODUTOS DROP COLUMN TI046_BASE_COFINS_RETIDO;
ALTER TABLE INTEGRA.TI046_NF_ENTRADA_PRODUTOS DROP COLUMN TI046_BASE_COFINS_NORMAL;

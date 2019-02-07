/**************************************************************************************
Schema       : DBAMDATA
Analista     : Lenilton Marques
Data         : 30 de outubro de 2018
Descricao    : Cria��o de campos no cadastro de configura��es de impostos
CRC          : 75386
**************************************************************************************/
ALTER TABLE DBAMDATA.T274_TIPOS_OPERACAO_FISCAL ADD ( T274_PIS_DESC_ITEM           CHAR(1) DEFAULT 'S' );
ALTER TABLE DBAMDATA.T274_TIPOS_OPERACAO_FISCAL ADD ( T274_PIS_DESC_REPASSE        CHAR(1) DEFAULT 'S' );
ALTER TABLE DBAMDATA.T274_TIPOS_OPERACAO_FISCAL ADD ( T274_PIS_DESC_COMERCIAL      CHAR(1) DEFAULT 'S' );
ALTER TABLE DBAMDATA.T274_TIPOS_OPERACAO_FISCAL ADD ( T274_PIS_DESCDESP_EMBALAGEM  CHAR(1) DEFAULT 'S' );
ALTER TABLE DBAMDATA.T274_TIPOS_OPERACAO_FISCAL ADD ( T274_PIS_ADICDESP_ACESSORIAS CHAR(1) DEFAULT 'S' );
ALTER TABLE DBAMDATA.T274_TIPOS_OPERACAO_FISCAL ADD ( T274_PIS_ADICVALOR_IPI       CHAR(1) DEFAULT 'N' );
ALTER TABLE DBAMDATA.T274_TIPOS_OPERACAO_FISCAL ADD ( T274_COFINS_DESC_ITEM           CHAR(1) DEFAULT 'S' );
ALTER TABLE DBAMDATA.T274_TIPOS_OPERACAO_FISCAL ADD ( T274_COFINS_DESC_REPASSE        CHAR(1) DEFAULT 'S' );
ALTER TABLE DBAMDATA.T274_TIPOS_OPERACAO_FISCAL ADD ( T274_COFINS_DESC_COMERCIAL      CHAR(1) DEFAULT 'S' );
ALTER TABLE DBAMDATA.T274_TIPOS_OPERACAO_FISCAL ADD ( T274_COFINS_DESCDESP_EMBALAGEM  CHAR(1) DEFAULT 'S' );
ALTER TABLE DBAMDATA.T274_TIPOS_OPERACAO_FISCAL ADD ( T274_COFINS_ADICDESP_ACESSORIA  CHAR(1) DEFAULT 'S' );
ALTER TABLE DBAMDATA.T274_TIPOS_OPERACAO_FISCAL ADD ( T274_COFINS_ADICVALOR_IPI       CHAR(1) DEFAULT 'N' );
ALTER TABLE DBAMDATA.T274_TIPOS_OPERACAO_FISCAL ADD ( T274_PIS_ORIGEM_COMPRA    VARCHAR2(12) );
ALTER TABLE DBAMDATA.T274_TIPOS_OPERACAO_FISCAL ADD ( T274_COFINS_ORIGEM_COMPRA VARCHAR2(12) );
ALTER TABLE DBAMDATA.T905_PARAM_CONTABIL MODIFY T905_ADIC_VALOR_FRETE_ENTRADA VARCHAR2(9);
ALTER TABLE DBAMDATA.T073_ENTRADA ADD ( T073_BASE_PIS_ISENTO NUMBER(15,2) );
ALTER TABLE DBAMDATA.T073_ENTRADA ADD ( T073_BASE_PIS_RETIDO NUMBER(15,2) );
ALTER TABLE DBAMDATA.T073_ENTRADA ADD ( T073_BASE_PIS_NORMAL NUMBER(15,2) );
ALTER TABLE DBAMDATA.T073_ENTRADA ADD ( T073_BASE_COFINS_ISENTO NUMBER(15,2) );
ALTER TABLE DBAMDATA.T073_ENTRADA ADD ( T073_BASE_COFINS_RETIDO NUMBER(15,2) );
ALTER TABLE DBAMDATA.T073_ENTRADA ADD ( T073_BASE_COFINS_NORMAL NUMBER(15,2) );
ALTER TABLE DBAMDATA.T074_ENTRADA_ALIQUOTA ADD ( T074_BASE_PIS_ISENTO NUMBER(15,2) );
ALTER TABLE DBAMDATA.T074_ENTRADA_ALIQUOTA ADD ( T074_BASE_PIS_RETIDO NUMBER(15,2) );
ALTER TABLE DBAMDATA.T074_ENTRADA_ALIQUOTA ADD ( T074_BASE_PIS_NORMAL NUMBER(15,2) );
ALTER TABLE DBAMDATA.T074_ENTRADA_ALIQUOTA ADD ( T074_BASE_COFINS_ISENTO NUMBER(15,2) );
ALTER TABLE DBAMDATA.T074_ENTRADA_ALIQUOTA ADD ( T074_BASE_COFINS_RETIDO NUMBER(15,2) );
ALTER TABLE DBAMDATA.T074_ENTRADA_ALIQUOTA ADD ( T074_BASE_COFINS_NORMAL NUMBER(15,2) );
ALTER TABLE DBAMDATA.T078_ENTRADA_ITENS ADD ( T078_BASE_PIS_ISENTO NUMBER(15,2) );
ALTER TABLE DBAMDATA.T078_ENTRADA_ITENS ADD ( T078_BASE_PIS_RETIDO NUMBER(15,2) );
ALTER TABLE DBAMDATA.T078_ENTRADA_ITENS ADD ( T078_BASE_PIS_NORMAL NUMBER(15,2) );
ALTER TABLE DBAMDATA.T078_ENTRADA_ITENS ADD ( T078_BASE_COFINS_ISENTO NUMBER(15,2) );
ALTER TABLE DBAMDATA.T078_ENTRADA_ITENS ADD ( T078_BASE_COFINS_RETIDO NUMBER(15,2) );
ALTER TABLE DBAMDATA.T078_ENTRADA_ITENS ADD ( T078_BASE_COFINS_NORMAL NUMBER(15,2) );
ALTER TABLE DBAMDATA.T209_LOTESTOQUE ADD ( T209_BASE_PIS_ISENTO NUMBER(15,2) );
ALTER TABLE DBAMDATA.T209_LOTESTOQUE ADD ( T209_BASE_PIS_RETIDO NUMBER(15,2) );
ALTER TABLE DBAMDATA.T209_LOTESTOQUE ADD ( T209_BASE_PIS_NORMAL NUMBER(15,2) );
ALTER TABLE DBAMDATA.T209_LOTESTOQUE ADD ( T209_BASE_COFINS_ISENTO NUMBER(15,2) );
ALTER TABLE DBAMDATA.T209_LOTESTOQUE ADD ( T209_BASE_COFINS_RETIDO NUMBER(15,2) );
ALTER TABLE DBAMDATA.T209_LOTESTOQUE ADD ( T209_BASE_COFINS_NORMAL NUMBER(15,2) );
ALTER TABLE DBAMDATA.T210_LOTESTOQUE_ALIQUOTA ADD ( T210_BASE_PIS_ISENTO NUMBER(15,2) );
ALTER TABLE DBAMDATA.T210_LOTESTOQUE_ALIQUOTA ADD ( T210_BASE_PIS_RETIDO NUMBER(15,2) );
ALTER TABLE DBAMDATA.T210_LOTESTOQUE_ALIQUOTA ADD ( T210_BASE_PIS_NORMAL NUMBER(15,2) );
ALTER TABLE DBAMDATA.T210_LOTESTOQUE_ALIQUOTA ADD ( T210_BASE_COFINS_ISENTO NUMBER(15,2) );
ALTER TABLE DBAMDATA.T210_LOTESTOQUE_ALIQUOTA ADD ( T210_BASE_COFINS_RETIDO NUMBER(15,2) );
ALTER TABLE DBAMDATA.T210_LOTESTOQUE_ALIQUOTA ADD ( T210_BASE_COFINS_NORMAL NUMBER(15,2) );
ALTER TABLE DBAMDATA.T211_LOTESTOQUE_ITENS ADD ( T211_BASE_PIS_ISENTO NUMBER(15,2) );
ALTER TABLE DBAMDATA.T211_LOTESTOQUE_ITENS ADD ( T211_BASE_PIS_RETIDO NUMBER(15,2) );
ALTER TABLE DBAMDATA.T211_LOTESTOQUE_ITENS ADD ( T211_BASE_PIS_NORMAL NUMBER(15,2) );
ALTER TABLE DBAMDATA.T211_LOTESTOQUE_ITENS ADD ( T211_BASE_COFINS_ISENTO NUMBER(15,2) );
ALTER TABLE DBAMDATA.T211_LOTESTOQUE_ITENS ADD ( T211_BASE_COFINS_RETIDO NUMBER(15,2) );
ALTER TABLE DBAMDATA.T211_LOTESTOQUE_ITENS ADD ( T211_BASE_COFINS_NORMAL NUMBER(15,2) );
ALTER TABLE DBAMDATA.T124_SAIDA_ICMS ADD ( T124_BASE_PIS_ISENTO NUMBER(15,2) );
ALTER TABLE DBAMDATA.T124_SAIDA_ICMS ADD ( T124_BASE_PIS_RETIDO NUMBER(15,2) );
ALTER TABLE DBAMDATA.T124_SAIDA_ICMS ADD ( T124_BASE_PIS_NORMAL NUMBER(15,2) );
ALTER TABLE DBAMDATA.T124_SAIDA_ICMS ADD ( T124_BASE_COFINS_ISENTO NUMBER(15,2) );
ALTER TABLE DBAMDATA.T124_SAIDA_ICMS ADD ( T124_BASE_COFINS_RETIDO NUMBER(15,2) );
ALTER TABLE DBAMDATA.T124_SAIDA_ICMS ADD ( T124_BASE_COFINS_NORMAL NUMBER(15,2) );
ALTER TABLE INFOMLOG.TNOT4_CALCULO_NOTA_ICMS ADD ( TNOT4_BASE_PIS_ISENTO NUMBER(15,2) );
ALTER TABLE INFOMLOG.TNOT4_CALCULO_NOTA_ICMS ADD ( TNOT4_BASE_PIS_RETIDO NUMBER(15,2) );
ALTER TABLE INFOMLOG.TNOT4_CALCULO_NOTA_ICMS ADD ( TNOT4_BASE_PIS_NORMAL NUMBER(15,2) );
ALTER TABLE INFOMLOG.TNOT4_CALCULO_NOTA_ICMS ADD ( TNOT4_BASE_COFINS_ISENTO NUMBER(15,2) );
ALTER TABLE INFOMLOG.TNOT4_CALCULO_NOTA_ICMS ADD ( TNOT4_BASE_COFINS_RETIDO NUMBER(15,2) );
ALTER TABLE INFOMLOG.TNOT4_CALCULO_NOTA_ICMS ADD ( TNOT4_BASE_COFINS_NORMAL NUMBER(15,2) );
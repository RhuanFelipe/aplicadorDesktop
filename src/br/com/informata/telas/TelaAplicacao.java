/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.informata.telas;

import br.com.informata.dal.Conexao;
import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.LineNumberReader;
import java.io.PrintWriter;
import java.sql.Array;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.util.Map;
import java.util.Scanner;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.Stream;
import javax.swing.JFileChooser;
import javax.swing.JOptionPane;

/**
 *
 * @author rhuan.silva
 */
public class TelaAplicacao extends javax.swing.JFrame {

    Connection conexao = null;
    PreparedStatement pst = null;
    ResultSet rs = null;
    Statement stmt = null;
    CallableStatement call = null;
    public static String caminhoFile = "";
    public String executarScript = "";
    public String tratarMsg = "";
    public int error = 0;
    public String logMsg = "";
    public static String logSession = "";

    /**
     * Creates new form telaAplicacao
     */
    public TelaAplicacao() {
        initComponents();
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jButton1 = new javax.swing.JButton();
        jButton2 = new javax.swing.JButton();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);

        jButton1.setText("Selecionar arquivo");
        jButton1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButton1ActionPerformed(evt);
            }
        });

        jButton2.setText("Executar");
        jButton2.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButton2ActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(layout.createSequentialGroup()
                        .addGap(129, 129, 129)
                        .addComponent(jButton1, javax.swing.GroupLayout.PREFERRED_SIZE, 133, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(layout.createSequentialGroup()
                        .addGap(145, 145, 145)
                        .addComponent(jButton2)))
                .addContainerGap(138, Short.MAX_VALUE))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                .addContainerGap(109, Short.MAX_VALUE)
                .addComponent(jButton1, javax.swing.GroupLayout.PREFERRED_SIZE, 34, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(27, 27, 27)
                .addComponent(jButton2)
                .addGap(107, 107, 107))
        );

        setSize(new java.awt.Dimension(416, 339));
        setLocationRelativeTo(null);
    }// </editor-fold>//GEN-END:initComponents

    private void jButton1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButton1ActionPerformed
        // TODO add your handling code here:
        JFileChooser fileChooser = new JFileChooser();

        // For Directory
        fileChooser.setFileSelectionMode(JFileChooser.FILES_AND_DIRECTORIES);

        // For File
        //fileChooser.setFileSelectionMode(JFileChooser.FILES_ONLY);
        fileChooser.setAcceptAllFileFilterUsed(false);

        int rVal = fileChooser.showOpenDialog(null);
        if (rVal == JFileChooser.APPROVE_OPTION) {
            //          lblresultado.setText(fileChooser.getSelectedFile().toString());
        }
        caminhoFile = fileChooser.getCurrentDirectory().toString();
    }//GEN-LAST:event_jButton1ActionPerformed
    public void executarScript(String plsSql) throws SQLException {
        try {
            conexao = Conexao.conector(TelaLogin.alias, TelaLogin.usuario, TelaLogin.senha);
            String sql = plsSql;

            CallableStatement cs = conexao.prepareCall(sql);
//            cs.registerOutParameter(1, java.sql.Types.VARCHAR);
//            cs.registerOutParameter(1, Types.OTHER);
            cs.registerOutParameter(1, Types.ARRAY,
                    "DBMSOUTPUT_LINESARRAY");
            cs.execute();
            Array array = null;
            try {
                array = cs.getArray(1);
                Stream.of((Object[]) array.getArray())
                        .forEach(System.out::println);
            } finally {
                if (array != null) {
                    array.free();
                }
            }
            conexao.close();
            cs.close();
//	    rs =  (ResultSet) cs.getObject(1);

//	     System.out.println(rs);  
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    //retorno da execução
    public void retornoExecucao(String msg) {
        System.out.println("aqui " + msg);
        if (msg.contains("SE FAZ NECESSARIO")) {
            error = 1;
            msg = "PARA A APLICACAO DO PACOTE 30.113.03.00, SE FAZ NECESSARIO ESTAR NA VERSAO 30.113.02.00";
        } else {
            error = 0;
        }
        this.executarScript = msg;
    }

    //retorno da execução
    public void tratarMsg(String msg) {
        if (msg.contains("CREATE TABLE")) {
            msg = "\r\nTabela alterada.\r\n";
        } else if (msg.contains("GRANT")) {
            msg = "\r\nConcessão bem-sucedida.\r\n";
        } else if (msg.contains("COMMENT")) {
            msg = "\r\nComentário criado.\r\n";
        } else if (msg.contains("PUBLIC SYNONYM")) {
            msg = "\r\nSinônimo criado.\r\n";
        } else if (msg.contains("INDEX")) {
            msg = "\r\nÍndice criado.\r\n";
        }

        System.out.println(msg);
        this.tratarMsg = msg;
    }

    public void executarSqlPlus(String sql) {
        String sqlPath = "C:\\";
        String sqlCmd = "sqlplus";
        String conexao = TelaLogin.usuario + "/" + TelaLogin.senha + "@" + TelaLogin.alias;

        try {
            String line;
            ProcessBuilder pb = new ProcessBuilder(sqlCmd, conexao, sql);
            Map<String, String> env = pb.environment();
            env.put("VAR1", conexao);
            env.put("VAR2", sql);
            pb.directory(new File(sqlPath));
            pb.redirectErrorStream(true);
            Process p = pb.start();
            BufferedReader bri = new BufferedReader(new InputStreamReader(p.getInputStream()));
            BufferedReader bre = new BufferedReader(new InputStreamReader(p.getErrorStream()));
            String msg = "";
            while ((line = bri.readLine()) != null) {
                msg += line + "\r\n";
                System.out.println(line);
            }
            bri.close();
            while ((line = bre.readLine()) != null) {
                msg += line + "\r\n";
                System.out.println(line);
            }
            bre.close();
            retornoExecucao(msg);
            //   JOptionPane.showMessageDialog(null,msg);
        } catch (Exception err) {
            err.printStackTrace();
        }

    }

    /**
     * executar script de aplicação.
     */
    public void execSqlScript(File inputFile) throws IOException {
        conexao = Conexao.conector(TelaLogin.alias, TelaLogin.usuario, TelaLogin.senha);
        // Delimiter
        String delimiter = ";", msgErro = "", linha = "";

        FileInputStream stream = new FileInputStream(inputFile);
        InputStreamReader reader = new InputStreamReader(stream);
        BufferedReader br = new BufferedReader(reader);
        String linhaExec = br.readLine();
        Scanner scanner;
        // Create scanner
        try {
            scanner = new Scanner(inputFile).useDelimiter(delimiter);
        } catch (FileNotFoundException e1) {
            e1.printStackTrace();
            return;
        }
        // Loop through the SQL file statements 
        Statement currentStatement = null;

        while(scanner.hasNext()) {

            // Get statement 
            String rawStatement = scanner.next();
            int sqlConut = rawStatement.length();
            try {
                if (sqlConut > 2) {
                    // Execute statement
                    currentStatement = conexao.createStatement();
                    currentStatement.execute(rawStatement);
                    tratarMsg(rawStatement);
                    msgErro += this.tratarMsg + "\r\n";
                }
            } catch (SQLException e) {
                //linha += rawStatement;
                msgErro += e + "\r\n";
                e.printStackTrace();
            } finally {
                // Release resources
                if (currentStatement != null) {
                    try {
                        currentStatement.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
                currentStatement = null;
                //System.out.println(sqlConut);
            }

            linhaExec = br.readLine();
            scanner.close();
        }
        //logMsg = inputFile + "\r\n" +linha +"\r\n"+  msgErro;
        logMsg = inputFile + "\r\n \r\n" + msgErro;
        FileWriter arquivo;

        try {
            arquivo = new FileWriter(new File("log.txt"));
            logSession += logMsg;
            arquivo.write(logSession);
            arquivo.close();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        //JOptionPane.showMessageDialog(null, logMsg);
    }

    private void jButton2ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButton2ActionPerformed
        //pegar diretório atual
        String diretorio = System.getProperty("user.dir");

        try {
            conexao = Conexao.conector(TelaLogin.alias, TelaLogin.usuario, TelaLogin.senha);
        } catch (IOException ex) {
            Logger.getLogger(TelaAplicacao.class.getName()).log(Level.SEVERE, null, ex);
        }
        File file = new File(diretorio);
        File afile[] = file.listFiles();
        int i = 0;
        String caminho = "";
        for (int j = afile.length; i < j; i++) {
            File arquivos = afile[i];
            if (arquivos.getName().contains("scr_aplica_pacote")) {
                FileReader arq = null;
                try {
                    caminho = diretorio + File.separator + arquivos.getName();
                    arq = new FileReader(caminho);
                    BufferedReader lerArq = new BufferedReader(arq);
                    File arquivoLeitura = new File(caminho);
                    long tamanhoArquivo = arquivoLeitura.length();
                    FileInputStream fs = new FileInputStream(arquivoLeitura);
                    DataInputStream in = new DataInputStream(fs);
                    LineNumberReader lineRead = new LineNumberReader(new InputStreamReader(in));
                    lineRead.skip(tamanhoArquivo);
                    int numLinhas = lineRead.getLineNumber() + 1;
                    String linha = lerArq.readLine(); // lê a primeira linha
                    FileReader arqBanco = null;
                    String linhaBanco = "";
                    String sqlEstrutura = "";

                    while (linha != null) {
                        if (linha.contains("@Banco")) {
                            linhaBanco = linha.replaceAll("@", "");
                            arqBanco = new FileReader(linhaBanco);
                            BufferedReader lerArqBanco = new BufferedReader(arqBanco);
                            File arquivoBanco = new File(linhaBanco);
                            long tamanhoBanco = arquivoBanco.length();
                            FileInputStream fsBanco = new FileInputStream(arquivoBanco);
                            DataInputStream inBanco = new DataInputStream(fsBanco);

                            LineNumberReader lineBanco = new LineNumberReader(new InputStreamReader(inBanco));
                            lineBanco.skip(tamanhoBanco);

                            String linhaReadLine = lerArqBanco.readLine(); // lê a primeira linha
                            int numLinhasBanco = lineBanco.getLineNumber() + 1;
                            execSqlScript(arquivoBanco);
                            /*while (linhaReadLine != null) {
                                // System.out.println(linhaReadLine);
                                linhaReadLine = lerArqBanco.readLine();
                                sqlEstrutura += linhaReadLine;
                            }*/
                            System.out.println(sqlEstrutura);
                            //     System.out.println(linha);
                        }
                        linha = lerArq.readLine();
                    }
                } catch (FileNotFoundException ex) {
                    Logger.getLogger(TelaAplicacao.class.getName()).log(Level.SEVERE, null, ex);
                } catch (IOException ex) {
                    Logger.getLogger(TelaAplicacao.class.getName()).log(Level.SEVERE, null, ex);
                } finally {
                    try {
                        arq.close();
                    } catch (IOException ex) {
                        Logger.getLogger(TelaAplicacao.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }
            }
            //getName += arquivos.getName();
        }
        //caminho do upload
        /* String comando = lblresultado.getText();

        //lendo o arquivo do upload "o arquivo que foi selecionado pelo usuário"
        try {
            FileReader arq = new FileReader(comando);
            BufferedReader lerArq = new BufferedReader(arq);
            File arquivoLeitura = new File(comando);
            long tamanhoArquivo = arquivoLeitura.length();
            FileInputStream fs = new FileInputStream(arquivoLeitura);
            DataInputStream in = new DataInputStream(fs);

            LineNumberReader lineRead = new LineNumberReader(new InputStreamReader(in));
            lineRead.skip(tamanhoArquivo);
            // conta o numero de linhas do arquivo, começa com zero, por isso adiciona 1
            int numLinhas = lineRead.getLineNumber() + 1;
            String linha = lerArq.readLine(); // lê a primeira linha
            int linhaArq = 1;
            int linhaArqValida = 1;
            int linhaCount = 1;
            
            //váriaveis exclusivas do laço
            String linhaReplace = "";
            String caminhoFileUnion = "";
            String replaceAplica = "";
            String joinTxt = "";

            //contando linha a linha do arquivo upado
            while (linha != null) {
                linhaReplace = linha.replaceAll("@", "");
                caminhoFileUnion = "@" + caminhoFile + "\\" + linhaReplace;

                //entrando na primeira condição
                if (caminhoFileUnion.contains("scr_valida_versao")) {
                    linhaReplace = caminhoFileUnion.replaceAll("@", "");
                    FileReader arqValida = new FileReader(linhaReplace);
                    BufferedReader lerArqValida = new BufferedReader(arqValida);
                    File arquivoLeituraValida = new File(linhaReplace);
                    long tamanhoArquivoValida = arquivoLeituraValida.length();
                    FileInputStream fsValida = new FileInputStream(arquivoLeituraValida);
                    DataInputStream inValida = new DataInputStream(fsValida);

                    LineNumberReader lineReadValida = new LineNumberReader(new InputStreamReader(inValida));
                    lineReadValida.skip(tamanhoArquivoValida);

                    String linhaValida = lerArqValida.readLine(); // lê a primeira linha
                    int numLinhasValida = lineReadValida.getLineNumber() + 1;

                    String linhaValidaJoin = "";
                    
                    while (linhaValida != null) {
                        if ((linhaValida.contains("valida_versao")) && (!linhaValida.contains(caminhoFile))) {
                            if (linhaValida.contains("SPOOL valida_versao.sql")) {
                                joinTxt += "SPOOL ";
                                String validaVersao = linhaReplace.replaceAll("scr_valida_versao", "valida_versao");
                                joinTxt += validaVersao;
                            } else {
                                String validaVersao = caminhoFileUnion.replaceAll("scr_valida_versao", "valida_versao");
                                joinTxt += validaVersao;
                                joinTxt = "@" + joinTxt;
                            }

                        } else if (linhaValida.contains("SCR_EXECUCAO_PACOTE") && (!linhaValida.contains(caminhoFile))) {
                            String caminhoLog = caminhoFile + "\\" + "SCR_EXECUCAO_PACOTE.LOG";
                            String caminhoReplace = caminhoLog.replace("\\", "-");
                            String validaVersao = linhaValida.replaceAll("SCR_EXECUCAO_PACOTE.LOG", caminhoReplace);
                            validaVersao = validaVersao.replace("-", "\\");
                            joinTxt += validaVersao;
                        } else {
                            joinTxt += linhaValida + "\r\n";
                        }
                        
                        if (joinTxt.contains("@SET LINES500")) {
                            joinTxt = joinTxt.replaceAll("@SET LINES500", "SET LINES500");
                        }
                        linhaValida = lerArqValida.readLine(); // lê da segunda até a última linha

                        linhaArqValida++;
                    }
                    FileWriter arqWriter = new FileWriter(linhaReplace); // caminho do arquivo ler essa função ler o arquivo
                    //   linhaValida +=  arqWriter;
                    PrintWriter gravarArq = new PrintWriter(arqWriter);
                    gravarArq.printf(joinTxt); // reescreve o arquivo
                    arqWriter.close();

                    executarSqlPlus(caminhoFileUnion);
                    JOptionPane.showMessageDialog(null, this.error);
                } else if (caminhoFileUnion.contains("scr_aplica_pacote")) {
                    linhaReplace = linha.replaceAll("@", "");
                    caminhoFileUnion = caminhoFile + "\\" + linhaReplace;

                    FileReader arqAplica = new FileReader(caminhoFileUnion);
                    BufferedReader lerAplica = new BufferedReader(arqAplica);
                    File arquivoAplica = new File(caminhoFileUnion);
                    long tamanhoAplica = arquivoAplica.length();
                    FileInputStream fsAplica = new FileInputStream(arquivoAplica);
                    DataInputStream inAplica = new DataInputStream(fsAplica);

                    LineNumberReader lineAplica = new LineNumberReader(new InputStreamReader(inAplica));
                    lineAplica.skip(tamanhoAplica);
                    // conta o numero de linhas do arquivo, começa com zero, por isso adiciona 1
                    int numAplica = lineAplica.getLineNumber() + 1;
                    String linhaAplica = lerAplica.readLine(); // lê a primeira linha

                    while (linhaAplica != null) {
                        
                        if ((linhaAplica.contains("Banco") || linhaAplica.contains("banco") || linhaAplica.contains("BANCO"))
                                && (!linhaAplica.contains("PROMPT")) && (!linhaAplica.contains(caminhoFile)) ) {
                            if (linhaAplica.contains("Banco")) {
                                String caminhoAplica = caminhoFile.replace("\\", "-");
                                caminhoAplica += "-";
                                replaceAplica = linhaAplica.replaceAll("@", "");
                                replaceAplica = linhaAplica.replaceAll("Banco", caminhoAplica + "Banco");
                                replaceAplica = replaceAplica.replace("-", "\\");
                                
                                joinTxt += replaceAplica + "\r\n";
                            } else if (linhaAplica.contains("banco")) {
                                replaceAplica = linhaAplica.replaceAll("@", "");
                                replaceAplica = linhaAplica.replaceAll("banco", caminhoFile);
                                replaceAplica = replaceAplica.replace("-", "\\");
                                joinTxt += replaceAplica + "\r\n";
                            } else {
                                replaceAplica = linhaAplica.replaceAll("@", "");
                                replaceAplica = linhaAplica.replaceAll("BANCO", caminhoFile);
                                replaceAplica = replaceAplica.replace("-", "\\");
                                joinTxt += replaceAplica + "\r\n";
                            }
                        }else{
                            joinTxt += linhaAplica + "\r\n";
                        }                 

                        linhaAplica = lerAplica.readLine();

                    }
                    FileWriter arqWriter = new FileWriter(caminhoFileUnion);
                    PrintWriter gravarArq = new PrintWriter(arqWriter);
                    gravarArq.printf(joinTxt);
                    arqWriter.close();
                    
                    caminhoFileUnion = "@" + caminhoFileUnion;
                    executarSqlPlus(caminhoFileUnion);
                } else if (caminhoFileUnion.contains("scr_pre_validacao")) {
                    linhaReplace = linha.replaceAll("@", "");
                    caminhoFileUnion = "@" + caminhoFile + "\\" + linhaReplace;
                    executarSqlPlus(caminhoFileUnion);
                } else if (caminhoFileUnion.contains("scr_versao_pacote")) {
                    linhaReplace = linha.replaceAll("@", "");
                    caminhoFileUnion = "@" + caminhoFile + "\\" + linhaReplace;
                    executarSqlPlus(caminhoFileUnion);
                } else if (caminhoFileUnion.contains("scr_validacao")) {
                    linhaReplace = linha.replaceAll("@", "");
                    caminhoFileUnion = "@" + caminhoFile + "\\" + linhaReplace;
                    executarSqlPlus(caminhoFileUnion);
                }
                linhaArq++;
                linha = lerArq.readLine(); // lê da segunda até a última linha
            }
        } catch (IOException e) {
            System.err.printf("Erro na abertura do arquivo: %s.\n",
                    e.getMessage());
        }*/

    }//GEN-LAST:event_jButton2ActionPerformed

    /**
     * @param args the command line arguments
     */
    public static void main(String args[]) {
        /* Set the Nimbus look and feel */
        //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">
        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.
         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html 
         */
        try {
            javax.swing.UIManager.setLookAndFeel(javax.swing.UIManager.getSystemLookAndFeelClassName());
//            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
//                if ("Windows".equalsIgnoreCase(info.getName())) {
//                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
//                    break;
//                }
//            }
        } catch (ClassNotFoundException ex) {
            java.util.logging.Logger.getLogger(TelaAplicacao.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(TelaAplicacao.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(TelaAplicacao.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(TelaAplicacao.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new TelaAplicacao().setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton jButton1;
    private javax.swing.JButton jButton2;
    // End of variables declaration//GEN-END:variables
}

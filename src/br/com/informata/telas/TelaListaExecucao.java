/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.informata.telas;

import java.sql.*;
import br.com.informata.dal.Conexao;
import br.com.informata.telas.TelaLogin;
import br.com.informata.utilitarios.ModeloTabela;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JOptionPane;
import javax.swing.ListSelectionModel;
import javax.swing.table.TableModel;
import net.proteanit.sql.DbUtils;
import oracle.jdbc.OracleTypes;

/**
 *
 * @author rhuan.silva
 */
public class TelaListaExecucao extends javax.swing.JFrame {

    Connection conexao = null;
    PreparedStatement pst = null;
    ResultSet rs = null;
    Statement stmt = null;
    String erro = "";
    FileWriter arquivo = null;

    /**
     * Creates new form TelaListaUsuarios
     */
    public void matarTodasSessoes() throws SQLException, IOException {
        try {
            conexao = Conexao.conector(TelaLogin.alias, TelaLogin.usuario, TelaLogin.senha);
            String plSql = "DECLARE \n"
                    + "  CURSOR c_lista IS\n"
                    + "        select 'ALTER SYSTEM KILL SESSION '''||B.SID||','||B.SERIAL#||''' IMMEDIATE' LINHA"
                    + "    FROM V$SESSION B\n"
                    + "    WHERE B.USERNAME <> '" + TelaLogin.usuario + "';\n"
                    + "BEGIN\n"
                    + "  FOR vc_lista in c_lista LOOP\n"
                    + "    BEGIN\n"
                    + "      EXECUTE IMMEDIATE vc_lista.linha;\n"
                    + "    EXCEPTION\n"
                    + "      WHEN OTHERS THEN\n"
                    + "        NULL;\n"
                    + "    END;\n"
                    + "  END LOOP;\n"
                    + "END;";
            CallableStatement cs = conexao.prepareCall(plSql);
            cs.execute();
            conexao.close();
            cs.close();
        } catch (Exception e) {
            erro += e.getMessage();
            e.printStackTrace();
        }
        arquivo = new FileWriter("C:\\Users\\rhuan.silva\\Documents\\NetBeansProjects\\aplicadorDesktop\\log.txt", false);
        arquivo.write("erro:  " + erro);
        arquivo.close();

    }

    public void matarSessoes(int sid, int serial) throws SQLException, IOException {
        try {
            conexao = Conexao.conector(TelaLogin.alias, TelaLogin.usuario, TelaLogin.senha);
            String plSql = "DECLARE \n"
                    + "  CURSOR c_lista IS\n"
                    + "        select 'ALTER SYSTEM KILL SESSION '''||B.SID||','||B.SERIAL#||''' IMMEDIATE' LINHA"
                    + "    FROM V$SESSION B\n"
                    + "    WHERE B.USERNAME <> '" + TelaLogin.usuario + "' AND B.SID =" + sid + " AND B.SERIAL# =" + serial + ";\n"
                    + "BEGIN\n"
                    + "  FOR vc_lista in c_lista LOOP\n"
                    + "    BEGIN\n"
                    + "      EXECUTE IMMEDIATE vc_lista.linha;\n"
                    + "    EXCEPTION\n"
                    + "      WHEN OTHERS THEN\n"
                    + "        NULL;\n"
                    + "    END;\n"
                    + "  END LOOP;\n"
                    + "END;";
            CallableStatement cs = conexao.prepareCall(plSql);
            cs.execute();
            conexao.close();
            cs.close();
        } catch (Exception e) {
            erro += e.getMessage();
            e.printStackTrace();
        }
        arquivo = new FileWriter("C:\\Users\\rhuan.silva\\Documents\\NetBeansProjects\\aplicadorDesktop\\log.txt", false);
        arquivo.write("erro:  " + erro);
        arquivo.close();

    }

    public void listarExecucoes() throws SQLException, IOException {
        conexao = Conexao.conector(TelaLogin.alias, TelaLogin.usuario, TelaLogin.senha);
        ArrayList dados = new ArrayList();
        String[] colunas = new String[]{"USERNAME", "OSUSER", "SID", "SERIAL#", "MACHINE", "PROGRAM"};
        if (conexao != null) {
            try {
                stmt = conexao.createStatement(rs.TYPE_SCROLL_INSENSITIVE, rs.CONCUR_READ_ONLY);
                ResultSet rs = stmt.executeQuery("select USERNAME,OSUSER,SID,SERIAL#,MACHINE,PROGRAM FROM V$SESSION where OSUSER <> 'oracle' ");
                rs.first();

                do {
                    dados.add(new Object[]{rs.getString("USERNAME"), rs.getString("OSUSER"), rs.getInt("SID"), rs.getInt("SERIAL#"),
                        rs.getString("MACHINE"), rs.getString("PROGRAM")});
                } while (rs.next());
            } catch (Exception e) {
                erro += e.getMessage();
                JOptionPane.showMessageDialog(null, "Erro ao preencher a tabela" + e);
            }
            ModeloTabela modelo = new ModeloTabela(dados, colunas);
            tblUsuarios.setModel(modelo);
            tblUsuarios.getColumnModel().getColumn(0).setPreferredWidth(200);
            tblUsuarios.getColumnModel().getColumn(0).setResizable(false);
            tblUsuarios.getColumnModel().getColumn(1).setPreferredWidth(200);
            tblUsuarios.getColumnModel().getColumn(1).setResizable(false);
            tblUsuarios.getColumnModel().getColumn(2).setPreferredWidth(100);
            tblUsuarios.getColumnModel().getColumn(2).setResizable(false);
            tblUsuarios.getColumnModel().getColumn(3).setPreferredWidth(100);
            tblUsuarios.getColumnModel().getColumn(3).setResizable(false);
            tblUsuarios.getColumnModel().getColumn(4).setPreferredWidth(200);
            tblUsuarios.getColumnModel().getColumn(4).setResizable(false);
            tblUsuarios.getColumnModel().getColumn(5).setPreferredWidth(200);
            tblUsuarios.getColumnModel().getColumn(5).setResizable(false);
            tblUsuarios.getTableHeader().setReorderingAllowed(false);
            tblUsuarios.setAutoResizeMode(tblUsuarios.AUTO_RESIZE_OFF);
            tblUsuarios.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
            arquivo = new FileWriter("C:\\Users\\rhuan.silva\\Documents\\NetBeansProjects\\aplicadorDesktop\\log.txt", false);
            arquivo.write("erro:  " + erro);
            arquivo.close();
            conexao.close();
        }
    }

    public TelaListaExecucao() throws SQLException, IOException {

        try {
            initComponents();
            listarExecucoes();
            tblUsuarios.setRowSelectionAllowed(true);
            tblUsuarios.setSelectionMode(ListSelectionModel.MULTIPLE_INTERVAL_SELECTION);
        } catch (Exception e) {
            erro += e.getMessage();
        }
        arquivo = new FileWriter("C:\\Users\\rhuan.silva\\Documents\\NetBeansProjects\\aplicadorDesktop\\log.txt", false);
        arquivo.write("erro:  " + erro);
        arquivo.close();

    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        btnProximo = new javax.swing.JButton();
        jScrollPane1 = new javax.swing.JScrollPane();
        tblUsuarios = new javax.swing.JTable();
        jButton1 = new javax.swing.JButton();
        jButton2 = new javax.swing.JButton();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
        setCursor(new java.awt.Cursor(java.awt.Cursor.DEFAULT_CURSOR));

        btnProximo.setText("Próximo");
        btnProximo.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnProximoActionPerformed(evt);
            }
        });

        tblUsuarios.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {
                {null, null, null, null},
                {null, null, null, null},
                {null, null, null, null},
                {null, null, null, null}
            },
            new String [] {
                "Title 1", "Title 2", "Title 3", "Title 4"
            }
        ));
        jScrollPane1.setViewportView(tblUsuarios);

        jButton1.setText("Matar sessão");
        jButton1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButton1ActionPerformed(evt);
            }
        });

        jButton2.setText("Matar todas as sessões");
        jButton2.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButton2ActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jScrollPane1, javax.swing.GroupLayout.DEFAULT_SIZE, 467, Short.MAX_VALUE)
                .addGap(18, 18, 18)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jButton1)
                    .addComponent(jButton2)
                    .addComponent(btnProximo))
                .addGap(23, 23, 23))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(layout.createSequentialGroup()
                        .addGap(0, 0, Short.MAX_VALUE)
                        .addComponent(jButton1)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addComponent(jButton2)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addComponent(btnProximo)
                        .addGap(18, 18, 18))
                    .addComponent(jScrollPane1, javax.swing.GroupLayout.DEFAULT_SIZE, 492, Short.MAX_VALUE))
                .addGap(23, 23, 23))
        );

        setSize(new java.awt.Dimension(679, 565));
        setLocationRelativeTo(null);
    }// </editor-fold>//GEN-END:initComponents

    private void btnProximoActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnProximoActionPerformed
        this.dispose();
        new TelaAplicacao().setVisible(true);
        try {
            // TODO add your handling code here:
            listarExecucoes();
        } catch (SQLException ex) {
            Logger.getLogger(TelaListaExecucao.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(TelaListaExecucao.class.getName()).log(Level.SEVERE, null, ex);
        }
    }//GEN-LAST:event_btnProximoActionPerformed

    private void jButton2ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButton2ActionPerformed
        try {
            // TODO add your handling code here:
            matarTodasSessoes();
        } catch (SQLException ex) {
            Logger.getLogger(TelaListaExecucao.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(TelaListaExecucao.class.getName()).log(Level.SEVERE, null, ex);
        }
    }//GEN-LAST:event_jButton2ActionPerformed

    private void jButton1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButton1ActionPerformed
        // TODO add your handling code here:
        int linhaSelecionada = -1;
        int qtdSelecionada = tblUsuarios.getSelectedRowCount();
        //String idTable =  (String)tblUsuarios.getModel().getValueAt(tblUsuarios.convertRowIndexToModel(linhaSelecionada), 0); 
        if (qtdSelecionada > 0) {
            int[] linhasSelecionadas = tblUsuarios.getSelectedRows();
            JOptionPane.showMessageDialog(null, qtdSelecionada);
            for (int i = linhasSelecionadas.length - 1; i >= 0; i--) {
                int sid = (int) tblUsuarios.getModel().getValueAt(tblUsuarios.convertRowIndexToModel(linhasSelecionadas[i]), 2);
                int serial = (int) tblUsuarios.getModel().getValueAt(tblUsuarios.convertRowIndexToModel(linhasSelecionadas[i]), 3);
                try {
                    matarSessoes(sid, serial);
                    JOptionPane.showMessageDialog(null, "SID(" + sid + ") foi finalizado!");
                    JOptionPane.showMessageDialog(null, i);
                } catch (SQLException ex) {
                    Logger.getLogger(TelaListaExecucao.class.getName()).log(Level.SEVERE, null, ex);
                } catch (IOException ex) {
                    Logger.getLogger(TelaListaExecucao.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            try {
                listarExecucoes();
            } catch (SQLException ex) {
                Logger.getLogger(TelaListaExecucao.class.getName()).log(Level.SEVERE, null, ex);
            } catch (IOException ex) {
                Logger.getLogger(TelaListaExecucao.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else {
            JOptionPane.showMessageDialog(null, "Selecione uma sessão!");
        }
        ListSelectionModel selectionModel = tblUsuarios.getSelectionModel();
    }//GEN-LAST:event_jButton1ActionPerformed

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
//                if ("Windows".equals(info.getName())) {
//                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
//                    break;
//                }
//            }
        } catch (ClassNotFoundException ex) {
            java.util.logging.Logger.getLogger(TelaListaExecucao.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(TelaListaExecucao.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(TelaListaExecucao.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(TelaListaExecucao.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                try {
                    new TelaListaExecucao().setVisible(true);
                } catch (SQLException ex) {
                    Logger.getLogger(TelaListaExecucao.class.getName()).log(Level.SEVERE, null, ex);
                } catch (IOException ex) {
                    Logger.getLogger(TelaListaExecucao.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton btnProximo;
    private javax.swing.JButton jButton1;
    private javax.swing.JButton jButton2;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JTable tblUsuarios;
    // End of variables declaration//GEN-END:variables
}

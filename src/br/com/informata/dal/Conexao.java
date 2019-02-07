/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.informata.dal;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.*;
/**
 *
 * @author rhuan.silva
 */
public class Conexao {
    public static Connection conector(String alias, String usuario,String senha) throws IOException{
        java.sql.Connection conexao = null;
        String driver = "oracle.jdbc.driver.OracleDriver";
        String user = usuario;
        String pass = senha;
        String base = alias;
        String erro = "";
        FileWriter arquivo = null;
        
        System.setProperty(
              "oracle.net.tns_admin",System.getenv("TNS_ADMIN"));
        String url = "jdbc:oracle:thin:@"+base;
            try {
                conexao = DriverManager.getConnection(url,user,pass);
                return conexao;
                
            } catch (Exception e) {
                erro += e.getMessage();
                arquivo = new FileWriter("C:\\Users\\rhuan.silva\\Documents\\NetBeansProjects\\aplicadorDesktop\\log.txt", false);
                arquivo.write("erro:  " + erro);
                arquivo.close();  
                //System.out.println(e.getMessage());
                return null;
            }
            
    }
}

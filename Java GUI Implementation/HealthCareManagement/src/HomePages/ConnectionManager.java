/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package HomePages;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author apoorva
 */
public class ConnectionManager {
    
    private static String url = "jdbc:sqlserver://localhost:1433;databaseName=Healthcare";
    private static String driverName = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
    private static String username = "root";
    private static String password = "root";
    private static Connection connection;
    private static String stringUrl;
    
    public static Connection getConnection() {
        try{
            Class.forName(driverName);
            try{
                connection = DriverManager.getConnection(url, username, password);
                System.out.println("Connection Successful");    
            } catch(SQLException ex){
                System.out.println("Failed to create database connection!");
                ex.printStackTrace();
            }
            
        } catch(ClassNotFoundException ex){
            System.out.println("Driver not found!");
        }
        return connection;
    }
    
    public static void main(String[] args) {
        getConnection();
    }
}
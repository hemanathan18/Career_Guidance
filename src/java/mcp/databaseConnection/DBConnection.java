package mcp.databaseConnection;

import java.sql.*;

public class DBConnection {
    
    public static Connection getConnection() throws SQLException
    {
        String url = "jdbc:mysql://localhost:3306/testdatabase";
        String username="root";
        String password="";
       
        Connection con=DriverManager.getConnection(url, username, password);
        return con;
    }    
    
}

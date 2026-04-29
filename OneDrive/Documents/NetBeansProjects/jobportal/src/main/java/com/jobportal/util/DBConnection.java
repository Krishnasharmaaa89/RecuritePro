package com.jobportal.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * DBConnection.java - Utility class for MySQL database connectivity.
 * Uses JDBC to connect to the 'job_portal' database.
 * 
 * IMPORTANT: Update the URL, USER, and PASSWORD as per your MySQL setup.
 */
public class DBConnection {

    // Database configuration - UPDATE THESE VALUES
    private static final String URL = "jdbc:mysql://localhost:3306/job_portal?useSSL=false&serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASSWORD = "Avdhesh@2004"; // Change to your MySQL password

    /**
     * Returns a new connection to the MySQL database.
     * Make sure MySQL is running and the 'job_portal' database exists.
     */
    public static Connection getConnection() throws SQLException {
        try {
            // Load MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.err.println("MySQL JDBC Driver not found! Add mysql-connector-j.jar to WEB-INF/lib");
            throw new SQLException("Driver not found", e);
        }
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

    /**
     * Closes a database connection safely.
     */
    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}

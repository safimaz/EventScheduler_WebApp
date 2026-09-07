package com.event.scheduler.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String URL =
//            "jdbc:oracle:thin:@localhost:1521/FREEPDB1";
    		"jdbc:oracle:thin:@localhost:1521/FREE";

    private static final String USERNAME =
//            "EVENT_SCHEDULER";
			"C##itcuser";


    private static final String PASSWORD =
//            "EventScheduler2026";
			"itcuser";

    private DBConnection() {
        // Prevent object creation
    }

    public static Connection getConnection() throws SQLException {

        try {
            Class.forName("oracle.jdbc.OracleDriver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("Oracle JDBC Driver not found!", e);
        }

        return DriverManager.getConnection(
                URL,
                USERNAME,
                PASSWORD
        );
    }
}
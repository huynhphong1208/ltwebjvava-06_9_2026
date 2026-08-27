package com.example.demobtvenha25_8.dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBcontext {

    // Cấu hình kết nối cho máy Local (127.0.0.1 / localhost)
    private static final String HOST = "localhost"; // Hoặc "127.0.0.1"
    private static final String PORT = "1433";
    private static final String DB_NAME = "demo_db";

    // Điền tài khoản SQL Server Authentication của bạn tại đây
    private static final String USERNAME = "sa";
    private static final String PASSWORD = "123456"; // Thay bằng mật khẩu sa của bạn

    private static final String URL = "jdbc:sqlserver://" + HOST + ":" + PORT
            + ";databaseName=" + DB_NAME
            + ";encrypt=false;trustServerCertificate=true";

    public static Connection getConnection() {
        Connection conn = null;
        try {
            // Nạp Driver SQL Server
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

            // Mở kết nối
            conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);
        } catch (Exception e) {
            System.err.println("Lỗi kết nối CSDL Local: " + e.getMessage());
            e.printStackTrace();
        }
        return conn;
    }

    // Hàm main để test thử kết nối trực tiếp trong IntelliJ
    public static void main(String[] args) {
        Connection testConn = getConnection();
        if (testConn != null) {
            System.out.println("-> Kết nối SQL Server Local THÀNH CÔNG!");
        } else {
            System.out.println("-> Kết nối THẤT BẠI! Hãy kiểm tra lại username/password hoặc SQL Server Service.");
        }
    }
}
package tienda.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexionBD {

    // 1. Reemplaza con el HOST público y PUERTO de la pestaña "Connect" en Railway
    // Ejemplo de Host: monorail.proxy.rlwy.net
    // Ejemplo de Puerto: 12345
    private static final String HOST = "monorail.proxy.rlwy.net";
    private static final String PORT = "36863";
    private static final String DB_NAME = "railway"; // Nombre de la base de datos en Railway

    // 2. URL armada con los parámetros de la nube
    private static final String URL = "jdbc:mysql://" + HOST + ":" + PORT + "/" + DB_NAME 
            + "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC&useUnicode=true&characterEncoding=UTF-8";

    // 3. Credenciales que obtuviste de la pestaña Variables
    private static final String USER = "root"; // O el valor de MYSQLUSER
    private static final String PASSWORD = "TeJnTeMWFoUlwVeDzJYEOGqsvvHfrSNv"; // El valor copiado de MYSQLPASSWORD
    
    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";

    public static Connection getConexion() {
        Connection con = null;
        try {
            Class.forName(DRIVER);
            con = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            System.err.println("Error: Driver MySQL no encontrado. Revisa la carpeta libs. " + e.getMessage());
        } catch (SQLException e) {
            System.err.println("Error al conectar con MySQL: " + e.getMessage());
        }
        return con;
    }
}
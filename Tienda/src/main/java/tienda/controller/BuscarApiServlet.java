package tienda.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

// Importaciones ajustadas exactamente a tu paquete tienda.model
import tienda.model.Producto;
import tienda.model.ProductoDAO;

@WebServlet(name = "BuscarApiServlet", urlPatterns = {"/BuscarApiServlet"})
public class BuscarApiServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json;charset=UTF-8");
        String query = request.getParameter("q");
        
        ProductoDAO dao = new ProductoDAO();
        // Llama a tu método de búsqueda en ProductoDAO
        List<Producto> resultados = dao.buscarProductos(query != null ? query.trim() : "");

        StringBuilder json = new StringBuilder("[");
        if (resultados != null) {
            for (int i = 0; i < resultados.size(); i++) {
                Producto p = resultados.get(i);
                json.append("{")
                    .append("\"id\":\"").append(p.getId()).append("\",")
                    .append("\"nombre\":\"").append(escapeJson(p.getNombre())).append("\",")
                    .append("\"precio\":\"").append(p.getPrecio()).append("\",")
                    .append("\"precioOferta\":").append(p.getPrecioOferta() != null ? "\"" + p.getPrecioOferta() + "\"" : "null").append(",")
                    .append("\"imagenUrl\":\"").append(escapeJson(p.getImagenUrl())).append("\",")
                    .append("\"categoria\":\"").append(escapeJson(p.getCategoria())).append("\"")
                    .append("}");
                if (i < resultados.size() - 1) {
                    json.append(",");
                }
            }
        }
        json.append("]");

        try (PrintWriter out = response.getWriter()) {
            out.print(json.toString());
        }
    }

    private String escapeJson(String input) {
        if (input == null) return "";
        return input.replace("\\", "\\\\")
                    .replace("\"", "\\\"")
                    .replace("\n", "\\n")
                    .replace("\r", "\\r");
    }
}
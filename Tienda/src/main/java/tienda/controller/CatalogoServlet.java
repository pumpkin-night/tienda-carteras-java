package tienda.controller;

import tienda.model.Producto;
import tienda.model.ProductoDAO;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "CatalogoServlet", urlPatterns = {"/CatalogoServlet"})
public class CatalogoServlet extends HttpServlet {

    private ProductoDAO productoDAO;

    @Override
    public void init() throws ServletException {
        productoDAO = new ProductoDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Obtener parámetros
        String categoria = request.getParameter("categoria");
        String vista = request.getParameter("vista"); // Para saber si redirigimos a la portada o al catálogo
        
        List<Producto> listaProductos;
        String tituloCategoria;

        // 2. Filtrar o listar todos activos
        if (categoria != null && !categoria.trim().isEmpty() && !categoria.equalsIgnoreCase("todos")) {
            listaProductos = productoDAO.listarPorCategoria(categoria);
            tituloCategoria = categoria;
        } else {
            listaProductos = productoDAO.listarTodosActivos();
            tituloCategoria = "Catálogo Completo";
        }

        // 3. Pasar los atributos compartidos a la Request (sirven para ambas vistas)
        request.setAttribute("productos", listaProductos);
        request.setAttribute("categoriaNombre", tituloCategoria);
        request.setAttribute("totalProductos", listaProductos != null ? listaProductos.size() : 0);

        // 4. Decidir el destino (index.jsp o catalogo.jsp)
        // Si el parámetro vista es 'catalogo' o si seleccionó una categoría específica del menú, va a catalogo.jsp
        if ("catalogo".equalsIgnoreCase(vista) || (categoria != null && !categoria.trim().isEmpty())) {
            request.getRequestDispatcher("catalogo.jsp").forward(request, response);
        } else {
            // Caso por defecto (pantalla de inicio/portada)
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }
}


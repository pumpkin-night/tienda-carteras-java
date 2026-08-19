package tienda.controller;

import tienda.model.Producto;
import tienda.model.ProductoDAO;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/CatalogoServlet")
public class CatalogoServlet extends HttpServlet {

    private ProductoDAO productoDAO;

    @Override
    public void init() throws ServletException {
        productoDAO = new ProductoDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Obtener la categoría seleccionada desde el menú/filtros
        String categoria = request.getParameter("categoria");
        List<Producto> listaProductos;

        // Si se seleccionó una categoría específica, se filtra; de lo contrario, se traen todos
        if (categoria != null && !categoria.trim().isEmpty()) {
            listaProductos = productoDAO.listarPorCategoria(categoria);
        } else {
            listaProductos = productoDAO.listarTodosActivos();
        }

        // Pasar la lista a la vista JSP
        request.setAttribute("productos", listaProductos);

        // Despachar la petición a index.jsp
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
}
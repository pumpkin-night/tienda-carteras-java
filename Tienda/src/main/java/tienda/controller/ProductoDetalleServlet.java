package tienda.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import tienda.model.Producto;
import tienda.model.ProductoDAO;

import java.io.IOException;

@WebServlet("/ProductoDetalleServlet")
public class ProductoDetalleServlet extends HttpServlet {

    private ProductoDAO productoDAO;

    @Override
    public void init() throws ServletException {
        productoDAO = new ProductoDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");

        // Si no recibimos ningún ID
        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendRedirect("CatalogoServlet");
            return;
        }

        try {
            // Convertimos el ID recibido de String a int
            int id = Integer.parseInt(idParam);

            // Buscamos el producto REAL en la base de datos
            Producto producto = productoDAO.obtenerPorId(id);

            // Si el producto existe
            if (producto != null) {

                // Lo enviamos al JSP
                request.setAttribute("producto", producto);

                // Abrimos la página de detalle
                request.getRequestDispatcher("detalle-producto.jsp")
                       .forward(request, response);

            } else {

                // Si no existe ese producto
                response.sendRedirect("CatalogoServlet");
            }

        } catch (NumberFormatException e) {

            // Si el ID no es un número válido
            response.sendRedirect("CatalogoServlet");

        } catch (Exception e) {

            // Error inesperado
            throw new ServletException("Error al obtener el producto con ID: " + idParam, e);
        }
    }
}
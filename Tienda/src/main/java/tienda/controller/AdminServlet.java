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

@WebServlet("/AdminServlet")
public class AdminServlet extends HttpServlet {

    private ProductoDAO productoDAO;

    @Override
    public void init() throws ServletException {
        productoDAO = new ProductoDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String accion = request.getParameter("accion");
        
        if ("editar".equalsIgnoreCase(accion)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Producto prodEditar = productoDAO.obtenerPorId(id);
            request.setAttribute("productoEditar", prodEditar);
        } else if ("cambiarEstado".equalsIgnoreCase(accion)) {
            int id = Integer.parseInt(request.getParameter("id"));
            boolean estadoActual = Boolean.parseBoolean(request.getParameter("estado"));
            productoDAO.cambiarEstado(id, !estadoActual);
            response.sendRedirect("AdminServlet");
            return;
        }

        // Cargar listado general de mercancía
        List<Producto> listaProductos = productoDAO.listarTodosActivos();
        request.setAttribute("productos", listaProductos);
        request.getRequestDispatcher("admin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        String idStr = request.getParameter("id");
        String nombre = request.getParameter("nombre");
        String categoria = request.getParameter("categoria");
        double precio = Double.parseDouble(request.getParameter("precio"));
        
        String ofertaStr = request.getParameter("precioOferta");
        Double precioOferta = (ofertaStr != null && !ofertaStr.trim().isEmpty()) 
                                ? Double.parseDouble(ofertaStr) : null;
                                
        String imagenUrl = request.getParameter("imagenUrl");
        String descripcion = request.getParameter("descripcion");
        String medidas = request.getParameter("medidas");

        Producto p = new Producto();
        p.setNombre(nombre);
        p.setCategoria(categoria);
        p.setPrecio(precio);
        p.setPrecioOferta(precioOferta);
        p.setImagenUrl(imagenUrl);
        p.setDescripcion(descripcion);
        p.setMedidas(medidas);

        if (idStr == null || idStr.trim().isEmpty()) {
            // Guardar nueva cartera
            productoDAO.agregar(p);
        } else {
            // Modificar cartera existente
            p.setId(Integer.parseInt(idStr));
            productoDAO.actualizar(p);
        }

        response.sendRedirect("AdminServlet");
    }
}
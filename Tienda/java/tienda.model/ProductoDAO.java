package tienda.model;

import tienda.config.ConexionBD;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductoDAO {

    // 1. Listar todas las carteras activas (para el catálogo principal)
    public List<Producto> listarTodosActivos() {
        List<Producto> lista = new ArrayList<>();
        String sql = "SELECT * FROM productos WHERE activo = TRUE ORDER BY id DESC";

        try (Connection con = ConexionBD.getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                lista.add(mapearProducto(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error al listar productos: " + e.getMessage());
        }
        return lista;
    }

    // 2. Filtrar carteras por categoría (Mano, Totes, Mochilas, Bandoleras)
    public List<Producto> listarPorCategoria(String categoria) {
        List<Producto> lista = new ArrayList<>();
        String sql = "SELECT * FROM productos WHERE categoria = ? AND activo = TRUE ORDER BY id DESC";

        try (Connection con = ConexionBD.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, categoria);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    lista.add(mapearProducto(rs));
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al filtrar productos por categoría: " + e.getMessage());
        }
        return lista;
    }

    // 3. Buscar un producto por ID (útil para la edición en el panel admin)
    public Producto obtenerPorId(int id) {
        Producto p = null;
        String sql = "SELECT * FROM productos WHERE id = ?";

        try (Connection con = ConexionBD.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    p = mapearProducto(rs);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener el producto: " + e.getMessage());
        }
        return p;
    }

    // 4. Agregar nueva mercancía
    public boolean agregar(Producto p) {
        String sql = "INSERT INTO productos (nombre, categoria, precio, precio_oferta, imagen_url, descripcion, medidas, activo) VALUES (?, ?, ?, ?, ?, ?, ?, TRUE)";

        try (Connection con = ConexionBD.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, p.getNombre());
            ps.setString(2, p.getCategoria());
            ps.setDouble(3, p.getPrecio());
            
            if (p.getPrecioOferta() != null) {
                ps.setDouble(4, p.getPrecioOferta());
            } else {
                ps.setNull(4, java.sql.Types.DECIMAL);
            }

            ps.setString(5, p.getImagenUrl());
            ps.setString(6, p.getDescripcion());
            ps.setString(7, p.getMedidas());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error al agregar producto: " + e.getMessage());
            return false;
        }
    }

    // 5. Editar datos de un modelo existente
    public boolean actualizar(Producto p) {
        String sql = "UPDATE productos SET nombre = ?, categoria = ?, precio = ?, precio_oferta = ?, imagen_url = ?, descripcion = ?, medidas = ? WHERE id = ?";

        try (Connection con = ConexionBD.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, p.getNombre());
            ps.setString(2, p.getCategoria());
            ps.setDouble(3, p.getPrecio());

            if (p.getPrecioOferta() != null) {
                ps.setDouble(4, p.getPrecioOferta());
            } else {
                ps.setNull(4, java.sql.Types.DECIMAL);
            }

            ps.setString(5, p.getImagenUrl());
            ps.setString(6, p.getDescripcion());
            ps.setString(7, p.getMedidas());
            ps.setInt(8, p.getId());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error al actualizar producto: " + e.getMessage());
            return false;
        }
    }

    // 6. Desactivar / Ocultar producto de la tienda (Baja lógica)
    public boolean cambiarEstado(int id, boolean activo) {
        String sql = "UPDATE productos SET activo = ? WHERE id = ?";

        try (Connection con = ConexionBD.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setBoolean(1, activo);
            ps.setInt(2, id);

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error al cambiar estado del producto: " + e.getMessage());
            return false;
        }
    }

    // Método auxiliar para mapear las filas de la BD al objeto Producto
    private Producto mapearProducto(ResultSet rs) throws SQLException {
        Producto p = new Producto();
        p.setId(rs.getInt("id"));
        p.setNombre(rs.getString("nombre"));
        p.setCategoria(rs.getString("categoria"));
        p.setPrecio(rs.getDouble("precio"));

        double oferta = rs.getDouble("precio_oferta");
        p.setPrecioOferta(rs.wasNull() ? null : oferta);

        p.setImagenUrl(rs.getString("imagen_url"));
        p.setDescripcion(rs.getString("descripcion"));
        p.setMedidas(rs.getString("medidas"));
        p.setActivo(rs.getBoolean("activo"));

        return p;
    }
}
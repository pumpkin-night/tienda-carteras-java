package tienda.model;

public class Producto {

    private int id;
    private String nombre;
    private String categoria;
    private double precio;
    private Double precioOferta; // Usamos Double objeto para permitir valores NULL si no hay oferta
    private String imagenUrl;
    private String descripcion;
    private String medidas;
    private boolean activo;

    // Constructor vacío
    public Producto() {
    }

    // Constructor completo
    public Producto(int id, String nombre, String categoria, double precio, Double precioOferta, String imagenUrl, String descripcion, String medidas, boolean activo) {
        this.id = id;
        this.nombre = nombre;
        this.categoria = categoria;
        this.precio = precio;
        this.precioOferta = precioOferta;
        this.imagenUrl = imagenUrl;
        this.descripcion = descripcion;
        this.medidas = medidas;
        this.activo = activo;
    }

    // Getters y Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    public double getPrecio() {
        return precio;
    }

    public void setPrecio(double precio) {
        this.precio = precio;
    }

    public Double getPrecioOferta() {
        return precioOferta;
    }

    public void setPrecioOferta(Double precioOferta) {
        this.precioOferta = precioOferta;
    }

    public String getImagenUrl() {
        return imagenUrl;
    }

    public void setImagenUrl(String imagenUrl) {
        this.imagenUrl = imagenUrl;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getMedidas() {
        return medidas;
    }

    public void setMedidas(String medidas) {
        this.medidas = medidas;
    }

    public boolean isActivo() {
        return activo;
    }

    public void setActivo(boolean activo) {
        this.activo = activo;
    }
}
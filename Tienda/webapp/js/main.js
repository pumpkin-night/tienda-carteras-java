/**
 * Función para redireccionar al chat de WhatsApp con un mensaje predeterminado.
 * @param {string} nombreProducto - Nombre del modelo de cartera.
 * @param {string} precio - Precio actual o de oferta.
 */
function contactarWhatsApp(nombreProducto, precio) {
    // Reemplaza este número con el número real de la tienda (incluyendo código de país, ej. 51 para Perú)
    const numeroTelefono = "51999999999"; 

    // Mensaje predeterminado dinámico
    const mensaje = `¡Hola WEBIA STORE! Vengo de su página web y estoy interesado/a en la cartera *${nombreProducto}* (Precio: S/ ${precio}). ¿Tienen stock disponible?`;

    // Generar enlace seguro encodeando los caracteres especiales
    const url = `https://api.whatsapp.com/send?phone=${numeroTelefono}&text=${encodeURIComponent(mensaje)}`;

    // Abrir en una nueva pestaña (en celulares abre directamente la App de WhatsApp)
    window.open(url, '_blank');
}
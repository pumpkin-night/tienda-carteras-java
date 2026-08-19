<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Satori Store | Colección de Carteras</title>
    <link rel="stylesheet" href="css/style.css">
    <!-- Iconos FontAwesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>

    <!-- Bar superior de anuncios -->
    <div class="announcement-bar">
        <span>ENVÍOS A TODO EL PAÍS | ATENCIÓN PERSONALIZADA POR WHATSAPP</span>
    </div>

    <!-- Navegación -->
    <header class="navbar">
        <div class="nav-container">
            <a href="CatalogoServlet" class="brand-logo">WEBIA STORE</a>
            <nav class="nav-links">
                <a href="CatalogoServlet">TODOS</a>
                <a href="CatalogoServlet?categoria=Mano">MANO</a>
                <a href="CatalogoServlet?categoria=Totes">TOTES</a>
                <a href="CatalogoServlet?categoria=Mochilas">MOCHILAS</a>
                <a href="CatalogoServlet?categoria=Bandoleras">BANDOLERAS</a>
            </nav>
        </div>
    </header>

    <!-- Encabezado de Colección -->
    <section class="hero-section">
        <h1 class="hero-title">COLECCIÓN DE CARTERAS</h1>
        <p class="hero-subtitle">Diseños exclusivos y acabados de alta calidad</p>
    </section>

    <!-- Filtros Rápidos -->
    <div class="categories-filter">
        <a href="CatalogoServlet" class="filter-btn active">Ver Todo</a>
        <a href="CatalogoServlet?categoria=Mano" class="filter-btn">Carteras de Mano</a>
        <a href="CatalogoServlet?categoria=Totes" class="filter-btn">Totes</a>
        <a href="CatalogoServlet?categoria=Mochilas" class="filter-btn">Mochilas</a>
        <a href="CatalogoServlet?categoria=Bandoleras" class="filter-btn">Bandoleras</a>
    </div>

    <!-- Grid de Carteras estilo Satori -->
    <main class="main-container">
        <div class="product-grid">
            <c:forEach var="p" items="${productos}">
                <article class="product-card">
                    <div class="product-image-wrapper">
                        <img src="${p.imagenUrl}" alt="${p.nombre}" class="product-image" loading="lazy">
                        <c:if test="${p.precioOferta != null && p.precioOferta < p.precio}">
                            <span class="badge-sale">OFERTA</span>
                        </c:if>
                    </div>
                    <div class="product-details">
                        <span class="product-category">${p.categoria}</span>
                        <h2 class="product-title">${p.nombre}</h2>
                        
                        <div class="price-container">
                            <c:choose>
                                <c:then test="${p.precioOferta != null && p.precioOferta < p.precio}">
                                    <span class="price-old">S/ ${p.precio}</span>
                                    <span class="price-current">S/ ${p.precioOferta}</span>
                                </c:then>
                                <c:otherwise>
                                    <span class="price-current">S/ ${p.precio}</span>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <!-- Botón WhatsApp Dinámico -->
                        <button class="btn-ws" onclick="contactarWhatsApp('${p.nombre}', '${p.precioOferta != null ? p.precioOferta : p.precio}')">
                            <i class="fa-brands fa-whatsapp"></i> Consultar
                        </button>
                    </div>
                </article>
            </c:forEach>
        </div>
    </main>

    <footer class="footer">
        <p>&copy; 2026 WEBIA STORE. Todos los derechos reservados.</p>
    </footer>

    <script src="js/main.js"></script>
</body>
</html>
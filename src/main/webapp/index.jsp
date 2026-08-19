<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    if (request.getAttribute("productos") == null) {
        response.sendRedirect(request.getContextPath() + "/CatalogoServlet");
        return;
    }
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Satori Store | Colección de Carteras</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=2">
    <!-- Iconos FontAwesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
</head>
<body>

    <!-- Bar superior de anuncios -->
    <div class="announcement-bar">
        <span>ENVÍOS A TODO EL PAÍS | ATENCIÓN PERSONALIZADA POR WHATSAPP</span>
    </div>

    <!-- Navegación -->
    <!-- Navegación con Íconos -->
<header class="navbar">
    <div class="nav-container">
        <!-- Izquierda: Menú Hamburguesa -->
        <button class="menu-toggle" id="openMenuBtn" aria-label="Abrir menú">
            <span></span>
            <span></span>
            <span></span>
        </button>

        <!-- Centro: Logo -->
        <a href="CatalogoServlet" class="brand-logo">WEBIA STORE</a>

        <!-- Derecha: Acciones / Íconos -->
        <div class="header-actions">
            <button class="icon-btn" id="openSearchBtn" aria-label="Buscar">
                <i class="fa-solid fa-magnifying-glass"></i>
            </button>
            <a href="admin.jsp" class="icon-btn" aria-label="Mi Cuenta / Iniciar Sesión">
                <i class="fa-regular fa-user"></i>
            </a>
            <button class="icon-btn cart-btn" id="openCartBtn" aria-label="Carrito de Compras">
                <i class="fa-solid fa-bag-shopping"></i>
                <span class="cart-badge" id="cartCount">0</span>
            </button>
        </div>
    </div>
</header>

<!-- Overlay y Panel Lateral de Búsqueda Estilo Satori -->
<div class="search-overlay" id="searchOverlay"></div>
<aside class="search-drawer" id="searchDrawer">
    <!-- Cabecera del Panel -->
    <div class="search-drawer-header">
        <div class="search-input-wrapper">
            <input type="text" id="searchInput" placeholder="Buscar..." autocomplete="off">
            <button type="button" id="clearSearchBtn" class="clear-search-btn">Borrar</button>
        </div>
        <button type="button" class="close-search-btn" id="closeSearchBtn" aria-label="Cerrar búsqueda">&times;</button>
    </div>

    <!-- Pestañas (Productos / Colecciones) -->
    <div class="search-tabs" id="searchTabs" style="display: none;">
        <button type="button" class="search-tab-btn active" data-tab="productsTab">Productos</button>
        <button type="button" class="search-tab-btn" data-tab="collectionsTab">Colecciones</button>
    </div>

    <!-- Contenido del Panel -->
    <div class="search-drawer-body">
        <!-- Búsquedas sugeridas cuando el input está vacío -->
        <div id="searchSuggestions" class="search-suggestions">
            <ul class="suggestion-list">
                <li><a href="CatalogoServlet?categoria=Mano">Carteras de Mano</a></li>
                <li><a href="CatalogoServlet?categoria=Totes">Totes</a></li>
                <li><a href="CatalogoServlet?categoria=Mochilas">Mochilas</a></li>
                <li><a href="CatalogoServlet?categoria=Bandoleras">Bandoleras</a></li>
            </ul>
        </div>

        <!-- Pestaña 1: Lista de Productos -->
        <div id="productsTab" class="search-tab-content active" style="display: none;">
            <div id="searchResultsList" class="search-results-list"></div>
        </div>

        <!-- Pestaña 2: Lista de Colecciones -->
        <div id="collectionsTab" class="search-tab-content" style="display: none;">
            <div id="collectionsResultsList" class="collections-results-list"></div>
        </div>
    </div>
</aside>    
    
<!-- Modal / Drawer Lateral de Tu Carrito -->
<div class="cart-overlay" id="cartOverlay"></div>
<aside class="cart-drawer" id="cartDrawer">
    <div class="cart-header">
        <h2>TU CARRITO <i class="fa-solid fa-bag-shopping"></i></h2>
        <button class="close-btn" id="closeCartBtn">&times;</button>
    </div>

    <!-- Barra de Beneficio Envío Gratis -->
    <div class="cart-shipping-bar">
        <p>Agrega <strong>S/ 180.00</strong> y tu <strong>envío va gratis</strong> 🚚</p>
    </div>

    <!-- Contenido Principal del Carrito -->
    <div class="cart-body">
        <div class="cart-empty-state" id="cartEmptyState">
            <p class="empty-title">¿List@ para transformar tu estilo?</p>
            <p class="empty-sub">Encuentra carteras exclusivas que eleven tu outfit y hazlo tuyo.</p>
            <a href="#catalogo" class="btn-explore" id="exploreBtn">Explora el Catálogo</a>
        </div>

        <div class="cart-items-list" id="cartItemsList" style="display: none;">
            <!-- Productos agregados se renderizan aquí dinámicamente -->
        </div>
    </div>

    <!-- Pie del Carrito -->
    <div class="cart-footer">
        <div class="cart-total-row">
            <span>Total:</span>
            <span id="cartTotal">S/ 0.00</span>
        </div>
        <button class="btn-checkout">Finalizar Compra</button>
    </div>
</aside>

<!-- Menú Lateral Desplegable (Off-canvas Drawer) -->
<div class="sidebar-overlay" id="sidebarOverlay"></div>
<aside class="sidebar-drawer" id="sidebarDrawer">
    
    <nav class="sidebar-nav">
        <!-- Ver Catálogo Completo (Abre la nueva pantalla dedicada catalogo.jsp) -->
<a href="CatalogoServlet?categoria=todos&vista=catalogo">
    <span>Ver Catálogo Completo</span>
</a>

<!-- Filtros por categoría (También abren catalogo.jsp con el filtro activado) -->
<a href="CatalogoServlet?categoria=Mano">
    <span>Carteras de Mano</span>
</a>
<a href="CatalogoServlet?categoria=Totes">
    <span>Totes</span>
</a>
<a href="CatalogoServlet?categoria=Mochilas">
    <span>Mochilas</span>
</a>
<a href="CatalogoServlet?categoria=Bandoleras">
    <span>Bandoleras</span>
</a>
        <!-- CÓDIGO CORRECTO -->
<a href="nosotros.jsp">
    <span>Nosotros</span>
</a>
    </nav>
    
    <div class="sidebar-footer">
        <div class="sidebar-socials">
            <a href="#" class="social-icon"><i class="bx bxl-instagram"></i></a>
            <a href="#" class="social-icon"><i class="bx bxl-tiktok"></i></a>
        </div>
        <div class="footer-divider"></div>
        <a href="#" class="sidebar-account-link">Cuenta</a>
    </div>
</aside>

<!-- Hero Banner Carrusel -->
<section class="hero-slider">
    <!-- Slide 1 -->
    <div class="slide active">
        <img src="assets/images/porta1.jpg" alt="Colección Principal" class="slide-bg">
        <div class="slide-overlay"></div>
        <div class="hero-content">
            <h1>ELEVA TU ESTILO</h1>
            <p>Diseños exclusivos y acabados de alta calidad</p>
            <a href="#catalogo" class="btn-hero">Ver Todo</a>
        </div>
    </div>

    <!-- Slide 2 -->
    <div class="slide">
        <img src="assets/images/porta2.jpg" alt="Nueva Temporada" class="slide-bg">
        <div class="slide-overlay"></div>
        <div class="hero-content">
            <h1>NUEVA COLECCIÓN</h1>
            <p>Descubre lo último en tendencia e-commerce</p>
            <a href="#catalogo" class="btn-hero">Ver Todo</a>
        </div>
    </div>

    <!-- Indicadores (Puntitos abajo) -->
    <div class="slider-dots">
        <span class="dot active"></span>
        <span class="dot"></span>
    </div>
    
    <!-- Flechas de navegación lateral -->
<button class="slider-arrow prev" id="prevSlide" aria-label="Anterior">&#10094;</button>
<button class="slider-arrow next" id="nextSlide" aria-label="Siguiente">&#10095;</button>
</section>

<!-- BANNER DE BENEFICIOS / FEATURES BAR -->
<section class="features-bar">
    <div class="features-container">
        <!-- Beneficio 1 -->
        <div class="feature-item">
            <i class="fa-solid fa-truck-fast feature-icon"></i>
            <div class="feature-text">
                <h4>Envío 24-48h</h4>
                <p>Lima Metropolitana</p>
            </div>
        </div>

        <!-- Beneficio 2 -->
        <div class="feature-item">
            <i class="fa-solid fa-rotate-left feature-icon"></i>
            <div class="feature-text">
                <h4>Cambios fáciles</h4>
                <p>Hasta 30 días</p>
            </div>
        </div>

        <!-- Beneficio 3 -->
        <div class="feature-item">
            <i class="fa-solid fa-credit-card feature-icon"></i>
            <div class="feature-text">
                <h4>Hasta 6 cuotas</h4>
                <p>Sin intereses</p>
            </div>
        </div>

        <!-- Beneficio 4 -->
        <div class="feature-item">
            <i class="fa-solid fa-star feature-icon"></i>
            <div class="feature-text">
                <h4>4.9 / 5</h4>
                <p>+450 reseñas</p>
            </div>
        </div>
    </div>
</section>

    <!-- Encabezado de Colección -->
    <section class="hero-section">
        <h1 class="hero-title">COLECCIÓN DE CARTERAS</h1>
        <p class="hero-subtitle">Diseños exclusivos y acabados de alta calidad</p>
    </section>

    <!-- Filtros Rápidos -->
    <section id="catalogo" class="categories-filter">
    <button class="filter-btn active" data-category="todos">Ver Todo</button>
    <!-- Usa "Mano" si en las tarjetas viene como Mano -->
    <button class="filter-btn" data-category="Mano">Carteras de Mano</button>
    <button class="filter-btn" data-category="Totes">Totes</button>
    <button class="filter-btn" data-category="Mochilas">Mochilas</button>
    <button class="filter-btn" data-category="Bandoleras">Bandoleras</button>
</section>

    <!-- Grid de Carteras estilo Satori -->
<main class="main-container">
    <div class="product-grid" id="productGrid">
        <c:choose>
            <c:when test="${not empty productos}">
                <c:forEach var="p" items="${productos}">
                    <article class="product-card" data-category="${p.categoria}">
                        
                        <!-- Enlace en la Imagen -->
                        <a href="ProductoDetalleServlet?id=${p.id}" class="product-link">
                            <div class="product-image-wrapper">
                                <img src="${pageContext.request.contextPath}/${p.imagenUrl}"alt="${p.nombre}" class="product-image" loading="lazy">
                                <c:if test="${p.precioOferta != null && p.precioOferta < p.precio}">
                                    <span class="badge-sale">OFERTA</span>
                                </c:if>
                            </div>
                        </a>

                        <div class="product-details">
                            <span class="product-category">${p.categoria}</span>
                            
                            <!-- Enlace en el Nombre -->
                            <h2 class="product-title">
                                <a href="ProductoDetalleServlet?id=${p.id}">${p.nombre}</a>
                            </h2>
                            
                            <div class="price-container">
                                <c:choose>
                                    <c:when test="${p.precioOferta != null && p.precioOferta < p.precio}">
                                        <span class="price-old">S/ ${p.precio}</span>
                                        <span class="price-current">S/ ${p.precioOferta}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="price-current">S/ ${p.precio}</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <!-- Botón Añadir al Carrito -->
                            <button class="btn-add-cart" 
                                    data-id="${p.id}" 
                                    data-nombre="${p.nombre}" 
                                    data-precio="${p.precioOferta != null ? p.precioOferta : p.precio}" 
                                    data-imagen="${p.imagenUrl}">
                                <i class="fa-solid fa-bag-shopping"></i> Añadir al Carrito
                            </button>
                        </div>
                    </article>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div style="grid-column: 1 / -1; text-align: center; padding: 40px; color: #888;">
                    <p>No hay productos disponibles por el momento.</p>
                </div>
            </c:otherwise>
        </c:choose>

        <div id="noProductsMessage" style="display: none; grid-column: 1 / -1; text-align: center; padding: 40px; color: #888;">
            <p>No se encontraron productos en esta categoría.</p>
        </div>
    </div>
</main>
    
    <!-- Botón Flotante de WhatsApp -->
<a href="https://api.whatsapp.com/send?phone=51992079644&text=%C2%A1Hola%20WEBIA%20STORE!%20Tengo%20una%20consulta." 
   class="whatsapp-float-btn" 
   target="_blank" 
   rel="noopener noreferrer" 
   aria-label="Escríbenos por WhatsApp">
    <i class="fa-brands fa-whatsapp"></i>
    <span>Escríbenos</span>
</a>

   <!-- Footer Estilo Satori -->
<footer class="site-footer">
    <div class="footer-container">
        <!-- Columna Izquierda: Suscripción, Libro de Reclamaciones y Redes -->
        <div class="footer-col footer-col-subscribe">
            <h3 class="footer-title">Suscríbete</h3>
            <p class="footer-subtitle">Entérate de nuestros últimos productos y promociones</p>
            
            <form class="newsletter-form" onsubmit="event.preventDefault();">
                <input type="email" placeholder="Correo electrónico" required>
                <button type="submit" aria-label="Suscribirse">
                    <i class="fa-solid fa-chevron-right"></i>
                </button>
            </form>

            <a href="#" class="reclamaciones-btn">
                <i class="fa-solid fa-book-open"></i>
                <span>LIBRO DE RECLAMACIONES</span>
            </a>

            <div class="footer-socials">
                <a href="#" aria-label="Facebook"><i class="fa-brands fa-facebook-f"></i></a>
                <a href="#" aria-label="Instagram"><i class="fa-brands fa-instagram"></i></a>
                <a href="#" aria-label="TikTok"><i class="fa-brands fa-tiktok"></i></a>
            </div>
        </div>

        <!-- Columna Central: Compañía -->
        <div class="footer-col">
            <h4 class="footer-heading">Compañía</h4>
            <ul class="footer-links">
                <li><a href="#">Nosotros</a></li>
                <li><a href="#">Trabaja con nosotros</a></li>
                <li><a href="#">Contacto</a></li>
                <li><a href="#">Blog</a></li>
            </ul>
        </div>

        <!-- Columna Derecha: Ayuda al cliente -->
        <div class="footer-col">
            <h4 class="footer-heading">Ayuda al cliente</h4>
            <ul class="footer-links">
                <li><a href="#">Tiempos de Envío</a></li>
                <li><a href="#">Políticas de privacidad</a></li>
                <li><a href="#">Políticas de cambios</a></li>
                <li><a href="#">Políticas de envío</a></li>
                <li><a href="#">Términos y condiciones</a></li>
            </ul>
        </div>
    </div>

    <!-- Sub-footer: Métodos de Pago y Copyright -->
    <div class="footer-bottom">
        <div class="payment-methods">
            <i class="fa-brands fa-cc-visa"></i>
            <i class="fa-brands fa-cc-mastercard"></i>
            <i class="fa-brands fa-cc-amex"></i>
            <i class="fa-brands fa-cc-diners-club"></i>
        </div>
        <p class="copyright-text">WEBIA STORE 2026 © Todos los derechos reservados</p>
    </div>
</footer>

    <script src="${pageContext.request.contextPath}/js/main.js?v=3"></script>
</body>
</html>
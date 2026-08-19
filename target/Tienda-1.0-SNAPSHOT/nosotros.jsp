<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sobre Nosotros - WEBIA STORE</title>
    
    <!-- Estilos base y de la sección nosotros -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
     <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=2">
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
    <!-- HERO / BANNER PRINCIPAL (Estilo Satori369) -->
    <section class="about-hero">
        <div class="hero-overlay"></div>
        <div class="hero-content">
            <span class="sub-title">Sobre Nosotros</span>
            <h1 class="main-title">Nuestra Razón de Ser</h1>
            <p class="hero-description">
                Creando accesorios y piezas exclusivas que inspiran comodidad, estética y estilo único en tu día a día.
            </p>
        </div>
    </section>

    <!-- SECCIÓN DE TEXTO / HISTORIA -->
    <section class="about-story-container">
        <div class="story-content">
            <p>
                En <strong>WEBIA STORE</strong>, creemos que los accesorios que te acompañan a diario no solo deben ser funcionales, sino también inspiradores, estéticos y, sobre todo, reflejar tu personalidad.
            </p>
            <p>
                Pasamos mucho tiempo moviéndonos entre el trabajo, los estudios y la rutina diaria. Encontrar piezas con acabados de alta calidad y un diseño bien pensado nos motiva a mantener una presencia con estilo y confianza a lo largo del día.
            </p>
        </div>
    </section>

    <!-- SECCIÓN INSPIRACIÓN (Grid o Bloque destacado) -->
    <section class="about-inspiration-container">
        <h2 class="section-title">La Inspiración Detrás de WEBIA STORE</h2>
        <div class="inspiration-grid">
            <div class="inspiration-card">
                <h3>Diseños Exclusivos</h3>
                <p>Seleccionamos cuidadosamente cada textura y acabado para ofrecer colecciones únicas y duraderas.</p>
            </div>
            <div class="inspiration-card">
                <h3>Atención al Detalle</h3>
                <p>Desde la costura hasta el empaque, cuidamos cada elemento para brindarte la mejor experiencia.</p>
            </div>
        </div>
    </section>

    <!-- SECCIÓN DE BENEFICIOS / GARANTÍAS (ESTILO SATORI) -->
<section class="benefits-section">
    <div class="benefits-container" id="benefitsContainer">
        
        <!-- Beneficio 1 -->
        <div class="benefit-card">
            <div class="benefit-icon">
                <i class="fa-solid fa-box"></i>
            </div>
            <h3>Envíos a todo el Perú</h3>
            <p>Preparamos tus productos en el menor tiempo posible</p>
        </div>

        <!-- Beneficio 2 -->
        <div class="benefit-card">
            <div class="benefit-icon">
                <i class="fa-solid fa-headset"></i>
            </div>
            <h3>Ayuda personalizada</h3>
            <p>Atendemos tus necesidades y te asesoramos en todo</p>
        </div>

        <!-- Beneficio 3 -->
        <div class="benefit-card">
            <div class="benefit-icon">
                <i class="fa-solid fa-gem"></i>
            </div>
            <h3>Alta calidad</h3>
            <p>Trabajamos con los mejores materiales y acabados</p>
        </div>

        <!-- Beneficio 4 -->
        <div class="benefit-card">
            <div class="benefit-icon">
                <i class="fa-solid fa-lock"></i>
            </div>
            <h3>Compra segura</h3>
            <p>Protegemos tus datos de privacidad y pago</p>
        </div>

    </div>

    <!-- PUNTOS (DOTS) SOLO VISIBLES EN CELULAR -->
    <div class="benefits-dots" id="benefitsDots">
        <span class="dot active"></span>
        <span class="dot"></span>
        <span class="dot"></span>
        <span class="dot"></span>
    </div>
</section>

<!-- SCRIPT PARA EL CAMBIO AUTOMÁTICO Y DOTS EN MÓVIL -->
<script>
    const container = document.getElementById('benefitsContainer');
    const dots = document.querySelectorAll('#benefitsDots .dot');
    let currentIndex = 0;
    let autoSlideInterval;

    function updateDots(index) {
        dots.forEach((dot, i) => {
            dot.classList.toggle('active', i === index);
        });
    }

    function scrollToIndex(index) {
        const cardWidth = container.querySelector('.benefit-card').offsetWidth;
        container.scrollTo({
            left: cardWidth * index,
            behavior: 'smooth'
        });
        updateDots(index);
    }

    // Detectar scroll manual con el dedo en celular
    container.addEventListener('scroll', () => {
        const cardWidth = container.querySelector('.benefit-card').offsetWidth;
        if (cardWidth > 0) {
            const index = Math.round(container.scrollLeft / cardWidth);
            if (index !== currentIndex && index < dots.length) {
                currentIndex = index;
                updateDots(currentIndex);
            }
        }
    });

    // Auto-rotación en celulares cada 3.5 segundos
    function startAutoSlide() {
        autoSlideInterval = setInterval(() => {
            if (window.innerWidth <= 768) {
                currentIndex = (currentIndex + 1) % dots.length;
                scrollToIndex(currentIndex);
            }
        }, 3500);
    }

    startAutoSlide();
</script>
    
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
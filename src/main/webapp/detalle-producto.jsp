<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${producto.nombre} - WEBIA STORE</title>
    
    <!-- CSS Principal global -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css?v=1.1">
    
    <!-- Iconos FontAwesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">

    <!-- Estilos específicos aislados para el Detalle del Producto -->
    <style>
        .product-detail-container {
            max-width: 1100px;
            margin: 40px auto;
            padding: 0 20px;
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 40px;
            align-items: start;
        }

        .product-detail-container .product-media {
            width: 100%;
            background-color: #f8f8f8;
            border-radius: 12px;
            overflow: hidden;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .product-detail-container .product-media img {
            width: 100%;
            max-height: 500px;
            object-fit: cover;
            display: block;
        }

        .product-detail-container .product-info-panel {
            display: flex;
            flex-direction: column;
            gap: 14px;
        }

        .product-detail-container .rating-box {
            display: flex;
            align-items: center;
            gap: 4px;
            color: #ffc107;
            font-size: 0.9rem;
        }

        .product-detail-container .product-title {
            font-size: 1.8rem;
            font-weight: 700;
            color: #111;
            margin: 0;
        }

        .product-detail-container .price-box {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-top: 5px;
        }

        .product-detail-container .current-price {
            font-size: 1.6rem;
            font-weight: 700;
            color: #111;
        }

        .product-detail-container .old-price {
            font-size: 1.1rem;
            color: #888;
            text-decoration: line-through;
        }

        .product-detail-container .discount-badge {
            background-color: #ff3b30;
            color: #fff;
            font-size: 0.75rem;
            font-weight: 700;
            padding: 3px 8px;
            border-radius: 4px;
        }

        .product-detail-container .quantity-section {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .product-detail-container .quantity-controls {
            display: flex;
            align-items: center;
            border: 1px solid #ddd;
            border-radius: 6px;
            overflow: hidden;
        }

        .product-detail-container .quantity-controls button {
            background: #f4f4f4;
            border: none;
            width: 36px;
            height: 36px;
            font-size: 1.1rem;
            cursor: pointer;
        }

        .product-detail-container .quantity-controls input {
            width: 45px;
            height: 36px;
            border: none;
            text-align: center;
            font-size: 0.95rem;
            font-weight: 600;
        }

        .product-detail-container .btn-add-to-cart-lg {
            width: 100%;
            padding: 14px;
            background-color: #000;
            color: #fff;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
        }

        .product-detail-container .btn-buy-whatsapp {
            width: 100%;
            padding: 12px 16px;
            background-color: #25d366;
            color: #fff;
            border: none;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
            cursor: pointer;
        }

        @media (max-width: 768px) {
            .product-detail-container {
                grid-template-columns: 1fr;
                gap: 24px;
            }
        }
        
        .product-specifications {
    border-top: 1px solid #e5e5e5;
    border-bottom: 1px solid #e5e5e5;
    padding: 16px 0;
    margin: 5px 0;
}

.specification-item {
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 20px;
}

.specification-label {
    font-weight: 600;
    color: #333;
}

.specification-value {
    color: #666;
}
    </style>
</head>
<body>

    <!-- Bar superior de anuncios -->
    <div class="announcement-bar">
        <span>ENVÍOS A TODO EL PAÍS | ATENCIÓN PERSONALIZADA POR WHATSAPP</span>
    </div>

    <!-- Navegación con Íconos -->
    <header class="navbar">
        <div class="nav-container">
            <button class="menu-toggle" id="openMenuBtn" aria-label="Abrir menú">
                <span></span>
                <span></span>
                <span></span>
            </button>

            <a href="CatalogoServlet" class="brand-logo">WEBIA STORE</a>

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

    <!-- Overlay y Panel Lateral de Búsqueda -->
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
    
    <!-- Modal / Drawer Lateral de Tu Carrito -->
    <div class="cart-overlay" id="cartOverlay"></div>
    <aside class="cart-drawer" id="cartDrawer">
        <div class="cart-header">
            <h2>TU CARRITO <i class="fa-solid fa-bag-shopping"></i></h2>
            <button class="close-btn" id="closeCartBtn">&times;</button>
        </div>

        <div class="cart-shipping-bar">
            <p>Agrega <strong>S/ 180.00</strong> y tu <strong>envío va gratis</strong> 🚚</p>
        </div>

        <div class="cart-body">
            <div class="cart-empty-state" id="cartEmptyState">
                <p class="empty-title">¿List@ para transformar tu estilo?</p>
                <p class="empty-sub">Encuentra carteras exclusivas que eleven tu outfit y hazlo tuyo.</p>
                <a href="CatalogoServlet#catalogo" class="btn-explore" id="exploreBtn">Explora el Catálogo</a>
            </div>

            <div class="cart-items-list" id="cartItemsList" style="display: none;"></div>
        </div>

        <div class="cart-footer">
            <div class="cart-total-row">
                <span>Total:</span>
                <span id="cartTotal">S/ 0.00</span>
            </div>
            <button class="btn-checkout">Finalizar Compra</button>
        </div>
    </aside>

    <!-- Menú Lateral Desplegable -->
    <div class="sidebar-overlay" id="sidebarOverlay"></div>
    <aside class="sidebar-drawer" id="sidebarDrawer">
        <div class="sidebar-header">
            <button class="close-btn" id="closeMenuBtn">&times;</button>
        </div>
        <nav class="sidebar-nav">
            <a href="CatalogoServlet">Ver Catálogo Completo</a>
            <a href="CatalogoServlet?categoria=Mano">Carteras de Mano</a>
            <a href="CatalogoServlet?categoria=Totes">Totes</a>
            <a href="CatalogoServlet?categoria=Mochilas">Mochilas</a>
            <a href="CatalogoServlet?categoria=Bandoleras">Bandoleras</a>
            <a href="nosotros.jsp">
    <span>Nosotros</span>
</a>
        </nav>
    </aside>

    <!-- Contenido Principal: Detalle de Producto -->
    <main class="product-detail-container">
        <!-- Galería / Imagen Izquierda -->
        <div class="product-media">
            <img src="${pageContext.request.contextPath}/${producto.imagenUrl}" alt="${producto.nombre}" id="mainProductImage"> 
        </div>

        <!-- Información del Producto Derecha -->
        <div class="product-info-panel">
            <div class="rating-box">
                <i class="fa-solid fa-star"></i>
                <i class="fa-solid fa-star"></i>
                <i class="fa-solid fa-star"></i>
                <i class="fa-solid fa-star"></i>
                <i class="fa-regular fa-star"></i>
                <span>(8)</span>
            </div>

            <h1 class="product-title">${producto.nombre}</h1>
            <p class="product-short-desc">${producto.descripcion}</p>
            
            <div class="product-specifications">
    <div class="specification-item">
        <span class="specification-label">Medidas</span>
        <span class="specification-value">${producto.medidas}</span>
    </div>
</div>

            <div class="price-box">
                <span class="current-price">S/. ${producto.precioOferta != null ? producto.precioOferta : producto.precio}</span>
                <c:if test="${producto.precioOferta != null}">
                    <span class="old-price">S/. ${producto.precio}</span>
                    <span class="discount-badge">Oferta</span>
                </c:if>
            </div>

            <!-- Selector de Cantidad -->
            <div class="quantity-section">
                <label>Cantidad:</label>
                <div class="quantity-controls">
                    <button type="button" onclick="decrementQty()">-</button>
                    <input type="number" id="productQty" value="1" min="1" readonly>
                    <button type="button" onclick="incrementQty()">+</button>
                </div>
            </div>

            <div class="stock-status">
                <i class="fa-solid fa-check"></i> Disponible
            </div>

            <!-- Botones de Acción -->
            <div class="action-buttons">
                <button class="btn-add-to-cart-lg" 
                        onclick="agregarConCantidad('${producto.id}', '${producto.nombre}', '${producto.precioOferta != null ? producto.precioOferta : producto.precio}', '${producto.imagenUrl}')">
                    Añadir al Carrito
                </button>

                <button class="btn-buy-whatsapp" 
                        onclick="contactarWhatsApp('${producto.nombre}', '${producto.precioOferta != null ? producto.precioOferta : producto.precio}')">
                    <i class="fa-brands fa-whatsapp"></i>
                    <div>
                        <strong>Compra por WhatsApp</strong>
                        <span>Paga al recibir en Lima</span>
                    </div>
                </button>
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

    <!-- Footer -->
    <footer class="site-footer">
        <div class="footer-container">
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

            <div class="footer-col">
                <h4 class="footer-heading">Compañía</h4>
                <ul class="footer-links">
                    <li><a href="#">Nosotros</a></li>
                    <li><a href="#">Trabaja con nosotros</a></li>
                    <li><a href="#">Contacto</a></li>
                    <li><a href="#">Blog</a></li>
                </ul>
            </div>

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

    <!-- Scripts -->
    <!-- Control de cantidad y funciones del carrito -->
    <script>
        function incrementQty() {
            const qtyInput = document.getElementById('productQty');
            if (qtyInput) qtyInput.value = parseInt(qtyInput.value || 1) + 1;
        }

        function decrementQty() {
            const qtyInput = document.getElementById('productQty');
            if (qtyInput && parseInt(qtyInput.value) > 1) {
                qtyInput.value = parseInt(qtyInput.value) - 1;
            }
        }

        function agregarConCantidad(id, nombre, precio, imagen) {
            const qtyInput = document.getElementById('productQty');
            const qty = qtyInput ? parseInt(qtyInput.value) : 1;
            
            if (typeof addToCart === 'function') {
                addToCart(id, nombre, precio, imagen, qty);
            } else {
                console.error("La función addToCart no está disponible. Verifica main.js.");
            }
        }

        function contactarWhatsApp(nombre, precio) {
            const qtyInput = document.getElementById('productQty');
            const qty = qtyInput ? parseInt(qtyInput.value) : 1;
            const mensaje = encodeURIComponent(`¡Hola WEBIA STORE! Me interesa comprar ${qty} unidad(es) de ${nombre} a S/. ${precio} cada una.`);
            window.open(`https://api.whatsapp.com/send?phone=51992079644&text=${mensaje}`, '_blank');
        }
    </script>

    <!-- Archivo JS principal -->
    <script src="${pageContext.request.contextPath}/js/main.js?v=3"></script>
</body>
</html>
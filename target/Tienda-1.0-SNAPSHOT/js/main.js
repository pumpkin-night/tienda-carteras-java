/**
 * Función para redireccionar al chat de WhatsApp con un mensaje predeterminado.
 * @param {string} nombreProducto - Nombre del modelo de cartera/producto.
 * @param {string} precio - Precio actual o de oferta.
 */
function contactarWhatsApp(nombreProducto, precio) {
    const numeroTelefono = "51992079644"; 
    const mensaje = `¡Hola WEBIA STORE! Vengo de su página web y estoy interesado/a en *${nombreProducto}* (Precio: S/ ${precio}). ¿Tienen stock disponible?`;
    const url = `https://api.whatsapp.com/send?phone=${numeroTelefono}&text=${encodeURIComponent(mensaje)}`;
    window.open(url, '_blank');
}

/* ==========================================================================
   GESTIÓN DEL CARRITO DE COMPRAS CON PERSISTENCIA (localStorage)
   ========================================================================== */
let cart = [];

// Normalizar la ruta de la imagen sin duplicar el Context Path
function resolverRutaImagen(url) {
    if (!url) return '';
    if (url.startsWith('http')) return url;
    
    const pathSegments = window.location.pathname.split('/');
    const contextPath = pathSegments.length > 1 && pathSegments[1] ? '/' + pathSegments[1] : '';

    // Si la URL ya empieza con el Context Path, se deja intacta
    if (contextPath && url.startsWith(contextPath)) {
        return url;
    }
    
    // Si empieza con '/', se le antepone el contextPath
    return url.startsWith('/') ? `${contextPath}${url}` : `${contextPath}/${url}`;
}

// Cargar carrito guardado en el navegador
function loadCart() {
    const savedCart = localStorage.getItem("webia_cart");
    if (savedCart) {
        try {
            cart = JSON.parse(savedCart);
        } catch (e) {
            cart = [];
        }
    }
    updateCartUI();
}

// Guardar estado actual del carrito
function saveCart() {
    localStorage.setItem("webia_cart", JSON.stringify(cart));
    updateCartUI();
}

function updateCartUI() {
    const cartCountEl = document.getElementById("cartCount");
    const cartItemsList = document.getElementById("cartItemsList");
    const cartEmptyState = document.getElementById("cartEmptyState");
    const cartTotalEl = document.getElementById("cartTotal");

    // Cantidad total de ítems
    const totalItems = cart.reduce((sum, item) => sum + item.quantity, 0);
    if (cartCountEl) cartCountEl.textContent = totalItems;

    // Suma total
    const totalPrice = cart.reduce((sum, item) => sum + (item.precio * item.quantity), 0);
    if (cartTotalEl) cartTotalEl.textContent = `S/ ${totalPrice.toFixed(2)}`;

    // Renderizado dinámico de estado
    if (cart.length === 0) {
        if (cartEmptyState) cartEmptyState.style.display = "block";
        if (cartItemsList) {
            cartItemsList.style.display = "none";
            cartItemsList.innerHTML = "";
        }
    } else {
        if (cartEmptyState) cartEmptyState.style.display = "none";
        if (cartItemsList) {
            cartItemsList.style.display = "block";
            cartItemsList.innerHTML = cart.map(item => `
                <div class="cart-item">
                    <img src="${resolverRutaImagen(item.imagen)}" alt="${item.nombre}" class="cart-item-img">
                    <div class="cart-item-details">
                        <h4 class="cart-item-title">${item.nombre}</h4>
                        <span class="cart-item-price">Cant: ${item.quantity} x S/ ${Number(item.precio).toFixed(2)}</span>
                    </div>
                    <button class="cart-item-remove" onclick="removeFromCart('${item.id}')" aria-label="Eliminar producto">
                        <i class="fa-solid fa-trash-can"></i>
                    </button>
                </div>
            `).join("");
        }
    }
}

function addToCart(id, nombre, precio, imagen, quantity = 1) {
    const idStr = String(id); // Normaliza el ID a String para evitar fallas de comparación
    const existingItem = cart.find(item => String(item.id) === idStr);
    const parsedQty = parseInt(quantity) || 1;

    if (existingItem) {
        existingItem.quantity += parsedQty;
    } else {
        cart.push({
            id: idStr,
            nombre: nombre,
            precio: parseFloat(precio) || 0,
            imagen: imagen,
            quantity: parsedQty
        });
    }

    saveCart(); // Guarda cambios en localStorage y actualiza UI
    openCart(); // Abre el panel lateral al añadir
}

function removeFromCart(id) {
    const idStr = String(id);
    cart = cart.filter(item => String(item.id) !== idStr);
    saveCart(); // Guarda cambios y actualiza UI
}

/* ==========================================================================
   MODAL Y DRAWER LATERAL DEL CARRITO
   ========================================================================== */
function openCart() {
    const cartDrawer = document.getElementById("cartDrawer");
    const cartOverlay = document.getElementById("cartOverlay");
    if (cartDrawer && cartOverlay) {
        cartDrawer.classList.add("open");
        cartOverlay.classList.add("active");
    }
}

function closeCart() {
    const cartDrawer = document.getElementById("cartDrawer");
    const cartOverlay = document.getElementById("cartOverlay");
    if (cartDrawer && cartOverlay) {
        cartDrawer.classList.remove("open");
        cartOverlay.classList.remove("active");
    }
}

/* ==========================================================================
   EVENTOS DOM CONTENT LOADED
   ========================================================================== */
document.addEventListener("DOMContentLoaded", () => {
    // Inicializar y cargar carrito persistente
    loadCart();

    // 1. Menú Off-Canvas
    const openMenuBtn = document.getElementById("openMenuBtn");
    const closeMenuBtn = document.getElementById("closeMenuBtn");
    const sidebarDrawer = document.getElementById("sidebarDrawer");
    const sidebarOverlay = document.getElementById("sidebarOverlay");

    function openMenu() {
        if (sidebarDrawer && sidebarOverlay) {
            sidebarDrawer.classList.add("open");
            sidebarOverlay.classList.add("active");
        }
    }

    function closeMenu() {
        if (sidebarDrawer && sidebarOverlay) {
            sidebarDrawer.classList.remove("open");
            sidebarOverlay.classList.remove("active");
        }
    }

    if (openMenuBtn) openMenuBtn.addEventListener("click", openMenu);
    if (closeMenuBtn) closeMenuBtn.addEventListener("click", closeMenu);
    if (sidebarOverlay) sidebarOverlay.addEventListener("click", closeMenu);

    // 2. Eventos Abrir/Cerrar Carrito
    const openCartBtn = document.getElementById("openCartBtn");
    const closeCartBtn = document.getElementById("closeCartBtn");
    const cartOverlay = document.getElementById("cartOverlay");
    const exploreBtn = document.getElementById("exploreBtn");

    if (openCartBtn) openCartBtn.addEventListener("click", openCart);
    if (closeCartBtn) closeCartBtn.addEventListener("click", closeCart);
    if (cartOverlay) cartOverlay.addEventListener("click", closeCart);
    if (exploreBtn) exploreBtn.addEventListener("click", closeCart);

    // 3. Evento Añadir al Carrito (desde tarjetas de catálogo)
    document.querySelectorAll(".btn-add-cart").forEach(btn => {
        btn.addEventListener("click", (e) => {
            e.preventDefault();
            const button = e.currentTarget;
            const id = button.getAttribute("data-id");
            const nombre = button.getAttribute("data-nombre");
            const precio = button.getAttribute("data-precio");
            const imagen = button.getAttribute("data-imagen");

            addToCart(id, nombre, precio, imagen);
        });
    });

    // 4. Filtrado de productos por categoría
    const filterBtns = document.querySelectorAll('.filter-btn');
    const productCards = document.querySelectorAll('.product-card');
    const noProductsMsg = document.getElementById('noProductsMessage');

    filterBtns.forEach(btn => {
        btn.addEventListener('click', (e) => {
            e.preventDefault();

            filterBtns.forEach(b => b.classList.remove('active'));
            btn.classList.add('active');

            const selectedCategory = btn.getAttribute('data-category').trim().toLowerCase();
            let visibleCount = 0;

            productCards.forEach(card => {
                const cardCategory = (card.getAttribute('data-category') || '').trim().toLowerCase();

                if (selectedCategory === 'todos' || cardCategory === selectedCategory || cardCategory.includes(selectedCategory)) {
                    card.style.display = 'flex';
                    visibleCount++;
                } else {
                    card.style.display = 'none';
                }
            });

            if (noProductsMsg) {
                noProductsMsg.style.display = (visibleCount === 0) ? 'block' : 'none';
            }
        });
    });

    // 5. Hero Banner Carrusel
    const slides = document.querySelectorAll(".slide");
    const dots = document.querySelectorAll(".dot");
    const prevBtn = document.getElementById("prevSlide");
    const nextBtn = document.getElementById("nextSlide");

    let currentSlide = 0;
    const slideInterval = 5000;
    let timer;

    function showSlide(index) {
        slides.forEach((slide, i) => {
            slide.classList.remove("active");
            if (dots[i]) dots[i].classList.remove("active");
        });

        if (slides[index]) slides[index].classList.add("active");
        if (dots[index]) dots[index].classList.add("active");
    }

    function nextSlide() {
        if (slides.length === 0) return;
        currentSlide = (currentSlide + 1) % slides.length;
        showSlide(currentSlide);
    }

    function prevSlide() {
        if (slides.length === 0) return;
        currentSlide = (currentSlide - 1 + slides.length) % slides.length;
        showSlide(currentSlide);
    }

    function startTimer() {
        clearInterval(timer);
        timer = setInterval(nextSlide, slideInterval);
    }

    if (slides.length > 0) {
        startTimer();

        if (nextBtn) {
            nextBtn.addEventListener("click", () => {
                nextSlide();
                startTimer();
            });
        }

        if (prevBtn) {
            prevBtn.addEventListener("click", () => {
                prevSlide();
                startTimer();
            });
        }

        dots.forEach((dot, index) => {
            dot.addEventListener("click", () => {
                currentSlide = index;
                showSlide(currentSlide);
                startTimer();
            });
        });
    }
});

// ==========================================
// CONTROL DEL PANEL DE BÚSQUEDA DINÁMICO (CORREGIDO)
// ==========================================
document.addEventListener('DOMContentLoaded', () => {
    const openSearchBtn = document.getElementById('openSearchBtn');
    const closeSearchBtn = document.getElementById('closeSearchBtn');
    const searchOverlay = document.getElementById('searchOverlay');
    const searchDrawer = document.getElementById('searchDrawer');
    const searchInput = document.getElementById('searchInput');
    const clearSearchBtn = document.getElementById('clearSearchBtn');
    
    const searchTabs = document.getElementById('searchTabs');
    const searchSuggestions = document.getElementById('searchSuggestions');
    const productsTab = document.getElementById('productsTab');
    const collectionsTab = document.getElementById('collectionsTab');
    
    const searchResultsList = document.getElementById('searchResultsList');
    const collectionsResultsList = document.getElementById('collectionsResultsList');
    const tabButtons = document.querySelectorAll('.search-tab-btn');

    let debounceTimer;

    function openSearch() {
    if (!searchOverlay || !searchDrawer) return;

    searchOverlay.classList.add('active');
    searchDrawer.classList.add('active');

    if (searchInput) {
        setTimeout(() => {
            searchInput.focus();
        }, 150);
    }
}

function closeSearch() {
    if (!searchOverlay || !searchDrawer) return;

    searchDrawer.classList.remove('active');
    searchOverlay.classList.remove('active');

    if (searchInput) {
        searchInput.blur();
    }
}

    // Eventos de apertura y cierre
    if (openSearchBtn) {
        openSearchBtn.addEventListener('click', (e) => {
            e.preventDefault();
            openSearch();
        });
    }

    if (closeSearchBtn) {
        closeSearchBtn.addEventListener('click', (e) => {
            e.preventDefault();
            closeSearch();
        });
    }

    if (searchOverlay) {
        searchOverlay.addEventListener('click', (e) => {
            e.preventDefault();
            closeSearch();
        });
    }

    // Tecla Escape para cerrar
    document.addEventListener('keydown', (e) => {
        if (e.key === 'Escape') {
            closeSearch();
        }
    });

    // Botón Borrar Input
    if (clearSearchBtn) {
        clearSearchBtn.addEventListener('click', () => {
            if (searchInput) {
                searchInput.value = '';
                searchInput.focus();
            }
            toggleSearchState('');
        });
    }

    // Control del Input de Búsqueda
    searchInput?.addEventListener('input', (e) => {
        const query = e.target.value.trim();
        
        clearTimeout(debounceTimer);
        toggleSearchState(query);

        if (query.length > 0) {
            debounceTimer = setTimeout(() => {
                ejecutarBusqueda(query);
            }, 250);
        }
    });

    // Alternar visibilidad entre Sugerencias y Resultados
    function toggleSearchState(query) {
        if (query.length > 0) {
            if (clearSearchBtn) clearSearchBtn.style.display = 'block';
            if (searchSuggestions) searchSuggestions.style.display = 'none';
            if (searchTabs) searchTabs.style.display = 'flex';
            
            const activeTab = document.querySelector('.search-tab-btn.active')?.dataset.tab || 'productsTab';
            showTab(activeTab);
        } else {
            if (clearSearchBtn) clearSearchBtn.style.display = 'none';
            if (searchSuggestions) searchSuggestions.style.display = 'block';
            if (searchTabs) searchTabs.style.display = 'none';
            if (productsTab) productsTab.style.display = 'none';
            if (collectionsTab) collectionsTab.style.display = 'none';
        }
    }

    // Pestañas (Productos / Colecciones)
    tabButtons.forEach(btn => {
        btn.addEventListener('click', () => {
            tabButtons.forEach(b => b.classList.remove('active'));
            btn.classList.add('active');
            showTab(btn.dataset.tab);
        });
    });

    function showTab(tabId) {
        if (productsTab) productsTab.style.display = tabId === 'productsTab' ? 'block' : 'none';
        if (collectionsTab) collectionsTab.style.display = tabId === 'collectionsTab' ? 'block' : 'none';
    }

    // Petición AJAX / Fetch al Servlet
    function ejecutarBusqueda(query) {
        const contextPath = window.location.pathname.substring(0, window.location.pathname.indexOf('/', 1)) || '';
        
        fetch(`${contextPath}/BuscarApiServlet?q=${encodeURIComponent(query)}`)
            .then(res => res.json())
            .then(productos => {
                renderProductos(productos, contextPath);
                renderColecciones(productos, contextPath);
            })
            .catch(err => console.error("Error al realizar la búsqueda:", err));
    }

    // Renderizar Productos
    function renderProductos(productos, contextPath) {
        if (!searchResultsList) return;
        searchResultsList.innerHTML = '';

        if (productos.length === 0) {
            searchResultsList.innerHTML = '<p style="color:#777; font-size:0.9rem;">No se encontraron productos.</p>';
            return;
        }

        productos.forEach(p => {
            const precioActual = p.precioOferta ? `S/. ${p.precioOferta}` : `S/. ${p.precio}`;
            const precioAnterior = p.precioOferta ? `<span class="old-price">S/. ${p.precio}</span>` : '';
            const imgPath = p.imagenUrl.startsWith('http') ? p.imagenUrl : `${contextPath}/${p.imagenUrl}`;

            const itemHTML = `
                <a href="${contextPath}/ProductoDetalleServlet?id=${p.id}" class="search-item">
                    <img src="${imgPath}" alt="${p.nombre}">
                    <div class="search-item-info">
                        <h5 class="search-item-title">${p.nombre}</h5>
                        <span class="search-item-price">${precioActual} ${precioAnterior}</span>
                    </div>
                </a>
            `;
            searchResultsList.insertAdjacentHTML('beforeend', itemHTML);
        });
    }

    // Renderizar Colecciones
    function renderColecciones(productos, contextPath) {
        if (!collectionsResultsList) return;
        collectionsResultsList.innerHTML = '';

        const categoriasMap = {};
        productos.forEach(p => {
            if (p.categoria) {
                categoriasMap[p.categoria] = (categoriasMap[p.categoria] || 0) + 1;
            }
        });

        const categorias = Object.keys(categoriasMap);

        if (categorias.length === 0) {
            collectionsResultsList.innerHTML = '<p style="color:#777; font-size:0.9rem;">No hay colecciones coincidentes.</p>';
            return;
        }

        categorias.forEach(cat => {
            const itemHTML = `
                <a href="${contextPath}/CatalogoServlet?categoria=${encodeURIComponent(cat)}" class="collection-item">
                    <div class="collection-item-title">${cat}</div>
                    <div class="collection-item-count">${categoriasMap[cat]} producto(s)</div>
                </a>
            `;
            collectionsResultsList.insertAdjacentHTML('beforeend', itemHTML);
        });
    }
});
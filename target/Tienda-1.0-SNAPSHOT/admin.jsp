<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Iniciar Sesión - WEBIA STORE</title>
    <!-- FontAwesome para iconos -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=2">
</head>
<body>

    <div class="login-screen-wrapper">

        <!-- Fondo con sombreado oscuro -->
        <div class="login-bg-overlay"></div>

        <div class="login-container">

            <!-- Logo de la tienda -->
            <div class="login-logo">
                <a href="index.jsp">
                    <h2>WEBIA STORE</h2>
                </a>
            </div>

            <!-- Tarjeta de Login -->
            <div class="login-card">
                <h2>Iniciar sesión</h2>
                <p class="login-subtitle">
                    Inicia sesión o crea una cuenta
                </p>

                <form action="LoginServlet" method="POST" class="login-form">

                    <div class="input-group">
                        <input
                            type="email"
                            name="email"
                            id="email"
                            placeholder="Correo electrónico"
                            required
                        >

                        <button
                            type="submit"
                            class="btn-submit"
                            aria-label="Continuar"
                        >
                            <i class="fa-solid fa-arrow-right"></i>
                        </button>
                    </div>

                    <div class="checkbox-group">
                        <input
                            type="checkbox"
                            id="newsletter"
                            name="newsletter"
                            checked
                        >

                        <label for="newsletter">
                            Enviarme novedades y descuentos especiales
                            por WhatsApp o correo
                        </label>
                    </div>

                    <p class="login-terms">
                        Si continúas, aceptas nuestros
                        <a href="#">Términos del servicio</a>
                    </p>

                </form>
            </div>

            <!-- Footer -->
            <div class="login-footer">
                <a href="#">Política de privacidad</a>
            </div>

        </div>

    </div>

</body>
</html>
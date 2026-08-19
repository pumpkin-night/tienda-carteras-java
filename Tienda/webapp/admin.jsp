<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Panel Admin | WEBIA STORE</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .admin-container { max-width: 1100px; margin: 40px auto; padding: 0 20px; }
        .admin-grid { display: grid; grid-template-columns: 1fr; gap: 30px; }
        @media (min-width: 850px) { .admin-grid { grid-template-columns: 320px 1fr; } }
        
        .form-card { background: #fff; border: 1px solid #e5e5e5; padding: 20px; border-radius: 4px; }
        .form-group { margin-bottom: 12px; }
        .form-group label { display: block; font-size: 11px; text-transform: uppercase; margin-bottom: 4px; font-weight: bold; }
        .form-group input, .form-group select, .form-group textarea {
            width: 100%; padding: 8px; border: 1px solid #ccc; font-size: 13px; border-radius: 3px;
        }
        .btn-submit { width: 100%; padding: 10px; background: #000; color: #fff; border: none; cursor: pointer; font-weight: bold; }
        
        /* Tabla de Productos */
        .table-wrapper { overflow-x: auto; background: #fff; border: 1px solid #e5e5e5; }
        table { width: 100%; border-collapse: collapse; font-size: 13px; }
        th, td { padding: 10px; text-align: left; border-bottom: 1px solid #eee; }
        th { background: #fafafa; font-size: 11px; text-transform: uppercase; }
        .img-thumb { width: 45px; height: 45px; object-fit: cover; border-radius: 3px; }
        .actions a { text-decoration: none; margin-right: 8px; font-weight: bold; font-size: 12px; }
        .btn-edit { color: #0056b3; }
        .btn-delete { color: #d9534f; }
    </style>
</head>
<body>

    <header class="navbar">
        <div class="nav-container">
            <a href="CatalogoServlet" class="brand-logo">WEBIA STORE - PANEL ADMIN</a>
            <a href="CatalogoServlet" style="font-size: 12px; text-decoration: none; color: #333;"><i class="fa-solid fa-store"></i> Ver Tienda</a>
        </div>
    </header>

    <main class="admin-container">
        <div class="admin-grid">
            
            <!-- FORMULARIO DE REGISTRO / EDICIÓN -->
            <section class="form-card">
                <h3>${productoEditar != null ? "Editar Modelo" : "Nueva Cartera"}</h3>
                <br>
                <form action="AdminServlet" method="POST">
                    <input type="hidden" name="id" value="${productoEditar != null ? productoEditar.id : ''}">

                    <div class="form-group">
                        <label>Nombre del Modelo</label>
                        <input type="text" name="nombre" value="${productoEditar != null ? productoEditar.nombre : ''}" required>
                    </div>

                    <div class="form-group">
                        <label>Categoría</label>
                        <select name="categoria" required>
                            <option value="Mano" ${productoEditar != null && productoEditar.categoria == 'Mano' ? 'selected' : ''}>Mano</option>
                            <option value="Totes" ${productoEditar != null && productoEditar.categoria == 'Totes' ? 'selected' : ''}>Totes</option>
                            <option value="Mochilas" ${productoEditar != null && productoEditar.categoria == 'Mochilas' ? 'selected' : ''}>Mochilas</option>
                            <option value="Bandoleras" ${productoEditar != null && productoEditar.categoria == 'Bandoleras' ? 'selected' : ''}>Bandoleras</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label>Precio Regular (S/)</label>
                        <input type="number" step="0.01" name="precio" value="${productoEditar != null ? productoEditar.precio : ''}" required>
                    </div>

                    <div class="form-group">
                        <label>Precio Oferta (S/) - Opcional</label>
                        <input type="number" step="0.01" name="precioOferta" value="${productoEditar != null ? productoEditar.precioOferta : ''}">
                    </div>

                    <div class="form-group">
                        <label>Ruta/URL de la Imagen</label>
                        <input type="text" name="imagenUrl" placeholder="assets/images/cartera1.jpg" value="${productoEditar != null ? productoEditar.imagenUrl : ''}" required>
                    </div>

                    <div class="form-group">
                        <label>Medidas (Ej: 25x15 cm)</label>
                        <input type="text" name="medidas" value="${productoEditar != null ? productoEditar.medidas : ''}">
                    </div>

                    <div class="form-group">
                        <label>Descripción</label>
                        <textarea name="descripcion" rows="3">${productoEditar != null ? productoEditar.descripcion : ''}</textarea>
                    </div>

                    <button type="submit" class="btn-submit">${productoEditar != null ? "Actualizar" : "Guardar Cartera"}</button>
                </form>
            </section>

            <!-- TABLA INVENTARIO DE CARTERAS -->
            <section class="table-wrapper">
                <table>
                    <thead>
                        <tr>
                            <th>Imagen</th>
                            <th>Modelo</th>
                            <th>Categoría</th>
                            <th>Precio</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="p" items="${productos}">
                            <tr>
                                <td><img src="${p.imagenUrl}" class="img-thumb" alt="${p.nombre}"></td>
                                <td><strong>${p.nombre}</strong></td>
                                <td>${p.categoria}</td>
                                <td>
                                    <c:if test="${p.precioOferta != null}">
                                        <s style="color:#aaa;">S/ ${p.precio}</s> <strong>S/ ${p.precioOferta}</strong>
                                    </c:if>
                                    <c:if test="${p.precioOferta == null}">
                                        S/ ${p.precio}
                                    </c:if>
                                </td>
                                <td class="actions">
                                    <a href="AdminServlet?accion=editar&id=${p.id}" class="btn-edit"><i class="fa-solid fa-pen"></i></a>
                                    <a href="AdminServlet?accion=cambiarEstado&id=${p.id}&estado=${p.activo}" class="btn-delete" onclick="return confirm('¿Deseas cambiar el estado de esta cartera?')">
                                        <i class="fa-solid ${p.activo ? 'fa-eye-slash' : 'fa-eye'}"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </section>

        </div>
    </main>

</body>
</html>
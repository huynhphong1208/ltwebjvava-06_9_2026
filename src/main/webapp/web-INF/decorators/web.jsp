<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property="title"/></title>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        body {
            font-family: 'Inter', system-ui, -apple-system, sans-serif;
            background-color: #f8fafc;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        .header-navbar {
            background-color: #ffffff;
            box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1);
        }
        .avatar-thumb {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid #e2e8f0;
        }
        .main-container {
            flex: 1;
        }
    </style>
    <sitemesh:write property="head"/>
</head>
<body>
    <nav class="navbar navbar-expand-lg header-navbar sticky-top">
        <div class="container">
            <a class="navbar-brand fw-bold text-primary" href="${pageContext.request.contextPath}/waiting">
                <i class="bi bi-lightning-charge-fill text-warning"></i> WebApp Demo
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#webNavbar" aria-controls="webNavbar" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="webNavbar">
                <ul class="navbar-nav ms-auto align-items-center">
                    <c:choose>
                        <c:when test="${sessionScope.account == null}">
                            <li class="nav-item me-2">
                                <a href="${pageContext.request.contextPath}/login" class="btn btn-primary">Đăng nhập</a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/register" class="btn btn-outline-secondary">Đăng ký</a>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/waiting" class="nav-link">Trang chủ</a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/product" class="nav-link">Sản phẩm</a>
                            </li>
                            <c:if test="${sessionScope.account.roleid == 1}">
                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                        Quản trị
                                    </a>
                                    <ul class="dropdown-menu">
                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/category/list">Quản lý Category</a></li>
                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/product/list">Quản lý Product</a></li>
                                    </ul>
                                </li>
                            </c:if>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/profile" class="nav-link">Hồ sơ cá nhân</a>
                            </li>
                            <li class="nav-item ms-3 d-flex align-items-center">
                                <c:choose>
                                    <c:when test="${not empty sessionScope.account.avatar}">
                                        <img src="${pageContext.request.contextPath}/image?fname=${sessionScope.account.avatar}" alt="Avatar" class="avatar-thumb me-2">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="https://ui-avatars.com/api/?name=${sessionScope.account.fullName}&background=2563eb&color=fff" alt="Avatar" class="avatar-thumb me-2">
                                    </c:otherwise>
                                </c:choose>
                                <span class="fw-semibold text-dark me-3">${sessionScope.account.fullName}</span>
                                <a href="${pageContext.request.contextPath}/logout" class="btn btn-sm btn-outline-danger">Đăng xuất</a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>

    <main class="main-container py-5">
        <div class="container">
            <sitemesh:write property="body"/>
        </div>
    </main>

    <footer class="bg-white border-top py-4 text-center mt-auto text-secondary">
        <div class="container">
            <small>&copy; 2026 WebApp Demo - JPA & SiteMesh 3 with Bootstrap</small>
        </div>
    </footer>

    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
    
    <!-- Form Validation Script -->
    <script>
        // Example starter JavaScript for disabling form submissions if there are invalid fields
        (() => {
            'use strict'
            // Fetch all the forms we want to apply custom Bootstrap validation styles to
            const forms = document.querySelectorAll('.needs-validation')
            // Loop over them and prevent submission
            Array.from(forms).forEach(form => {
                form.addEventListener('submit', event => {
                    if (!form.checkValidity()) {
                        event.preventDefault()
                        event.stopPropagation()
                    }
                    form.classList.add('was-validated')
                }, false)
            })
        })()
    </script>
</body>
</html>

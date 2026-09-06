<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property="title"/></title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }
        body {
            font-family: 'Inter', system-ui, -apple-system, sans-serif;
            background-color: #f8fafc;
            color: #1e293b;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        .header-navbar {
            background-color: #ffffff;
            box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px 0 rgba(0, 0, 0, 0.06);
            padding: 0.85rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 50;
        }
        .brand-logo {
            font-size: 1.25rem;
            font-weight: 700;
            color: #2563eb;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        .nav-items {
            display: flex;
            align-items: center;
            gap: 1.5rem;
        }
        .nav-item-link {
            color: #475569;
            text-decoration: none;
            font-weight: 500;
            font-size: 0.95rem;
            transition: color 0.2s ease;
        }
        .nav-item-link:hover {
            color: #2563eb;
        }
        .user-profile-badge {
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }
        .avatar-thumb {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid #e2e8f0;
        }
        .btn-action {
            padding: 0.5rem 1rem;
            border-radius: 8px;
            font-size: 0.875rem;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.2s ease;
        }
        .btn-primary {
            background-color: #2563eb;
            color: #ffffff;
        }
        .btn-primary:hover {
            background-color: #1d4ed8;
        }
        .btn-outline {
            background-color: #ffffff;
            color: #475569;
            border: 1px solid #cbd5e1;
        }
        .btn-outline:hover {
            background-color: #f1f5f9;
            color: #0f172a;
        }
        .main-container {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 2rem;
            width: 100%;
        }
        .footer {
            background-color: #ffffff;
            border-top: 1px solid #e2e8f0;
            padding: 1.5rem;
            text-align: center;
            color: #64748b;
            font-size: 0.875rem;
            margin-top: auto;
        }
    </style>
    <sitemesh:write property="head"/>
</head>
<body>
    <header class="header-navbar">
        <a href="${pageContext.request.contextPath}/waiting" class="brand-logo">
            ⚡ WebApp Demo
        </a>

        <div class="nav-items">
            <c:choose>
                <c:when test="${sessionScope.account == null}">
                    <a href="${pageContext.request.contextPath}/login" class="btn-action btn-primary">Đăng nhập</a>
                    <a href="${pageContext.request.contextPath}/register" class="btn-action btn-outline">Đăng ký</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/waiting" class="nav-item-link">Trang chủ</a>
                    <a href="${pageContext.request.contextPath}/product" class="nav-item-link">Sản phẩm</a>
                    <c:if test="${sessionScope.account.roleid == 1}">
                        <a href="${pageContext.request.contextPath}/admin/category/list" class="nav-item-link">Quản lý Category</a>
                        <a href="${pageContext.request.contextPath}/admin/product/list" class="nav-item-link">Quản lý Product</a>
                    </c:if>
                    <a href="${pageContext.request.contextPath}/profile" class="nav-item-link">Hồ sơ cá nhân</a>
                    
                    <div class="user-profile-badge">
                        <c:choose>
                            <c:when test="${not empty sessionScope.account.avatar}">
                                <img src="${pageContext.request.contextPath}/image?fname=${sessionScope.account.avatar}" alt="Avatar" class="avatar-thumb">
                            </c:when>
                            <c:otherwise>
                                <img src="https://ui-avatars.com/api/?name=${sessionScope.account.fullName}&background=2563eb&color=fff" alt="Avatar" class="avatar-thumb">
                            </c:otherwise>
                        </c:choose>
                        <span style="font-weight: 600; font-size: 0.9rem;">${sessionScope.account.fullName}</span>
                    </div>

                    <a href="${pageContext.request.contextPath}/logout" class="btn-action btn-outline">Đăng xuất</a>
                </c:otherwise>
            </c:choose>
        </div>
    </header>

    <main class="main-container">
        <sitemesh:write property="body"/>
    </main>

    <footer class="footer">
        &copy; 2026 WebApp Demo - Quản lý JPA & SiteMesh Decorator
    </footer>
</body>
</html>

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
            background-color: #f1f5f9;
            color: #0f172a;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        .admin-navbar {
            background-color: #1e293b;
            color: #ffffff;
            padding: 0.85rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .admin-brand {
            font-size: 1.25rem;
            font-weight: 700;
            color: #38bdf8;
            text-decoration: none;
        }
        .admin-links {
            display: flex;
            align-items: center;
            gap: 1.5rem;
        }
        .admin-link {
            color: #cbd5e1;
            text-decoration: none;
            font-size: 0.9rem;
            font-weight: 500;
        }
        .admin-link:hover {
            color: #ffffff;
        }
        .admin-body {
            flex: 1;
            padding: 2rem;
            max-width: 1200px;
            width: 100%;
            margin: 0 auto;
        }
        .admin-footer {
            background-color: #1e293b;
            color: #94a3b8;
            padding: 1rem;
            text-align: center;
            font-size: 0.85rem;
            margin-top: auto;
        }
    </style>
    <sitemesh:write property="head"/>
</head>
<body>
    <header class="admin-navbar">
        <a href="${pageContext.request.contextPath}/admin/category/list" class="admin-brand">
            🛠️ Admin Portal
        </a>
        <div class="admin-links">
            <a href="${pageContext.request.contextPath}/admin/category/list" class="admin-link">Danh sách Category</a>
            <a href="${pageContext.request.contextPath}/admin/category/add" class="admin-link">Thêm Category</a>
            <a href="${pageContext.request.contextPath}/profile" class="admin-link">Profile</a>
            <a href="${pageContext.request.contextPath}/waiting" class="admin-link">Trang chủ Client</a>
            <a href="${pageContext.request.contextPath}/logout" class="admin-link">Đăng xuất</a>
        </div>
    </header>

    <main class="admin-body">
        <sitemesh:write property="body"/>
    </main>

    <footer class="admin-footer">
        &copy; 2026 Admin Dashboard - JPA Management
    </footer>
</body>
</html>

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
        .content-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }
        .content-header h2 {
            font-size: 1.5rem;
            color: #0f172a;
        }
        .table-container {
            background: white;
            border-radius: 8px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            overflow: hidden;
        }
        .data-table {
            width: 100%;
            border-collapse: collapse;
        }
        .data-table th, .data-table td {
            padding: 1rem;
            text-align: left;
            border-bottom: 1px solid #e2e8f0;
        }
        .data-table th {
            background-color: #f8fafc;
            font-weight: 600;
            color: #475569;
        }
        .data-table tr:hover {
            background-color: #f8fafc;
        }
        .form-container {
            background: white;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }
        .form-group {
            margin-bottom: 1.5rem;
        }
        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: #374151;
        }
        .form-group input, .form-group select, .form-group textarea {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #d1d5db;
            border-radius: 6px;
            font-size: 1rem;
        }
        .form-group input:focus, .form-group select:focus, .form-group textarea:focus {
            outline: none;
            border-color: #2563eb;
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
        }
        .btn {
            padding: 0.5rem 1rem;
            border-radius: 6px;
            font-size: 0.875rem;
            font-weight: 500;
            text-decoration: none;
            display: inline-block;
            cursor: pointer;
            border: none;
        }
        .btn-primary {
            background-color: #2563eb;
            color: white;
        }
        .btn-primary:hover {
            background-color: #1d4ed8;
        }
        .btn-secondary {
            background-color: #64748b;
            color: white;
        }
        .btn-secondary:hover {
            background-color: #475569;
        }
        .btn-warning {
            background-color: #f59e0b;
            color: white;
        }
        .btn-warning:hover {
            background-color: #d97706;
        }
        .btn-danger {
            background-color: #ef4444;
            color: white;
        }
        .btn-danger:hover {
            background-color: #dc2626;
        }
        .btn-sm {
            padding: 0.25rem 0.5rem;
            font-size: 0.75rem;
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
            <a href="${pageContext.request.contextPath}/admin/product/list" class="admin-link">Danh sách Product</a>
            <a href="${pageContext.request.contextPath}/admin/category/list" class="admin-link">Chọn Category để thêm Product</a>
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

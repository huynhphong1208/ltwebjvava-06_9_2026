<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<style>
    .navbar {
        display: flex;
        justify-content: space-between;
        align-items: center;
        background-color: #ffffff;
        padding: 0.75rem 2rem;
        box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.05);
        border-bottom: 1px solid #e2e8f0;
        margin-bottom: 2rem;
    }
    .nav-brand a {
        font-size: 1.25rem;
        font-weight: 700;
        color: #2563eb;
        text-decoration: none;
        letter-spacing: -0.025em;
    }
    .nav-links {
        display: flex;
        align-items: center;
        gap: 1.5rem;
    }
    .user-greeting {
        font-size: 0.9rem;
        color: #475569;
    }
    .nav-btn {
        padding: 0.5rem 1rem;
        border-radius: 6px;
        font-size: 0.875rem;
        font-weight: 600;
        text-decoration: none;
        transition: all 0.2s ease;
    }
    .btn-login {
        background-color: #2563eb;
        color: #ffffff;
    }
    .btn-login:hover {
        background-color: #1d4ed8;
    }
    .btn-logout {
        background-color: #f1f5f9;
        color: #475569;
        border: 1px solid #cbd5e1;
    }
    .btn-logout:hover {
        background-color: #e2e8f0;
        color: #0f172a;
    }
</style>

<div class="navbar">
    <div class="nav-brand">
        <a href="${pageContext.request.contextPath}/waiting">AppDemo</a>
    </div>
    <div class="nav-links">
        <c:choose>
            <c:when test="${sessionScope.account == null}">
                <a class="nav-btn btn-login" href="${pageContext.request.contextPath}/login">Đăng nhập</a>
            </c:when>
            <c:otherwise>
                <span class="user-greeting">Xin chào, <b>${sessionScope.account.fullName}</b></span>
                <a class="nav-btn btn-logout" href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
            </c:otherwise>
        </c:choose>
    </div>
</div>

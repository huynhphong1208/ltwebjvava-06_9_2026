<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách sản phẩm</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Inter', sans-serif; }
        body { background-color: #f8fafc; color: #1e293b; }
        .header { background: white; padding: 20px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }
        .header h1 { color: #0f172a; }
        .container { max-width: 1200px; margin: 0 auto; padding: 40px 20px; }
        .product-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 30px; }
        .product-card { background: white; border-radius: 12px; overflow: hidden; box-shadow: 0 4px 15px rgba(0,0,0,0.08); transition: transform 0.3s, box-shadow 0.3s; cursor: pointer; }
        .product-card:hover { transform: translateY(-5px); box-shadow: 0 8px 25px rgba(0,0,0,0.12); }
        .product-image { width: 100%; height: 250px; object-fit: cover; background: #f1f5f9; }
        .product-info { padding: 20px; }
        .product-name { font-size: 18px; font-weight: 600; color: #0f172a; margin-bottom: 10px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }
        .product-price { font-size: 20px; font-weight: 700; color: #2563eb; }
        .product-category { font-size: 14px; color: #64748b; margin-top: 8px; }
        .pagination { display: flex; justify-content: center; align-items: center; margin-top: 40px; gap: 10px; }
        .pagination a, .pagination span { padding: 10px 16px; border: 1px solid #e2e8f0; border-radius: 8px; text-decoration: none; color: #475569; background: white; transition: all 0.2s; }
        .pagination a:hover { background: #f1f5f9; border-color: #cbd5e1; }
        .pagination .active { background: #2563eb; color: white; border-color: #2563eb; }
        .pagination .disabled { color: #cbd5e1; cursor: not-allowed; }
        .info-bar { display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px; color: #64748b; }
    </style>
</head>
<body>
    <div class="header">
        <div class="container" style="padding: 0;">
            <h1>Danh sách sản phẩm</h1>
        </div>
    </div>

    <div class="container">
        <div class="info-bar">
            <span>Tổng số sản phẩm: ${totalProducts}</span>
            <span>Trang ${currentPage} / ${totalPages}</span>
        </div>

        <div class="product-grid">
            <c:forEach var="product" items="${products}">
                <div class="product-card" onclick="window.location.href='${pageContext.request.contextPath}/product/detail?id=${product.productId}'">
                    <c:choose>
                        <c:when test="${not empty product.image && product.image.startsWith('product/')}">
                            <img src="${pageContext.request.contextPath}/image?fname=${product.image}" alt="${product.productName}" class="product-image" onerror="this.src='https://via.placeholder.com/300x250?text=No+Image'">
                        </c:when>
                        <c:otherwise>
                            <img src="${product.image}" alt="${product.productName}" class="product-image" onerror="this.src='https://via.placeholder.com/300x250?text=No+Image'">
                        </c:otherwise>
                    </c:choose>
                    <div class="product-info">
                        <div class="product-name" title="${product.productName}">${product.productName}</div>
                        <div class="product-price">${product.price} VNĐ</div>
                        <c:if test="${product.category != null}">
                            <div class="product-category">${product.category.cateName}</div>
                        </c:if>
                    </div>
                </div>
            </c:forEach>
        </div>

        <!-- Phân trang -->
        <div class="pagination">
            <c:if test="${currentPage > 1}">
                <a href="${pageContext.request.contextPath}/product?page=${currentPage - 1}">« Trước</a>
            </c:if>
            <c:if test="${currentPage == 1}">
                <span class="disabled">« Trước</span>
            </c:if>

            <c:forEach begin="1" end="${totalPages}" var="i">
                <c:if test="${i == currentPage}">
                    <span class="active">${i}</span>
                </c:if>
                <c:if test="${i != currentPage}">
                    <a href="${pageContext.request.contextPath}/product?page=${i}">${i}</a>
                </c:if>
            </c:forEach>

            <c:if test="${currentPage < totalPages}">
                <a href="${pageContext.request.contextPath}/product?page=${currentPage + 1}">Tiếp »</a>
            </c:if>
            <c:if test="${currentPage == totalPages}">
                <span class="disabled">Tiếp »</span>
            </c:if>
        </div>
    </div>
</body>
</html>

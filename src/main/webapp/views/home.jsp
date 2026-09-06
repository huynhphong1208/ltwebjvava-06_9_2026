<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang Chủ</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Inter', sans-serif; }
        body { background-color: #f8fafc; color: #1e293b; }
        .header { background: white; padding: 20px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }
        .header h1 { color: #0f172a; }
        .container { max-width: 1200px; margin: 0 auto; padding: 40px 20px; }
        .section-title { font-size: 24px; font-weight: 700; color: #0f172a; margin-bottom: 30px; }
        .product-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(250px, 1fr)); gap: 25px; }
        .product-card { background: white; border-radius: 12px; overflow: hidden; box-shadow: 0 4px 15px rgba(0,0,0,0.08); transition: transform 0.3s, box-shadow 0.3s; cursor: pointer; }
        .product-card:hover { transform: translateY(-5px); box-shadow: 0 8px 25px rgba(0,0,0,0.12); }
        .product-image { width: 100%; height: 200px; object-fit: cover; background: #f1f5f9; }
        .product-info { padding: 20px; }
        .product-name { font-size: 16px; font-weight: 600; color: #0f172a; margin-bottom: 8px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }
        .product-price { font-size: 18px; font-weight: 700; color: #2563eb; }
        .product-category { font-size: 14px; color: #64748b; margin-top: 8px; }
        .btn-view-all { display: inline-block; margin-top: 30px; padding: 12px 24px; background: #2563eb; color: white; text-decoration: none; border-radius: 8px; font-weight: 600; }
        .btn-view-all:hover { background: #1d4ed8; }
    </style>
</head>
<body>
    <div class="header">
        <div class="container" style="padding: 0;">
            <h1>Sản phẩm mới nhất</h1>
        </div>
    </div>

    <div class="container">
        <h2 class="section-title">10 Sản phẩm mới nhất</h2>

        <div class="product-grid">
            <c:forEach var="product" items="${latestProducts}">
                <div class="product-card" onclick="window.location.href='${pageContext.request.contextPath}/product/detail?id=${product.productId}'">
                    <c:choose>
                        <c:when test="${not empty product.image && product.image.startsWith('product/')}">
                            <img src="${pageContext.request.contextPath}/image?fname=${product.image}" alt="${product.productName}" class="product-image" onerror="this.src='https://via.placeholder.com/250x200?text=No+Image'">
                        </c:when>
                        <c:otherwise>
                            <img src="${product.image}" alt="${product.productName}" class="product-image" onerror="this.src='https://via.placeholder.com/250x200?text=No+Image'">
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

        <div style="text-align: center;">
            <a href="${pageContext.request.contextPath}/product" class="btn-view-all">Xem tất cả sản phẩm</a>
        </div>
    </div>
</body>
</html>

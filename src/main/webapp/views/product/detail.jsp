<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${product.productName} - Chi tiết sản phẩm</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Inter', sans-serif; }
        body { background-color: #f8fafc; color: #1e293b; }
        .header { background: white; padding: 20px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }
        .header h1 { color: #0f172a; }
        .container { max-width: 1200px; margin: 0 auto; padding: 40px 20px; }
        .breadcrumb { margin-bottom: 20px; color: #64748b; }
        .breadcrumb a { color: #2563eb; text-decoration: none; }
        .breadcrumb a:hover { text-decoration: underline; }

        .product-detail { display: grid; grid-template-columns: 1fr 1fr; gap: 40px; background: white; padding: 40px; border-radius: 16px; box-shadow: 0 4px 20px rgba(0,0,0,0.08); }
        .product-image-container { }
        .product-image { width: 100%; height: 400px; object-fit: cover; border-radius: 12px; background: #f1f5f9; }

        .product-info { }
        .product-category { color: #64748b; font-size: 14px; margin-bottom: 10px; }
        .product-name { font-size: 28px; font-weight: 700; color: #0f172a; margin-bottom: 15px; }
        .product-price { font-size: 32px; font-weight: 700; color: #2563eb; margin-bottom: 20px; }
        .product-stock { display: inline-block; padding: 8px 16px; background: #dbeafe; color: #1e40af; border-radius: 20px; font-size: 14px; font-weight: 600; margin-bottom: 20px; }
        .product-description { color: #475569; line-height: 1.8; margin-bottom: 30px; }
        .product-meta { display: grid; grid-template-columns: 1fr 1fr; gap: 15px; margin-bottom: 30px; }
        .meta-item { }
        .meta-label { color: #64748b; font-size: 14px; margin-bottom: 5px; }
        .meta-value { color: #0f172a; font-weight: 600; }

        .btn-group { display: flex; gap: 15px; }
        .btn { padding: 14px 28px; border-radius: 8px; font-weight: 600; cursor: pointer; border: none; text-decoration: none; display: inline-block; }
        .btn-primary { background: #2563eb; color: white; }
        .btn-primary:hover { background: #1d4ed8; }
        .btn-secondary { background: #f1f5f9; color: #475569; }
        .btn-secondary:hover { background: #e2e8f0; }

        .related-section { margin-top: 50px; }
        .section-title { font-size: 24px; font-weight: 700; color: #0f172a; margin-bottom: 30px; }
        .related-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(200px, 1fr)); gap: 20px; }
        .related-card { background: white; border-radius: 10px; overflow: hidden; box-shadow: 0 2px 10px rgba(0,0,0,0.05); cursor: pointer; transition: transform 0.2s; }
        .related-card:hover { transform: translateY(-3px); }
        .related-image { width: 100%; height: 150px; object-fit: cover; background: #f1f5f9; }
        .related-info { padding: 15px; }
        .related-name { font-size: 14px; font-weight: 600; color: #0f172a; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }
        .related-price { font-size: 16px; font-weight: 700; color: #2563eb; margin-top: 5px; }

        @media (max-width: 768px) {
            .product-detail { grid-template-columns: 1fr; }
            .product-image { height: 300px; }
        }
    </style>
</head>
<body>
    <div class="header">
        <div class="container" style="padding: 0;">
            <h1>Chi tiết sản phẩm</h1>
        </div>
    </div>

    <div class="container">
        <div class="breadcrumb">
            <a href="${pageContext.request.contextPath}/home">Trang chủ</a> >
            <a href="${pageContext.request.contextPath}/product">Sản phẩm</a> >
            <span>${product.productName}</span>
        </div>

        <div class="product-detail">
            <div class="product-image-container">
                <c:choose>
                    <c:when test="${not empty product.image && product.image.startsWith('product/')}">
                        <img src="${pageContext.request.contextPath}/image?fname=${product.image}" alt="${product.productName}" class="product-image" onerror="this.src='https://via.placeholder.com/400x400?text=No+Image'">
                    </c:when>
                    <c:otherwise>
                        <img src="${product.image}" alt="${product.productName}" class="product-image" onerror="this.src='https://via.placeholder.com/400x400?text=No+Image'">
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="product-info">
                <c:if test="${product.category != null}">
                    <div class="product-category">${product.category.cateName}</div>
                </c:if>

                <h2 class="product-name">${product.productName}</h2>
                <div class="product-price">${product.price} VNĐ</div>

                <c:if test="${product.stock > 0}">
                    <div class="product-stock">Còn ${product.stock} sản phẩm</div>
                </c:if>
                <c:if test="${product.stock == 0}">
                    <div class="product-stock" style="background: #fee2e2; color: #dc2626;">Hết hàng</div>
                </c:if>

                <div class="product-description">
                    <c:if test="${not empty product.description}">
                        ${product.description}
                    </c:if>
                    <c:if test="${empty product.description}">
                        Chưa có mô tả cho sản phẩm này.
                    </c:if>
                </div>

                <div class="product-meta">
                    <div class="meta-item">
                        <div class="meta-label">Mã sản phẩm</div>
                        <div class="meta-value">#${product.productId}</div>
                    </div>
                    <div class="meta-item">
                        <div class="meta-label">Ngày thêm</div>
                        <div class="meta-value">${product.createdAt}</div>
                    </div>
                </div>

                <div class="btn-group">
                    <a href="${pageContext.request.contextPath}/product" class="btn btn-secondary">Quay lại</a>
                    <button class="btn btn-primary">Thêm vào giỏ hàng</button>
                </div>
            </div>
        </div>

        <c:if test="${not empty relatedProducts && relatedProducts.size() > 1}">
            <div class="related-section">
                <h3 class="section-title">Sản phẩm liên quan</h3>
                <div class="related-grid">
                    <c:forEach var="related" items="${relatedProducts}">
                        <c:if test="${related.productId != product.productId}">
                            <div class="related-card" onclick="window.location.href='${pageContext.request.contextPath}/product/detail?id=${related.productId}'">
                                <c:choose>
                                    <c:when test="${not empty related.image && related.image.startsWith('product/')}">
                                        <img src="${pageContext.request.contextPath}/image?fname=${related.image}" alt="${related.productName}" class="related-image" onerror="this.src='https://via.placeholder.com/200x150?text=No+Image'">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${related.image}" alt="${related.productName}" class="related-image" onerror="this.src='https://via.placeholder.com/200x150?text=No+Image'">
                                    </c:otherwise>
                                </c:choose>
                                <div class="related-info">
                                    <div class="related-name" title="${related.productName}">${related.productName}</div>
                                    <div class="related-price">${related.price} VNĐ</div>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
            </div>
        </c:if>
    </div>
</body>
</html>

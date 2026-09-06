<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="content-wrapper">
    <div class="content-header">
        <h2>Sửa sản phẩm</h2>
        <a href="${pageContext.request.contextPath}/admin/product/list?cateId=${product.cateId}" class="btn btn-secondary">Quay lại</a>
    </div>

    <div class="form-container">
        <c:if test="${not empty error}"><p class="error">${error}</p></c:if>
        <form action="${pageContext.request.contextPath}/admin/product/edit" method="post" enctype="multipart/form-data">
            <input type="hidden" name="productId" value="${product.productId}">

            <div class="form-group">
                <label for="productName">Tên sản phẩm:</label>
                <input type="text" id="productName" name="productName" value="${product.productName}" required>
            </div>

            <div class="form-group">
                <label for="description">Mô tả:</label>
                <textarea id="description" name="description" rows="4">${product.description}</textarea>
            </div>

            <div class="form-group">
                <label for="price">Giá:</label>
                <input type="number" id="price" name="price" value="${product.price}" required min="0" step="0.01">
            </div>

            <div class="form-group">
                <label for="image">Ảnh sản phẩm mới (để trống nếu giữ ảnh cũ):</label>
                <input type="file" id="image" name="image" accept=".jpg,.jpeg,image/jpeg">
            </div>

            <div class="form-group">
                <label for="stock">Số lượng tồn kho:</label>
                <input type="number" id="stock" name="stock" value="${product.stock}" required min="0">
            </div>

            <div class="form-group">
                <label>Danh mục:</label>
                <p>${category.cateName}</p>
            </div>

            <button type="submit" class="btn btn-primary">Cập nhật sản phẩm</button>
        </form>
    </div>
</div>

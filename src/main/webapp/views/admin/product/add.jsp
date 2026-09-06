<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="content-wrapper">
    <div class="content-header">
        <h2>Thêm sản phẩm mới</h2>
        <c:choose>
            <c:when test="${not empty category}"><a href="${pageContext.request.contextPath}/admin/product/list?cateId=${category.cateId}" class="btn btn-secondary">Quay lại</a></c:when>
            <c:otherwise><a href="${pageContext.request.contextPath}/admin/product/list" class="btn btn-secondary">Quay lại</a></c:otherwise>
        </c:choose>
    </div>

    <div class="form-container">
        <c:if test="${not empty error}"><p class="error">${error}</p></c:if>
        <form action="${pageContext.request.contextPath}/admin/product/add" method="post" enctype="multipart/form-data">
            <c:if test="${not empty category}">
                <input type="hidden" name="cateId" value="${category.cateId}">
                <div class="form-group"><label>Danh mục</label><p>${category.cateName}</p></div>
            </c:if>
            <div class="form-group">
                <label for="productName">Tên sản phẩm:</label>
                <input type="text" id="productName" name="productName" required>
            </div>

            <div class="form-group">
                <label for="description">Mô tả:</label>
                <textarea id="description" name="description" rows="4"></textarea>
            </div>

            <div class="form-group">
                <label for="price">Giá:</label>
                <input type="number" id="price" name="price" required min="0" step="0.01">
            </div>

            <div class="form-group">
                <label for="image">Ảnh sản phẩm:</label>
                <input type="file" id="image" name="image" accept=".jpg,.jpeg,image/jpeg" required>
            </div>

            <div class="form-group">
                <label for="stock">Số lượng tồn kho:</label>
                <input type="number" id="stock" name="stock" required min="0" value="0">
            </div>

            <c:if test="${empty category}"><div class="form-group">
                <label for="cateId">Danh mục:</label>
                <select id="cateId" name="cateId" required>
                    <option value="">-- Chọn danh mục --</option>
                    <c:forEach var="category" items="${categories}">
                        <option value="${category.cateId}">${category.cateName}</option>
                    </c:forEach>
                </select>
            </div></c:if>

            <button type="submit" class="btn btn-primary">Lưu sản phẩm</button>
        </form>
    </div>
</div>

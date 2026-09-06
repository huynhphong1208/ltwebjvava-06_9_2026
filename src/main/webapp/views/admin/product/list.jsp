<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="content-wrapper">
    <div class="content-header">
        <h2>Quản lý Sản phẩm<c:if test="${not empty category}">: ${category.cateName}</c:if></h2>
        <c:choose>
            <c:when test="${not empty category}"><a href="${pageContext.request.contextPath}/admin/product/add?cateId=${category.cateId}" class="btn btn-primary">Thêm sản phẩm vào danh mục</a></c:when>
            <c:otherwise><a href="${pageContext.request.contextPath}/admin/category/list" class="btn btn-primary">Chọn danh mục để thêm sản phẩm</a></c:otherwise>
        </c:choose>
    </div>

    <div class="table-container">
        <table class="data-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Tên sản phẩm</th>
                    <th>Danh mục</th>
                    <th>Giá</th>
                    <th>Tồn kho</th>
                    <th>Hành động</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="product" items="${products}">
                    <tr>
                        <td>${product.productId}</td>
                        <td>${product.productName}</td>
                        <td>
                            <c:if test="${product.category != null}">
                                ${product.category.cateName}
                            </c:if>
                            <c:if test="${product.category == null}">
                                -
                            </c:if>
                        </td>
                        <td>${product.price} VNĐ</td>
                        <td>${product.stock}</td>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/product/edit?id=${product.productId}" class="btn btn-sm btn-warning">Sửa</a>
                            <a href="${pageContext.request.contextPath}/admin/product/delete?id=${product.productId}" class="btn btn-sm btn-danger" onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này?')">Xóa</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

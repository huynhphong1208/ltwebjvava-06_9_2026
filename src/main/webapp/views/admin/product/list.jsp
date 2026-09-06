<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="container-fluid py-4">
    <div class="card shadow-sm border-0 rounded-3">
        <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center border-bottom-0">
            <div>
                <h4 class="mb-1 text-primary font-weight-bold">
                    <i class="bi bi-box-seam me-2"></i>Quản lý Sản phẩm
                    <c:if test="${not empty category}">
                        <span class="text-secondary fw-normal fs-5">| ${category.cateName}</span>
                    </c:if>
                </h4>
                <p class="text-muted small mb-0">Danh sách các sản phẩm đang quản lý trong hệ thống</p>
            </div>
            <div>
                <c:choose>
                    <c:when test="${not empty category}">
                        <a href="${pageContext.request.contextPath}/admin/product/add?cateId=${category.cateId}" class="btn btn-primary px-3 shadow-sm">
                            <i class="bi bi-plus-lg me-1"></i> Thêm sản phẩm vào danh mục
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/category/list" class="btn btn-outline-secondary ms-2">
                            <i class="bi bi-arrow-left me-1"></i> Tất cả danh mục
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/admin/category/list" class="btn btn-outline-primary px-3">
                            <i class="bi bi-grid me-1"></i> Chọn danh mục để thêm sản phẩm
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                        <tr>
                            <th class="ps-4" style="width: 80px;">ID</th>
                            <th>Tên sản phẩm</th>
                            <th>Danh mục</th>
                            <th>Giá bán</th>
                            <th>Tồn kho</th>
                            <th class="text-end pe-4" style="width: 180px;">Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="product" items="${products}">
                            <tr>
                                <td class="ps-4 fw-bold text-secondary">#${product.productId}</td>
                                <td>
                                    <span class="fw-semibold text-dark">${product.productName}</span>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${product.category != null}">
                                            <span class="badge bg-info text-dark rounded-pill px-3 py-2">
                                                <i class="bi bi-folder2 me-1"></i>${product.category.cateName}
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-light text-muted">Chưa có danh mục</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="fw-bold text-success">
                                    <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="VNĐ" maxFractionDigits="0"/>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${product.stock > 10}">
                                            <span class="badge bg-success-subtle text-success border border-success-subtle px-2 py-1">${product.stock}</span>
                                        </c:when>
                                        <c:when test="${product.stock > 0}">
                                            <span class="badge bg-warning-subtle text-warning border border-warning-subtle px-2 py-1">${product.stock}</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-danger-subtle text-danger border border-danger-subtle px-2 py-1">Hết hàng</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-end pe-4">
                                    <a href="${pageContext.request.contextPath}/admin/product/edit?id=${product.productId}" 
                                       class="btn btn-sm btn-outline-warning me-1 shadow-sm" title="Chỉnh sửa">
                                        <i class="bi bi-pencil"></i> Sửa
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/product/delete?id=${product.productId}" 
                                       class="btn btn-sm btn-outline-danger shadow-sm" 
                                       onclick="return confirm('Bạn có chắc muốn xóa sản phẩm [${product.productName}] này?')" title="Xóa">
                                        <i class="bi bi-trash"></i> Xóa
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty products}">
                            <tr>
                                <td colspan="6" class="text-center py-5 text-muted">
                                    <i class="bi bi-inbox fs-1 d-block mb-2 text-secondary"></i>
                                    Chưa có sản phẩm nào trong danh mục này.
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>


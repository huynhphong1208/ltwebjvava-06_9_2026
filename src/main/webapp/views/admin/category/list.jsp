<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="container-fluid py-4">
    <div class="card shadow-sm border-0 rounded-3">
        <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center border-bottom-0">
            <div>
                <h4 class="mb-1 text-primary font-weight-bold">
                    <i class="bi bi-grid-3x3-gap-fill me-2"></i>Danh Sách Danh Mục
                </h4>
                <p class="text-muted small mb-0">Quản lý phân loại danh mục sản phẩm</p>
            </div>
            <div>
                <a class="btn btn-primary px-3 shadow-sm" href="${pageContext.request.contextPath}/admin/category/add">
                    <i class="bi bi-plus-circle me-1"></i> Thêm danh mục
                </a>
            </div>
        </div>

        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                        <tr>
                            <th class="ps-4" style="width: 10%;">ID</th>
                            <th style="width: 35%;">Tên danh mục</th>
                            <th style="width: 25%;">Hình ảnh</th>
                            <th class="text-end pe-4" style="width: 30%;">Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="category" items="${categories}">
                            <tr>
                                <td class="ps-4 fw-bold text-secondary">#${category.cateId}</td>
                                <td>
                                    <span class="fw-semibold text-dark fs-6">${category.cateName}</span>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty category.icons}">
                                            <img src="${pageContext.request.contextPath}/image?fname=${category.icons}"
                                                 class="rounded border shadow-sm"
                                                 style="width: 60px; height: 60px; object-fit: cover;"
                                                 alt="${category.cateName}">
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-light text-muted border">
                                                <i class="bi bi-image me-1"></i>Không có ảnh
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-end pe-4">
                                    <div class="btn-group shadow-sm" role="group">
                                        <a class="btn btn-sm btn-outline-info" href="${pageContext.request.contextPath}/admin/product/list?cateId=${category.cateId}">
                                            <i class="bi bi-box-seam me-1"></i>Sản phẩm
                                        </a>
                                        <a class="btn btn-sm btn-outline-warning" href="${pageContext.request.contextPath}/admin/category/edit?id=${category.cateId}">
                                            <i class="bi bi-pencil me-1"></i>Sửa
                                        </a>
                                        <a class="btn btn-sm btn-outline-danger" href="${pageContext.request.contextPath}/admin/category/delete?id=${category.cateId}"
                                           onclick="return confirm('Bạn có chắc muốn xóa danh mục [${category.cateName}] không?');">
                                            <i class="bi bi-trash me-1"></i>Xóa
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty categories}">
                            <tr>
                                <td colspan="4" class="text-center py-5 text-muted">
                                    <i class="bi bi-folder-x fs-1 d-block mb-2 text-secondary"></i>
                                    Chưa có danh mục nào.
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>


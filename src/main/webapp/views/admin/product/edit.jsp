<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<div class="row justify-content-center">
    <div class="col-md-10 col-lg-8">
        <div class="card shadow-sm border-0">
            <div class="card-header bg-white border-bottom-0 pt-4 pb-2 d-flex justify-content-between align-items-center">
                <h3 class="card-title fw-bold text-primary mb-0"><i class="bi bi-pencil-square me-2"></i>Sửa sản phẩm</h3>
                <a href="${pageContext.request.contextPath}/admin/product/list?cateId=${product.cateId}" class="btn btn-sm btn-outline-secondary"><i class="bi bi-arrow-left me-1"></i>Quay lại</a>
            </div>
            <div class="card-body p-4">
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="bi bi-exclamation-triangle-fill me-2"></i>${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/admin/product/edit" method="post" enctype="multipart/form-data" class="needs-validation" novalidate>
                    <input type="hidden" name="productId" value="${product.productId}">

                    <div class="mb-3">
                        <label for="productName" class="form-label fw-semibold">Tên sản phẩm <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="productName" name="productName" value="${product.productName}" required>
                        <div class="invalid-feedback">Vui lòng nhập tên sản phẩm.</div>
                    </div>

                    <div class="mb-3">
                        <label for="description" class="form-label fw-semibold">Mô tả</label>
                        <textarea class="form-control" id="description" name="description" rows="4">${product.description}</textarea>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="price" class="form-label fw-semibold">Giá <span class="text-danger">*</span></label>
                            <div class="input-group has-validation">
                                <input type="number" class="form-control" id="price" name="price" value="${product.price}" required min="0" step="0.01">
                                <span class="input-group-text">VNĐ</span>
                                <div class="invalid-feedback">Vui lòng nhập giá hợp lệ (lớn hơn hoặc bằng 0).</div>
                            </div>
                        </div>

                        <div class="col-md-6 mb-3">
                            <label for="stock" class="form-label fw-semibold">Số lượng tồn kho <span class="text-danger">*</span></label>
                            <input type="number" class="form-control" id="stock" name="stock" value="${product.stock}" required min="0">
                            <div class="invalid-feedback">Vui lòng nhập số lượng hợp lệ (lớn hơn hoặc bằng 0).</div>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Ảnh hiện tại</label>
                        <div class="mb-2">
                            <c:if test="${not empty product.images}">
                                <img src="${pageContext.request.contextPath}/image?fname=${product.images}" alt="${product.productName}" class="img-thumbnail" style="width: 120px; height: 120px; object-fit: cover;">
                            </c:if>
                        </div>
                    </div>

                    <div class="mb-4">
                        <label for="image" class="form-label fw-semibold">Ảnh sản phẩm mới</label>
                        <input type="file" class="form-control" id="image" name="image" accept=".jpg,.jpeg,image/jpeg">
                        <div class="form-text">Để trống nếu bạn không muốn thay đổi hình ảnh hiện tại.</div>
                    </div>

                    <div class="mb-4">
                        <label class="form-label fw-semibold text-muted">Danh mục</label>
                        <p class="form-control-plaintext fw-bold text-dark border rounded px-3 py-2 bg-light">${category.cateName}</p>
                    </div>

                    <div class="d-flex gap-2 pt-2">
                        <button type="submit" class="btn btn-primary px-4"><i class="bi bi-save me-2"></i>Cập nhật sản phẩm</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

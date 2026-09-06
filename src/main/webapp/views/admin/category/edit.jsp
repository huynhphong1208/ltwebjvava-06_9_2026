<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Chỉnh Sửa Danh Mục</title>
</head>
<body>

<div class="row justify-content-center">
    <div class="col-md-8 col-lg-6">
        <div class="card shadow-sm border-0">
            <div class="card-header bg-white border-bottom-0 pt-4 pb-0">
                <h3 class="card-title fw-bold text-primary mb-0"><i class="bi bi-pencil-square me-2"></i>Chỉnh Sửa Danh Mục</h3>
            </div>
            <div class="card-body p-4">
                <%
                    String error = (String) request.getAttribute("error");
                    if (error != null) {
                %>
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i><%= error %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <%
                    }
                %>

                <form method="post" action="${pageContext.request.contextPath}/admin/category/edit" enctype="multipart/form-data" class="needs-validation" novalidate>
                    <input type="hidden" name="cateId" value="${category.cateId}">

                    <div class="mb-3">
                        <label for="cateName" class="form-label fw-semibold">Tên danh mục <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="cateName" name="cateName" value="${category.cateName}" required maxlength="100">
                        <div class="invalid-feedback">
                            Vui lòng nhập tên danh mục (không quá 100 ký tự).
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Ảnh hiện tại</label>
                        <div class="mb-2">
                            <c:if test="${not empty category.icons}">
                                <img src="${pageContext.request.contextPath}/image?fname=${category.icons}" alt="${category.cateName}" class="img-thumbnail" style="width: 120px; height: 120px; object-fit: cover;">
                            </c:if>
                        </div>
                    </div>

                    <div class="mb-4">
                        <label for="icon" class="form-label fw-semibold">Chọn ảnh mới (nếu muốn thay đổi)</label>
                        <input type="file" class="form-control" id="icon" name="icon" accept=".jpg,.jpeg,image/jpeg">
                        <div class="form-text">Để trống nếu bạn không muốn thay đổi hình ảnh hiện tại.</div>
                    </div>

                    <div class="d-flex gap-2">
                        <button type="submit" class="btn btn-primary px-4"><i class="bi bi-save me-2"></i>Cập nhật</button>
                        <a href="${pageContext.request.contextPath}/admin/category/list" class="btn btn-light border px-4">Hủy</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

</body>
</html>
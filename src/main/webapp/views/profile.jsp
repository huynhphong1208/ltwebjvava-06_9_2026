<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <title>Hồ sơ cá nhân</title>
            <style>
                .profile-card {
                    background-color: #ffffff;
                    border-radius: 12px;
                    box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
                    padding: 2.5rem;
                    max-width: 650px;
                    margin: 0 auto;
                }

                .profile-header {
                    text-align: center;
                    margin-bottom: 2rem;
                }

                .profile-header h2 {
                    font-size: 1.5rem;
                    font-weight: 700;
                    color: #0f172a;
                    margin-bottom: 0.5rem;
                }

                .profile-header p {
                    color: #64748b;
                    font-size: 0.9rem;
                }

                .avatar-preview-container {
                    display: flex;
                    flex-direction: column;
                    align-items: center;
                    margin-bottom: 1.5rem;
                }

                .avatar-preview {
                    width: 110px;
                    height: 110px;
                    border-radius: 50%;
                    object-fit: cover;
                    border: 4px solid #3b82f6;
                    box-shadow: 0 4px 6px -1px rgba(59, 130, 246, 0.3);
                    margin-bottom: 1rem;
                }

                .form-group {
                    margin-bottom: 1.25rem;
                }

                .form-group label {
                    display: block;
                    font-weight: 600;
                    font-size: 0.875rem;
                    color: #334155;
                    margin-bottom: 0.5rem;
                }

                .form-control {
                    width: 100%;
                    padding: 0.75rem 1rem;
                    border: 1px solid #cbd5e1;
                    border-radius: 8px;
                    font-size: 0.95rem;
                    outline: none;
                    transition: border-color 0.2s;
                }

                .form-control:focus {
                    border-color: #2563eb;
                    box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.15);
                }

                .form-control[readonly] {
                    background-color: #f8fafc;
                    color: #64748b;
                    cursor: not-allowed;
                }

                .alert-message {
                    background-color: #dcfce7;
                    color: #166534;
                    padding: 0.85rem 1rem;
                    border-radius: 8px;
                    margin-bottom: 1.5rem;
                    font-weight: 500;
                    font-size: 0.9rem;
                    border: 1px solid #bbf7d0;
                }

                .btn-submit {
                    width: 100%;
                    padding: 0.85rem;
                    background-color: #2563eb;
                    color: #ffffff;
                    border: none;
                    border-radius: 8px;
                    font-size: 1rem;
                    font-weight: 600;
                    cursor: pointer;
                    transition: background-color 0.2s;
                }

                .btn-submit:hover {
                    background-color: #1d4ed8;
                }
            </style>
        </head>

        <body>
            <div class="profile-card">
                <div class="profile-header">
                    <h2>Hồ sơ cá nhân</h2>
                    <p>Quản lý và cập nhật thông tin tài khoản của bạn</p>
                </div>

                <c:if test="${not empty alert}">
                    <div class="alert-message">
                        ${alert}
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/profile" method="post" enctype="multipart/form-data">
                    <div class="avatar-preview-container">
                        <c:choose>
                            <c:when test="${not empty user.avatar}">
                                <img id="avatarImage"
                                    src="${pageContext.request.contextPath}/image?fname=${user.avatar}" alt="Avatar"
                                    class="avatar-preview">
                            </c:when>
                            <c:otherwise>
                                <img id="avatarImage"
                                    src="https://ui-avatars.com/api/?name=${user.fullName}&background=2563eb&color=fff&size=128"
                                    alt="Avatar" class="avatar-preview">
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="form-group">
                        <label>Tên tài khoản (Username)</label>
                        <input type="text" class="form-control" value="${user.userName}" readonly>
                    </div>

                    <div class="form-group">
                        <label>Email</label>
                        <input type="email" class="form-control" value="${user.email}" readonly>
                    </div>

                    <div class="form-group">
                        <label for="fullname">Họ và tên</label>
                        <input type="text" id="fullname" name="fullname" class="form-control" value="${user.fullName}"
                            required>
                    </div>

                    <div class="form-group">
                        <label for="phone">Số điện thoại</label>
                        <input type="text" id="phone" name="phone" class="form-control" value="${user.phone}">
                    </div>

                    <div class="form-group">
                        <label for="avatar">Ảnh đại diện mới (Multipart File Upload)</label>
                        <input type="file" id="avatar" name="avatar" class="form-control" accept="image/*"
                            onchange="previewFile()">
                    </div>

                    <button type="submit" class="btn-submit">Lưu thay đổi</button>
                </form>
            </div>

            <script>
                function previewFile() {
                    const preview = document.getElementById('avatarImage');
                    const file = document.getElementById('avatar').files[0];
                    const reader = new FileReader();

                    reader.addEventListener("load", function () {
                        preview.src = reader.result;
                    }, false);

                    if (file) {
                        reader.readAsDataURL(file);
                    }
                }
            </script>
        </body>

        </html>
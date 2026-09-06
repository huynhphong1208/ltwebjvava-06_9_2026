<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quên mật khẩu</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: Arial, sans-serif; }
        body { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 100vh; display: flex; align-items: center; justify-content: center; padding: 20px; }
        .container { background: white; padding: 40px; border-radius: 10px; box-shadow: 0 10px 25px rgba(0,0,0,0.2); width: 100%; max-width: 450px; }
        h2 { text-align: center; color: #333; margin-bottom: 20px; }
        .form-group { margin-bottom: 20px; }
        label { display: block; margin-bottom: 5px; color: #555; }
        input { width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 5px; font-size: 16px; }
        input:focus { outline: none; border-color: #667eea; }
        button { width: 100%; padding: 12px; background: #667eea; color: white; border: none; border-radius: 5px; font-size: 16px; cursor: pointer; margin-bottom: 10px; }
        button:hover { background: #5568d3; }
        .btn-secondary { background: #6c757d; }
        .btn-secondary:hover { background: #5a6268; }
        .alert { padding: 10px; margin-bottom: 20px; border-radius: 5px; text-align: center; }
        .alert-success { background: #d4edda; color: #155724; }
        .alert-error { background: #f8d7da; color: #721c24; }
        .hidden { display: none; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Quên mật khẩu</h2>
        <% if (request.getAttribute("alert") != null) { %>
            <div class="alert <%= request.getAttribute("alert").toString().contains("thành công") ? "alert-success" : "alert-error" %>">
                <%= request.getAttribute("alert") %>
            </div>
        <% } %>

        <!-- Bước 1: Nhập email để nhận OTP -->
        <form id="step1" action="${pageContext.request.contextPath}/forgot-password" method="post">
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required
                       value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>">
            </div>
            <button type="submit" name="action" value="send-otp">Gửi mã OTP</button>
        </form>

        <!-- Bước 2: Nhập OTP và mật khẩu mới -->
        <form id="step2" class="hidden" action="${pageContext.request.contextPath}/forgot-password" method="post">
            <div class="form-group">
                <label for="email2">Email:</label>
                <input type="email" id="email2" name="email" required readonly
                       value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>">
            </div>
            <div class="form-group">
                <label for="otp">Mã OTP:</label>
                <input type="text" id="otp" name="otp" required placeholder="Nhập mã 6 chữ số">
            </div>
            <div class="form-group">
                <label for="newPassword">Mật khẩu mới:</label>
                <input type="password" id="newPassword" name="newPassword" required>
            </div>
            <div class="form-group">
                <label for="confirmPassword">Xác nhận mật khẩu:</label>
                <input type="password" id="confirmPassword" name="confirmPassword" required>
            </div>
            <button type="submit" name="action" value="reset-password">Đổi mật khẩu</button>
            <button type="button" class="btn-secondary" onclick="showStep1()">Quay lại</button>
        </form>
    </div>

    <script>
        function showStep2() {
            document.getElementById('step1').classList.add('hidden');
            document.getElementById('step2').classList.remove('hidden');
        }
        function showStep1() {
            document.getElementById('step1').classList.remove('hidden');
            document.getElementById('step2').classList.add('hidden');
        }
        <% if (request.getAttribute("email") != null) { %>
            showStep2();
        <% } %>
    </script>
</body>
</html>
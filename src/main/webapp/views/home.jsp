<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang Chủ User</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Inter', sans-serif;
        }
        body {
            background-color: #f8fafc;
            color: #1e293b;
        }
        .main-container {
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 2rem;
            min-height: calc(100vh - 120px);
        }
        .welcome-card {
            background-color: #ffffff;
            padding: 3rem;
            border-radius: 16px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.03);
            text-align: center;
            max-width: 600px;
            width: 100%;
        }
        .welcome-card h1 {
            font-size: 2.25rem;
            font-weight: 700;
            color: #0f172a;
            margin-bottom: 1rem;
            line-height: 1.2;
        }
        .welcome-card p {
            font-size: 1.125rem;
            color: #64748b;
            margin-bottom: 2rem;
        }
        .status-badge {
            display: inline-block;
            background-color: #dcfce7;
            color: #15803d;
            font-weight: 600;
            padding: 0.5rem 1rem;
            border-radius: 9999px;
            font-size: 0.875rem;
            margin-bottom: 1.5rem;
            border: 1px solid #bbf7d0;
        }
    </style>
</head>
<body>
    <jsp:include page="topbar.jsp"/>
    
    <div class="main-container">
        <div class="welcome-card">
            <span class="status-badge">Thành viên Thường</span>
            <h1>Chào mừng bạn đến với hệ thống!</h1>
            <p>Trải nghiệm dịch vụ và các tiện ích dành riêng cho thành viên đã đăng ký tài khoản.</p>
        </div>
    </div>
</body>
</html>
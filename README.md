# Hướng Dẫn Sử Dụng & Chạy Dự Án (Java Web - Servlet & JPA/Hibernate)

Dự án Java Web quản lý Danh mục & Sản phẩm xây dựng trên nền tảng **Jakarta EE (Servlet/JSP)**, **JPA/Hibernate**, tích hợp trang trí giao diện bằng **SiteMesh 3** và **Bootstrap 5**.

---

## 🔑 Thông Tin Đăng Nhập Hệ Thống

Dưới đây là tài khoản quản trị viên (Admin) mặc định để kiểm thử hệ thống:

| Vai trò | Tên đăng nhập (Username) | Mật khẩu (Password) | Quyền hạn |
| :--- | :--- | :--- | :--- |
| **Admin Portal** | `admin` | `123456` | Quản lý Danh mục, Quản lý Sản phẩm |

> 📌 **Lưu ý**: Tài khoản admin có `roleid = 1` hoặc `roleid = 2` và `is_active = true` (đã được kích hoạt) trong cơ sở dữ liệu.

---

## 🛠 Hướng Dẫn Cấu Hình Cơ Sở Dữ Liệu SQL Server

1. **Thông tin kết nối DB** (cấu hình tại `src/main/resources/META-INF/persistence.xml`):
   - **Host/Port**: `localhost:1433`
   - **Tên Database**: `demo_db`
   - **User**: `sa`
   - **Password**: `123456`

2. **Khởi tạo dữ liệu mẫu (SQL Script)**:
   Mở SQL Server Management Studio (SSMS) và thực thi lệnh tạo tài khoản Admin mẫu nếu cơ sở dữ liệu chưa có:

```sql
USE demo_db;
GO

-- Chèn tài khoản admin (Password: 123456)
INSERT INTO users (username, password, email, fullname, phone, roleid, is_active, created_date)
VALUES ('admin', '123456', 'admin@example.com', N'Quản Trị Viên', '0987654321', 1, 1, GETDATE());
GO
```

---

## 🚀 Hướng Dẫn Khởi Chạy Dự Án

### Cách 1: Chạy trực tiếp trong IntelliJ IDEA
1. Mở dự án trong IntelliJ IDEA.
2. Cấu hình Server (Tomcat 10+ hỗ trợ Jakarta EE 10).
3. Đảm bảo file `persistence.xml` kết nối tới SQL Server thành công.
4. Chạy Tomcat Server. Dự án sẽ lắng nghe tại: `http://localhost:8080/`

### Cách 2: Chạy bằng Maven Command Line
```bash
# Biển dịch dự án
./mvnw clean package

# Hoặc dùng Maven Tomcat plugin (nếu có cấu hình)
```

---

## 📌 Danh Sách Các Chức Năng Chính

### 1. Trang Admin (`/admin/*`)
- **Đăng nhập**: `http://localhost:8080/login`
- **Quản lý Danh mục** (`/admin/category/list`): Xem, Thêm, Sửa, Xóa danh mục sản phẩm (hỗ trợ tải ảnh biểu tượng).
- **Quản lý Sản phẩm** (`/admin/product/list`): Xem sản phẩm theo từng danh mục, Thêm, Sửa, Xóa sản phẩm với thông tin Giá & Tồn kho.

### 2. Tính năng mở rộng & Bảo mật
- **Sitemesh 3 Decorator**: Tự động áp dụng khung giao diện chuẩn Admin với Bootstrap 5 & Bootstrap Icons.
- **Form Validation**: Kiểm tra dữ liệu đầu vào phía Client (HTML5 Validation) & phác thảo xử lý sự kiện phía Server.
- **Xác thực OTP qua Email**: Đăng ký tài khoản người dùng (`User`) và kích hoạt qua mã OTP được gửi đến Email.

---

## 🎨 Giao diện tiêu biểu
- **Bootstrap 5 UI**: Bảng dữ liệu tương tác, nút thao tác chuẩn UI/UX, badge trạng thái tồn kho linh hoạt.
- **Typography & Icons**: Sử dụng font Google Inter kết hợp Bootstrap Icons (`bi-box-seam`, `bi-grid-3x3-gap-fill`, ...).

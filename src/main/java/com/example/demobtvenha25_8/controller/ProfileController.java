package com.example.demobtvenha25_8.controller;

import com.example.demobtvenha25_8.model.User;
import com.example.demobtvenha25_8.service.UserService;
import com.example.demobtvenha25_8.service.impl.UserServiceImpl;
import com.example.demobtvenha25_8.util.Constant;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

@WebServlet(urlPatterns = {"/profile", "/user/profile"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10,      // 10MB
        maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class ProfileController extends HttpServlet {

    private final UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("account") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        User sessionUser = (User) session.getAttribute("account");
        User user = userService.get(sessionUser.getUserName());
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        req.setAttribute("user", user);
        req.getRequestDispatcher("/views/profile.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("account") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        User sessionUser = (User) session.getAttribute("account");
        User user = userService.get(sessionUser.getUserName());

        if (user != null) {
            String fullName = req.getParameter("fullname");
            String phone = req.getParameter("phone");

            if (fullName != null) {
                user.setFullName(fullName);
            }
            if (phone != null) {
                user.setPhone(phone);
            }

            // Xử lý upload file avatar (multipart)
            Part filePart = req.getPart("avatar");
            if (filePart != null && filePart.getSize() > 0) {
                String originalFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                String fileExtension = "";
                int i = originalFileName.lastIndexOf('.');
                if (i > 0) {
                    fileExtension = originalFileName.substring(i);
                }
                String newFileName = "user_" + user.getId() + "_" + System.currentTimeMillis() + fileExtension;

                Path uploadDir = Paths.get(Constant.UPLOAD_DIR).toAbsolutePath().normalize();
                if (!Files.exists(uploadDir)) {
                    Files.createDirectories(uploadDir);
                }

                // Xóa avatar cũ nếu có
                deleteOldAvatar(user.getAvatar());

                Path targetPath = uploadDir.resolve(newFileName);
                filePart.write(targetPath.toString());

                user.setAvatar(newFileName);
            }

            // Cập nhật thông tin User qua JPA
            userService.update(user);

            // Cập nhật lại thông tin mới trong session
            session.setAttribute("account", user);

            req.setAttribute("alert", "Cập nhật thông tin cá nhân thành công!");
            req.setAttribute("user", user);
        }

        req.getRequestDispatcher("/views/profile.jsp").forward(req, resp);
    }

    private void deleteOldAvatar(String avatarPath) {
        if (avatarPath == null || avatarPath.isBlank()) {
            return;
        }
        try {
            Path uploadRoot = Paths.get(Constant.UPLOAD_DIR).toAbsolutePath().normalize();
            Path oldFile = uploadRoot.resolve(avatarPath).normalize();
            if (oldFile.startsWith(uploadRoot) && Files.exists(oldFile)) {
                Files.delete(oldFile);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}

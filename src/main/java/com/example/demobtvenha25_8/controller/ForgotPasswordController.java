package com.example.demobtvenha25_8.controller;

import com.example.demobtvenha25_8.dao.jpa.impl.UserJpaDaoImpl;
import com.example.demobtvenha25_8.model.User;
import com.example.demobtvenha25_8.service.impl.OtpServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/forgot-password")
public class ForgotPasswordController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/views/forgot-password.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String email = req.getParameter("email");
        String action = req.getParameter("action");

        UserJpaDaoImpl userDao = new UserJpaDaoImpl();
        OtpServiceImpl otpService = new OtpServiceImpl();

        if ("send-otp".equals(action)) {
            // 1. Kiểm tra email có tồn tại không
            User user = userDao.findByEmail(email);
            if (user == null) {
                req.setAttribute("alert", "Email không tồn tại trong hệ thống!");
                req.getRequestDispatcher("/views/forgot-password.jsp").forward(req, resp);
                return;
            }

            // 2. Gửi OTP
            otpService.generateAndSendOtp(email);
            req.setAttribute("email", email);
            req.setAttribute("alert", "Mã OTP đã được gửi đến email của bạn!");
            req.getRequestDispatcher("/views/forgot-password.jsp").forward(req, resp);

        } else if ("reset-password".equals(action)) {
            // 1. Kiểm tra OTP
            String otp = req.getParameter("otp");
            String newPassword = req.getParameter("newPassword");
            String confirmPassword = req.getParameter("confirmPassword");

            if (!otpService.verifyOtp(email, otp)) {
                req.setAttribute("alert", "Mã OTP không đúng hoặc đã hết hạn!");
                req.setAttribute("email", email);
                req.getRequestDispatcher("/views/forgot-password.jsp").forward(req, resp);
                return;
            }

            // 2. Kiểm tra mật khẩu xác nhận
            if (!newPassword.equals(confirmPassword)) {
                req.setAttribute("alert", "Mật khẩu xác nhận không khớp!");
                req.setAttribute("email", email);
                req.getRequestDispatcher("/views/forgot-password.jsp").forward(req, resp);
                return;
            }

            // 3. Cập nhật mật khẩu mới
            User user = userDao.findByEmail(email);
            if (user != null) {
                user.setPassword(newPassword);
                userDao.update(user);
                req.setAttribute("alert", "Đổi mật khẩu thành công! Vui lòng đăng nhập.");
                req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
            }
        }
    }
}
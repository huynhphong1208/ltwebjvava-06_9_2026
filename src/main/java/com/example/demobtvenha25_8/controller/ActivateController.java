package com.example.demobtvenha25_8.controller;

import com.example.demobtvenha25_8.dao.jpa.impl.UserJpaDaoImpl;
import com.example.demobtvenha25_8.model.User;
import com.example.demobtvenha25_8.service.impl.OtpServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/activate")
public class ActivateController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/views/activate.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String email = req.getParameter("email");
        String otp = req.getParameter("otp");

        OtpServiceImpl otpService = new OtpServiceImpl();

        // 1. Kiểm tra OTP
        if (!otpService.verifyOtp(email, otp)) {
            req.setAttribute("alert", "Mã OTP không đúng hoặc đã hết hạn!");
            req.getRequestDispatcher("/views/activate.jsp").forward(req, resp);
            return;
        }

        // 2. Kích hoạt tài khoản
        UserJpaDaoImpl userDao = new UserJpaDaoImpl();
        User user = userDao.findByEmail(email);

        if (user == null) {
            req.setAttribute("alert", "Không tìm thấy tài khoản với email này!");
            req.getRequestDispatcher("/views/activate.jsp").forward(req, resp);
            return;
        }

        user.setActive(true);
        userDao.update(user);

        req.setAttribute("alert", "Kích hoạt tài khoản thành công! Vui lòng đăng nhập.");
        req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
    }
}

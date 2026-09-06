package com.example.demobtvenha25_8.service.impl;

import com.example.demobtvenha25_8.dao.jpa.UserJpaDao;
import com.example.demobtvenha25_8.dao.jpa.impl.UserJpaDaoImpl;
import com.example.demobtvenha25_8.model.User;
import com.example.demobtvenha25_8.service.UserService;
import com.example.demobtvenha25_8.service.OtpService;
import com.example.demobtvenha25_8.service.impl.OtpServiceImpl;
public class UserServiceImpl implements UserService {
    private UserJpaDao userJpaDao = new UserJpaDaoImpl();

    @Override
    public User login(String username, String password) {
        User user = this.get(username);
        if (user != null && password.equals(user.getPassword())) {
            // Kiểm tra tài khoản đã được kích hoạt chưa
            // Nếu isActive là null (user cũ chưa có field này), coi như đã kích hoạt
            if (user.isActive() != null && !user.isActive()) {
                throw new RuntimeException("Tài khoản chưa được kích hoạt! Vui lòng kiểm tra email để kích hoạt.");
            }
            return user;
        }
        return null;
    }

    @Override
    public User get(String username) {
        return userJpaDao.findByUsername(username);
    }

    @Override
    public boolean register(String username, String password, String email, String fullname, String phone) {
        // 1. Kiểm tra tài khoản đã tồn tại chưa
        if (userJpaDao.existsByUsername(username)) {
            return false;
        }

        // 2. Tạo đối tượng User mới (mặc định roleid = 3, is_active = false)
        long millis = System.currentTimeMillis();
        java.sql.Date date = new java.sql.Date(millis);

        User newUser = new User();
        newUser.setUserName(username);
        newUser.setPassword(password);
        newUser.setEmail(email);
        newUser.setFullName(fullname);
        newUser.setPhone(phone);
        newUser.setRoleid(3); // Mặc định là User
        newUser.setCreatedDate(date);
        newUser.setActive(false); // Chưa kích hoạt

        userJpaDao.save(newUser);

        // 3. Gửi OTP để kích hoạt tài khoản
        OtpService otpService = new OtpServiceImpl();
        otpService.generateAndSendOtp(email);

        return true;
    }

    @Override
    public void update(User user) {
        userJpaDao.update(user);
    }
}

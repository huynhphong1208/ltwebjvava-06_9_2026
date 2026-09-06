package com.example.demobtvenha25_8.service.impl;

import com.example.demobtvenha25_8.dao.jpa.IOtpDao;
import com.example.demobtvenha25_8.dao.jpa.impl.OtpDaoImpl;
import com.example.demobtvenha25_8.model.Otp;
import com.example.demobtvenha25_8.service.OtpService;
import com.example.demobtvenha25_8.util.EmailUtil;

import java.sql.Timestamp;
import java.util.Random;

public class OtpServiceImpl implements OtpService {
    private IOtpDao otpDao = new OtpDaoImpl();

    @Override
    public String generateAndSendOtp(String email) {
        // 1. Hủy các OTP cũ của email này
        otpDao.invalidateOldOtps(email);

        // 2. Tạo mã OTP 6 chữ số
        String otpCode = String.format("%06d", new Random().nextInt(999999));

        // 3. Tính thời gian hết hạn (5 phút)
        Timestamp expiryTime = new Timestamp(System.currentTimeMillis() + 5 * 60 * 1000);

        // 4. Lưu OTP vào database
        Otp otp = new Otp(email, otpCode, expiryTime);
        otpDao.save(otp);

        // 5. Gửi OTP qua email
        EmailUtil.sendOTPEmail(email, otpCode);

        return otpCode;
    }

    @Override
    public boolean verifyOtp(String email, String otpCode) {
        // 1. Tìm OTP còn hiệu lực
        Otp otp = otpDao.findLatestValidOtp(email);

        // 2. Kiểm tra OTP có tồn tại và mã đúng không
        if (otp == null || !otp.getOtpCode().equals(otpCode)) {
            return false;
        }

        // 3. Đánh dấu OTP đã dùng
        otpDao.markAsUsed(otp.getId());

        return true;
    }
}
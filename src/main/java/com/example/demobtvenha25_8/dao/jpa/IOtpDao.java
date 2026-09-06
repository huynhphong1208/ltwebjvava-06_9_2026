package com.example.demobtvenha25_8.dao.jpa;

import com.example.demobtvenha25_8.model.Otp;

public interface IOtpDao {
    Otp save(Otp otp);
    Otp findLatestValidOtp(String email);
    boolean markAsUsed(int otpId);
    void invalidateOldOtps(String email);
}
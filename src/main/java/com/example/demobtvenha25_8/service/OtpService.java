package com.example.demobtvenha25_8.service;

import com.example.demobtvenha25_8.model.Otp;

public interface OtpService {
    String generateAndSendOtp(String email);
    boolean verifyOtp(String email, String otpCode);
}
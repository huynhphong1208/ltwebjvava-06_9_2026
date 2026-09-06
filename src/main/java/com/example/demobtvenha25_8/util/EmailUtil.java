package com.example.demobtvenha25_8.util;

import java.io.InputStream;
import java.util.Properties;
import jakarta.mail.*;
import jakarta.mail.internet.*;

public class EmailUtil {

    private static Properties loadConfig() {
        Properties props = new Properties();
        try (InputStream input = EmailUtil.class.getClassLoader()
                .getResourceAsStream("config/email.properties")) {
            if (input == null) {
                throw new RuntimeException("Không tìm thấy file config/email.properties");
            }
            props.load(input);
        } catch (Exception e) {
            throw new RuntimeException("Lỗi khi load config email: " + e.getMessage(), e);
        }
        return props;
    }

    public static void sendEmail(String toEmail, String subject, String content) {
        Properties config = loadConfig();

        Properties mailProps = new Properties();
        mailProps.put("mail.smtp.host", config.getProperty("mail.smtp.host"));
        mailProps.put("mail.smtp.port", config.getProperty("mail.smtp.port"));
        mailProps.put("mail.smtp.auth", config.getProperty("mail.smtp.auth"));
        mailProps.put("mail.smtp.starttls.enable", config.getProperty("mail.smtp.starttls.enable"));

        String username = config.getProperty("mail.username");
        String password = config.getProperty("mail.password");
        String fromEmail = config.getProperty("mail.from");
        String fromName = config.getProperty("mail.from.name");

        Session session = Session.getInstance(mailProps, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromEmail, fromName));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject);
            message.setContent(content, "text/html; charset=UTF-8");

            Transport.send(message);
            System.out.println("Email đã gửi thành công đến: " + toEmail);
        } catch (Exception e) {
            throw new RuntimeException("Lỗi khi gửi email: " + e.getMessage(), e);
        }
    }

    public static void sendOTPEmail(String toEmail, String otp) {
        String subject = "Mã xác nhận OTP của bạn";
        String content = """
            <div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px;">
                <h2 style="color: #333;">Xác nhận tài khoản</h2>
                <p>Mã OTP của bạn là:</p>
                <div style="background-color: #f0f0f0; padding: 15px; text-align: center; font-size: 24px; font-weight: bold; letter-spacing: 5px; margin: 20px 0;">
                    %s
                </div>
                <p>Mã này sẽ hết hạn sau 5 phút.</p>
                <p style="color: #666; font-size: 12px;">Nếu bạn không yêu cầu mã này, vui lòng bỏ qua email này.</p>
            </div>
            """.formatted(otp);

        sendEmail(toEmail, subject, content);
    }
}
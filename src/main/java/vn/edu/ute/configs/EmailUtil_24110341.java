package vn.edu.ute.configs;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Properties;

public class EmailUtil_24110341 {
    // Có thể cấu hình email và app password của bạn khi chạy thực tế
    private static final String FROM_EMAIL = "vovanthinh2006@gmail.com";
    private static final String APP_PASSWORD = "gbba noxq xszh tmsl";
    public static boolean sendOtpEmail(String toEmail, String otpCode) {
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_EMAIL, APP_PASSWORD);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL, "Web_De05_24110341 Support"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Mã xác thực OTP đăng ký tài khoản");
            message.setText("Xin chào,\n\nMã OTP kích hoạt tài khoản của bạn là: " + otpCode + "\nMã có hiệu lực trong 5 phút.\n\nTrân trọng!");

            Transport.send(message);
            System.out.println(">>> Đã gửi mã OTP đến email " + toEmail + " | MÃ OTP: " + otpCode);
            return true;
        } catch (Exception e) {
            System.err.println("Lỗi gửi email: " + e.getMessage());
            return false;
        }
    }
}

package vn.edu.ute.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.edu.ute.service.IUserService_24110341;
import vn.edu.ute.service.impl.UserServiceImpl_24110341;
import java.io.IOException;

@WebServlet(urlPatterns = "/verify-otp")
public class VerifyOtpController_24110341 extends HttpServlet {
    private final IUserService_24110341 userService = new UserServiceImpl_24110341();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/auth/verify-otp.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String otp = req.getParameter("otp");

        boolean verified = userService.verifyOtp(email, otp);
        if (verified) {
            req.getSession().removeAttribute("pendingEmail");
            resp.sendRedirect(req.getContextPath() + "/login?message=active_success");
        } else {
            req.setAttribute("error", "Mã OTP không chính xác hoặc đã hết hạn!");
            req.setAttribute("email", email);
            req.getRequestDispatcher("/WEB-INF/views/auth/verify-otp.jsp").forward(req, resp);
        }
    }
}

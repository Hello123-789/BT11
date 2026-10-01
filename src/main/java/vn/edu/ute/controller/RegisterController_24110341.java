package vn.edu.ute.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.edu.ute.entity.User_24110341;
import vn.edu.ute.entity.UserRole_24110341;
import vn.edu.ute.service.IUserService_24110341;
import vn.edu.ute.service.impl.UserServiceImpl_24110341;
import java.io.IOException;

@WebServlet(urlPatterns = "/register")
public class RegisterController_24110341 extends HttpServlet {
    private final IUserService_24110341 userService = new UserServiceImpl_24110341();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String username = req.getParameter("username");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String fullname = req.getParameter("fullname");
        String phone = req.getParameter("phone");

        User_24110341 user = new User_24110341();
        user.setUsername(username);
        user.setEmail(email);
        user.setPassword(password);
        user.setFullname(fullname);
        user.setPhone(phone);
        
        // Mặc định role USER (ID: 3)
        UserRole_24110341 role = new UserRole_24110341();
        role.setRoleId(3);
        user.setRole(role);

        boolean success = userService.register(user);
        if (success) {
            req.getSession().setAttribute("pendingEmail", email);
            resp.sendRedirect(req.getContextPath() + "/verify-otp");
        } else {
            req.setAttribute("error", "Username hoặc Email đã tồn tại!");
            req.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(req, resp);
        }
    }
}

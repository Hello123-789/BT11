package vn.edu.ute.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.edu.ute.entity.User_24110341;
import vn.edu.ute.service.IUserService_24110341;
import vn.edu.ute.service.impl.UserServiceImpl_24110341;
import java.io.IOException;

@WebServlet(urlPatterns = "/login")
public class LoginController_24110341 extends HttpServlet {
    private final IUserService_24110341 userService = new UserServiceImpl_24110341();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String u = req.getParameter("username");
        String p = req.getParameter("password");

        User_24110341 user = userService.login(u, p);
        if (user != null) {
            HttpSession session = req.getSession();
            session.setAttribute("currentUser", user);

            // Điều hướng đúng theo đề thi và vai trò:
            // 1. Admin -> Trang quản trị Admin
            // 2. Seller -> Kênh người bán Seller (quản lý, tìm kiếm & phân trang sản phẩm của shop)
            // 3. User -> Trang mua sắm User (tìm kiếm & phân trang tất cả sản phẩm)
            if (user.getRole() != null && "ADMIN".equalsIgnoreCase(user.getRole().getRoleName())) {
                resp.sendRedirect(req.getContextPath() + "/admin/products");
            } else if (user.getSeller() != null || (user.getRole() != null && "SELLER".equalsIgnoreCase(user.getRole().getRoleName()))) {
                resp.sendRedirect(req.getContextPath() + "/seller/products");
            } else {
                resp.sendRedirect(req.getContextPath() + "/products");
            }
        } else {
            req.setAttribute("error", "Tên đăng nhập hoặc mật khẩu sai, hoặc tài khoản chưa kích hoạt OTP!");
            req.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(req, resp);
        }
    }
}

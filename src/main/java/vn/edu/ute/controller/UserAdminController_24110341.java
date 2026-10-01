package vn.edu.ute.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.edu.ute.dao.IUserRoleDao_24110341;
import vn.edu.ute.dao.impl.UserRoleDaoImpl_24110341;
import vn.edu.ute.entity.Seller_24110341;
import vn.edu.ute.entity.UserRole_24110341;
import vn.edu.ute.entity.User_24110341;
import vn.edu.ute.service.ISellerService_24110341;
import vn.edu.ute.service.IUserService_24110341;
import vn.edu.ute.service.impl.SellerServiceImpl_24110341;
import vn.edu.ute.service.impl.UserServiceImpl_24110341;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/admin/users", "/admin/user/add", "/admin/user/edit", "/admin/user/delete"})
public class UserAdminController_24110341 extends HttpServlet {
    private final IUserService_24110341 userService = new UserServiceImpl_24110341();
    private final IUserRoleDao_24110341 roleDao = new UserRoleDaoImpl_24110341();
    private final ISellerService_24110341 sellerService = new SellerServiceImpl_24110341();
    private static final int PAGE_SIZE = 5;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        if (path.endsWith("/add")) {
            req.setAttribute("roles", roleDao.findAll());
            req.setAttribute("sellers", sellerService.findAll());
            req.getRequestDispatcher("/WEB-INF/views/admin/user/form.jsp").forward(req, resp);
        } else if (path.endsWith("/edit")) {
            int id = Integer.parseInt(req.getParameter("id"));
            req.setAttribute("user", userService.findById(id));
            req.setAttribute("roles", roleDao.findAll());
            req.setAttribute("sellers", sellerService.findAll());
            req.getRequestDispatcher("/WEB-INF/views/admin/user/form.jsp").forward(req, resp);
        } else if (path.endsWith("/delete")) {
            int id = Integer.parseInt(req.getParameter("id"));
            userService.delete(id);
            resp.sendRedirect(req.getContextPath() + "/admin/users");
        } else {
            int page = 1;
            try {
                page = Integer.parseInt(req.getParameter("page"));
            } catch (Exception ignored) {}

            int totalItems = userService.count();
            int totalPages = (int) Math.ceil((double) totalItems / PAGE_SIZE);
            if (totalPages == 0) totalPages = 1;

            List<User_24110341> list = userService.findAll(page, PAGE_SIZE);
            req.setAttribute("userList", list);
            req.setAttribute("currentPage", page);
            req.setAttribute("totalPages", totalPages);

            req.getRequestDispatcher("/WEB-INF/views/admin/user/list.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String idStr = req.getParameter("userId");
        String username = req.getParameter("username");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String fullname = req.getParameter("fullname");
        String phone = req.getParameter("phone");
        String images = req.getParameter("images");
        int status = Integer.parseInt(req.getParameter("status"));
        int roleId = Integer.parseInt(req.getParameter("roleId"));
        String sellerIdStr = req.getParameter("sellerId");

        User_24110341 user = new User_24110341();
        user.setUsername(username);
        user.setEmail(email);
        user.setPassword(password);
        user.setFullname(fullname);
        user.setPhone(phone);
        user.setImages(images);
        user.setStatus(status);

        UserRole_24110341 role = roleDao.findById(roleId);
        user.setRole(role);

        if (sellerIdStr != null && !sellerIdStr.trim().isEmpty() && !sellerIdStr.equals("0")) {
            Seller_24110341 seller = sellerService.findById(Integer.parseInt(sellerIdStr));
            user.setSeller(seller);
        } else {
            user.setSeller(null);
        }

        if (idStr == null || idStr.trim().isEmpty()) {
            userService.insert(user);
        } else {
            user.setUserId(Integer.parseInt(idStr));
            userService.update(user);
        }
        resp.sendRedirect(req.getContextPath() + "/admin/users");
    }
}

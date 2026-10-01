package vn.edu.ute.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.edu.ute.entity.Seller_24110341;
import vn.edu.ute.service.ISellerService_24110341;
import vn.edu.ute.service.impl.SellerServiceImpl_24110341;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/admin/sellers", "/admin/seller/add", "/admin/seller/edit", "/admin/seller/delete"})
public class SellerAdminController_24110341 extends HttpServlet {
    private final ISellerService_24110341 sellerService = new SellerServiceImpl_24110341();
    private static final int PAGE_SIZE = 5;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        if (path.endsWith("/add")) {
            req.getRequestDispatcher("/WEB-INF/views/admin/seller/form.jsp").forward(req, resp);
        } else if (path.endsWith("/edit")) {
            int id = Integer.parseInt(req.getParameter("id"));
            req.setAttribute("seller", sellerService.findById(id));
            req.getRequestDispatcher("/WEB-INF/views/admin/seller/form.jsp").forward(req, resp);
        } else if (path.endsWith("/delete")) {
            int id = Integer.parseInt(req.getParameter("id"));
            sellerService.delete(id);
            resp.sendRedirect(req.getContextPath() + "/admin/sellers");
        } else {
            int page = 1;
            try {
                page = Integer.parseInt(req.getParameter("page"));
            } catch (Exception ignored) {}

            int totalItems = sellerService.count();
            int totalPages = (int) Math.ceil((double) totalItems / PAGE_SIZE);
            if (totalPages == 0) totalPages = 1;

            List<Seller_24110341> list = sellerService.findAll(page, PAGE_SIZE);
            req.setAttribute("sellerList", list);
            req.setAttribute("currentPage", page);
            req.setAttribute("totalPages", totalPages);

            req.getRequestDispatcher("/WEB-INF/views/admin/seller/list.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String idStr = req.getParameter("sellerId");
        String sellername = req.getParameter("sellername");
        String images = req.getParameter("images");
        int status = Integer.parseInt(req.getParameter("status"));

        Seller_24110341 seller = new Seller_24110341();
        seller.setSellername(sellername);
        seller.setImages(images);
        seller.setStatus(status);

        if (idStr == null || idStr.trim().isEmpty()) {
            sellerService.insert(seller);
        } else {
            seller.setSellerId(Integer.parseInt(idStr));
            sellerService.update(seller);
        }
        resp.sendRedirect(req.getContextPath() + "/admin/sellers");
    }
}

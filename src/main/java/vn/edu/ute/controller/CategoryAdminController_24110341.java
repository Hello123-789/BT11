package vn.edu.ute.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.edu.ute.entity.Category_24110341;
import vn.edu.ute.service.ICategoryService_24110341;
import vn.edu.ute.service.impl.CategoryServiceImpl_24110341;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/admin/categories", "/admin/category/add", "/admin/category/edit", "/admin/category/delete"})
public class CategoryAdminController_24110341 extends HttpServlet {
    private final ICategoryService_24110341 categoryService = new CategoryServiceImpl_24110341();
    private static final int PAGE_SIZE = 5;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        if (path.endsWith("/add")) {
            req.getRequestDispatcher("/WEB-INF/views/admin/category/form.jsp").forward(req, resp);
        } else if (path.endsWith("/edit")) {
            int id = Integer.parseInt(req.getParameter("id"));
            Category_24110341 cat = categoryService.findById(id);
            req.setAttribute("category", cat);
            req.getRequestDispatcher("/WEB-INF/views/admin/category/form.jsp").forward(req, resp);
        } else if (path.endsWith("/delete")) {
            int id = Integer.parseInt(req.getParameter("id"));
            categoryService.delete(id);
            resp.sendRedirect(req.getContextPath() + "/admin/categories");
        } else {
            int page = 1;
            try {
                page = Integer.parseInt(req.getParameter("page"));
            } catch (Exception ignored) {}

            int totalItems = categoryService.count();
            int totalPages = (int) Math.ceil((double) totalItems / PAGE_SIZE);
            if (totalPages == 0) totalPages = 1;

            List<Category_24110341> list = categoryService.findAll(page, PAGE_SIZE);
            req.setAttribute("categoryList", list);
            req.setAttribute("currentPage", page);
            req.setAttribute("totalPages", totalPages);

            req.getRequestDispatcher("/WEB-INF/views/admin/category/list.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String idStr = req.getParameter("categoryId");
        String name = req.getParameter("categoryName");
        String images = req.getParameter("images");
        int status = Integer.parseInt(req.getParameter("status"));

        Category_24110341 cat = new Category_24110341();
        cat.setCategoryName(name);
        cat.setImages(images);
        cat.setStatus(status);

        if (idStr == null || idStr.trim().isEmpty()) {
            categoryService.insert(cat);
        } else {
            cat.setCategoryId(Integer.parseInt(idStr));
            categoryService.update(cat);
        }
        resp.sendRedirect(req.getContextPath() + "/admin/categories");
    }
}

package vn.edu.ute.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.edu.ute.entity.Category_24110341;
import vn.edu.ute.entity.Product_24110341;
import vn.edu.ute.entity.Seller_24110341;
import vn.edu.ute.entity.User_24110341;
import vn.edu.ute.service.ICategoryService_24110341;
import vn.edu.ute.service.IProductService_24110341;
import vn.edu.ute.service.ISellerService_24110341;
import vn.edu.ute.service.impl.CategoryServiceImpl_24110341;
import vn.edu.ute.service.impl.ProductServiceImpl_24110341;
import vn.edu.ute.service.impl.SellerServiceImpl_24110341;
import java.io.IOException;
import java.util.Date;
import java.util.List;

@WebServlet(urlPatterns = {"/seller/products", "/seller/product/add", "/seller/product/edit", "/seller/product/delete"})
public class SellerProductController_24110341 extends HttpServlet {
    private final IProductService_24110341 productService = new ProductServiceImpl_24110341();
    private final ICategoryService_24110341 categoryService = new CategoryServiceImpl_24110341();
    private final ISellerService_24110341 sellerService = new SellerServiceImpl_24110341();
    private static final int PAGE_SIZE = 5;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User_24110341 currentUser = (User_24110341) session.getAttribute("currentUser");

        // Kiểm tra quyền Seller
        if (currentUser == null || currentUser.getSeller() == null) {
            resp.sendRedirect(req.getContextPath() + "/login?error=seller_required");
            return;
        }

        int sellerId = currentUser.getSeller().getSellerId();
        String path = req.getServletPath();

        if (path.endsWith("/add")) {
            req.setAttribute("categories", categoryService.findAll());
            req.getRequestDispatcher("/WEB-INF/views/seller/product/form.jsp").forward(req, resp);
        } else if (path.endsWith("/edit")) {
            int id = Integer.parseInt(req.getParameter("id"));
            Product_24110341 product = productService.findById(id);
            // Đảm bảo chỉ sửa sản phẩm của chính seller mình
            if (product != null && product.getSeller() != null && product.getSeller().getSellerId() == sellerId) {
                req.setAttribute("product", product);
                req.setAttribute("categories", categoryService.findAll());
                req.getRequestDispatcher("/WEB-INF/views/seller/product/form.jsp").forward(req, resp);
            } else {
                resp.sendRedirect(req.getContextPath() + "/seller/products");
            }
        } else if (path.endsWith("/delete")) {
            int id = Integer.parseInt(req.getParameter("id"));
            Product_24110341 product = productService.findById(id);
            if (product != null && product.getSeller() != null && product.getSeller().getSellerId() == sellerId) {
                productService.delete(id);
            }
            resp.sendRedirect(req.getContextPath() + "/seller/products");
        } else {
            // Danh sách sản phẩm của Seller có Tìm Kiếm & Phân Trang
            String keyword = req.getParameter("keyword");
            String categoryIdStr = req.getParameter("categoryId");
            Integer categoryId = (categoryIdStr != null && !categoryIdStr.trim().isEmpty() && !categoryIdStr.equals("0")) ? Integer.parseInt(categoryIdStr) : null;

            int page = 1;
            try {
                page = Integer.parseInt(req.getParameter("page"));
            } catch (Exception ignored) {}

            int totalItems = productService.countSearch(keyword, categoryId, sellerId);
            int totalPages = (int) Math.ceil((double) totalItems / PAGE_SIZE);
            if (totalPages == 0) totalPages = 1;

            List<Product_24110341> list = productService.searchAndPaginate(keyword, categoryId, sellerId, page, PAGE_SIZE);

            req.setAttribute("productList", list);
            req.setAttribute("categories", categoryService.findAll());
            req.setAttribute("keyword", keyword);
            req.setAttribute("selectedCategory", categoryId);
            req.setAttribute("currentPage", page);
            req.setAttribute("totalPages", totalPages);
            req.setAttribute("totalItems", totalItems);
            req.setAttribute("sellerInfo", currentUser.getSeller());

            req.getRequestDispatcher("/WEB-INF/views/seller/product/list.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User_24110341 currentUser = (User_24110341) session.getAttribute("currentUser");

        if (currentUser == null || currentUser.getSeller() == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        req.setCharacterEncoding("UTF-8");
        String idStr = req.getParameter("productId");
        String name = req.getParameter("productName");
        Long code = Long.parseLong(req.getParameter("productCode"));
        int categoryId = Integer.parseInt(req.getParameter("categoryId"));
        Double price = Double.parseDouble(req.getParameter("price"));
        int amount = Integer.parseInt(req.getParameter("amount"));
        int stock = Integer.parseInt(req.getParameter("stock"));
        String images = req.getParameter("images");
        String desc = req.getParameter("description");
        int status = Integer.parseInt(req.getParameter("status"));

        Product_24110341 product = new Product_24110341();
        product.setProductName(name);
        product.setProductCode(code);
        product.setPrice(price);
        product.setAmount(amount);
        product.setStock(stock);
        product.setImages(images);
        product.setDescription(desc);
        product.setStatus(status);
        product.setCreateDate(new Date());

        Category_24110341 c = new Category_24110341();
        c.setCategoryId(categoryId);
        product.setCategory(c);

        // Gắn chính Seller đang đăng nhập
        product.setSeller(currentUser.getSeller());

        if (idStr == null || idStr.trim().isEmpty()) {
            productService.insert(product);
        } else {
            product.setProductId(Integer.parseInt(idStr));
            productService.update(product);
        }
        resp.sendRedirect(req.getContextPath() + "/seller/products");
    }
}

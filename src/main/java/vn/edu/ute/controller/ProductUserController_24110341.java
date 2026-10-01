package vn.edu.ute.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.edu.ute.entity.Product_24110341;
import vn.edu.ute.service.ICategoryService_24110341;
import vn.edu.ute.service.IProductService_24110341;
import vn.edu.ute.service.ISellerService_24110341;
import vn.edu.ute.service.impl.CategoryServiceImpl_24110341;
import vn.edu.ute.service.impl.ProductServiceImpl_24110341;
import vn.edu.ute.service.impl.SellerServiceImpl_24110341;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = "/products")
public class ProductUserController_24110341 extends HttpServlet {
    private final IProductService_24110341 productService = new ProductServiceImpl_24110341();
    private final ICategoryService_24110341 categoryService = new CategoryServiceImpl_24110341();
    private final ISellerService_24110341 sellerService = new SellerServiceImpl_24110341();
    private static final int PAGE_SIZE = 6; // 6 sản phẩm mỗi trang cho User

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String keyword = req.getParameter("keyword");
        String categoryIdStr = req.getParameter("categoryId");
        String sellerIdStr = req.getParameter("sellerId");
        String pageStr = req.getParameter("page");

        Integer categoryId = (categoryIdStr != null && !categoryIdStr.trim().isEmpty() && !categoryIdStr.equals("0")) ? Integer.parseInt(categoryIdStr) : null;
        Integer sellerId = (sellerIdStr != null && !sellerIdStr.trim().isEmpty() && !sellerIdStr.equals("0")) ? Integer.parseInt(sellerIdStr) : null;

        int page = 1;
        try {
            if (pageStr != null && !pageStr.trim().isEmpty()) {
                page = Integer.parseInt(pageStr);
            }
        } catch (Exception ignored) {}

        int totalItems = productService.countSearch(keyword, categoryId, sellerId);
        int totalPages = (int) Math.ceil((double) totalItems / PAGE_SIZE);
        if (totalPages == 0) totalPages = 1;

        List<Product_24110341> productList = productService.searchAndPaginate(keyword, categoryId, sellerId, page, PAGE_SIZE);

        req.setAttribute("productList", productList);
        req.setAttribute("categories", categoryService.findAll());
        req.setAttribute("sellers", sellerService.findAll());
        req.setAttribute("keyword", keyword);
        req.setAttribute("selectedCategory", categoryId);
        req.setAttribute("selectedSeller", sellerId);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("totalItems", totalItems);

        req.getRequestDispatcher("/WEB-INF/views/product/user-products.jsp").forward(req, resp);
    }
}

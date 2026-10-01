package vn.edu.ute.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.edu.ute.entity.Product_24110341;
import vn.edu.ute.service.IProductService_24110341;
import vn.edu.ute.service.impl.ProductServiceImpl_24110341;
import java.io.IOException;

@WebServlet(urlPatterns = "/product/detail")
public class ProductDetailController_24110341 extends HttpServlet {
    private final IProductService_24110341 productService = new ProductServiceImpl_24110341();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            Product_24110341 product = productService.findById(id);
            if (product != null) {
                req.setAttribute("product", product);
                req.getRequestDispatcher("/WEB-INF/views/product/product-detail.jsp").forward(req, resp);
                return;
            }
        } catch (Exception ignored) {}
        resp.sendRedirect(req.getContextPath() + "/products/seller");
    }
}

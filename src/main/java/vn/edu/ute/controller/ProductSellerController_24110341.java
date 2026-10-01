package vn.edu.ute.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.edu.ute.entity.Product_24110341;
import vn.edu.ute.entity.Seller_24110341;
import vn.edu.ute.service.IProductService_24110341;
import vn.edu.ute.service.ISellerService_24110341;
import vn.edu.ute.service.impl.ProductServiceImpl_24110341;
import vn.edu.ute.service.impl.SellerServiceImpl_24110341;
import java.io.IOException;
import java.util.*;

@WebServlet(urlPatterns = "/products/seller")
public class ProductSellerController_24110341 extends HttpServlet {
    private final ISellerService_24110341 sellerService = new SellerServiceImpl_24110341();
    private final IProductService_24110341 productService = new ProductServiceImpl_24110341();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Seller_24110341> sellers = sellerService.findAll();
        Map<Seller_24110341, List<Product_24110341>> sellerProductMap = new LinkedHashMap<>();

        for (Seller_24110341 seller : sellers) {
            List<Product_24110341> products = productService.findBySellerId(seller.getSellerId());
            sellerProductMap.put(seller, products);
        }

        req.setAttribute("sellerProductMap", sellerProductMap);
        req.getRequestDispatcher("/WEB-INF/views/product/seller-products.jsp").forward(req, resp);
    }
}

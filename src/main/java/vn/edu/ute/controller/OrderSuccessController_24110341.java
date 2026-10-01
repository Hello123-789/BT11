package vn.edu.ute.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.ute.entity.CartItem_24110341;
import vn.edu.ute.entity.Cart_24110341;
import vn.edu.ute.service.ICartService_24110341;
import vn.edu.ute.service.impl.CartServiceImpl_24110341;

import java.io.IOException;
import java.util.List;

@WebServlet("/order-success")
public class OrderSuccessController_24110341 extends HttpServlet {

    private final ICartService_24110341 cartService = new CartServiceImpl_24110341();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idParam = req.getParameter("orderId");
        if (idParam == null || idParam.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }

        try {
            int orderId = Integer.parseInt(idParam);
            Cart_24110341 order = cartService.findById(orderId);

            if (order == null) {
                resp.sendRedirect(req.getContextPath() + "/home");
                return;
            }

            List<CartItem_24110341> items = cartService.findItemsByCartId(orderId);
            req.setAttribute("order", order);
            req.setAttribute("orderItems", items);
            req.getRequestDispatcher("/WEB-INF/views/cart/order-success.jsp").forward(req, resp);

        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/home");
        }
    }
}

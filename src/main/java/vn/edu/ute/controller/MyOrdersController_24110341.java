package vn.edu.ute.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.edu.ute.entity.CartItem_24110341;
import vn.edu.ute.entity.Cart_24110341;
import vn.edu.ute.entity.User_24110341;
import vn.edu.ute.service.ICartService_24110341;
import vn.edu.ute.service.impl.CartServiceImpl_24110341;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/my-orders")
public class MyOrdersController_24110341 extends HttpServlet {

    private final ICartService_24110341 cartService = new CartServiceImpl_24110341();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User_24110341 currentUser = (User_24110341) session.getAttribute("currentUser");

        if (currentUser == null) {
            session.setAttribute("error", "Vui lòng đăng nhập để xem danh sách đơn hàng đã đặt của bạn!");
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        List<Cart_24110341> orders = cartService.findByUserId(currentUser.getUserId());
        Map<Integer, List<CartItem_24110341>> orderItemsMap = new HashMap<>();

        for (Cart_24110341 order : orders) {
            List<CartItem_24110341> items = cartService.findItemsByCartId(order.getCartId());
            orderItemsMap.put(order.getCartId(), items);
        }

        req.setAttribute("orders", orders);
        req.setAttribute("orderItemsMap", orderItemsMap);
        req.getRequestDispatcher("/WEB-INF/views/cart/my-orders.jsp").forward(req, resp);
    }
}

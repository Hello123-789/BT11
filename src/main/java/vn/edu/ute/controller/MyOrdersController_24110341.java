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
import java.util.ArrayList;
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

        // Lấy danh sách đơn hàng (nếu đã đăng nhập thì lấy của user, nếu chưa đăng nhập thì hiển thị tất cả để kiểm tra trực quan)
        List<Cart_24110341> allOrders;
        if (currentUser != null) {
            allOrders = cartService.findByUserId(currentUser.getUserId());
        } else {
            allOrders = cartService.findAll();
        }

        // Đếm số lượng đơn hàng theo từng trạng thái (8 trạng thái + Tất cả)
        int countAll = allOrders.size();
        int count1 = 0; // 1: Đơn hàng mới
        int count2 = 0; // 2: Đã xác nhận
        int count3 = 0; // 3: Chuẩn bị hàng
        int count4 = 0; // 4: Vận chuyển
        int count5 = 0; // 5: Giao hàng
        int count6 = 0; // 6: Đã giao
        int count7 = 0; // 7: Đơn hàng hủy (hoặc 0)
        int count8 = 0; // 8: Đơn hàng hoàn

        for (Cart_24110341 o : allOrders) {
            int st = o.getStatus();
            if (st == 1) count1++;
            else if (st == 2) count2++;
            else if (st == 3) count3++;
            else if (st == 4) count4++;
            else if (st == 5) count5++;
            else if (st == 6) count6++;
            else if (st == 7 || st == 0) count7++;
            else if (st == 8) count8++;
        }

        // Lấy trạng thái được chọn để lọc (mặc định: 'all')
        String statusParam = req.getParameter("status");
        String currentStatus = (statusParam != null && !statusParam.trim().isEmpty()) ? statusParam.trim() : "all";

        List<Cart_24110341> filteredOrders = new ArrayList<>();
        if ("all".equalsIgnoreCase(currentStatus)) {
            filteredOrders = allOrders;
        } else {
            try {
                int statusVal = Integer.parseInt(currentStatus);
                for (Cart_24110341 o : allOrders) {
                    if (statusVal == 7) {
                        if (o.getStatus() == 7 || o.getStatus() == 0) {
                            filteredOrders.add(o);
                        }
                    } else {
                        if (o.getStatus() == statusVal) {
                            filteredOrders.add(o);
                        }
                    }
                }
            } catch (NumberFormatException e) {
                currentStatus = "all";
                filteredOrders = allOrders;
            }
        }

        // Tải chi tiết các mặt hàng CartItem cho từng đơn hàng
        Map<Integer, List<CartItem_24110341>> orderItemsMap = new HashMap<>();
        for (Cart_24110341 order : filteredOrders) {
            List<CartItem_24110341> items = cartService.findItemsByCartId(order.getCartId());
            orderItemsMap.put(order.getCartId(), items);
        }

        // Đẩy dữ liệu ra view
        req.setAttribute("orders", filteredOrders);
        req.setAttribute("orderItemsMap", orderItemsMap);
        req.setAttribute("currentStatus", currentStatus);

        // Đẩy số lượng đơn hàng theo từng trạng thái để hiển thị badge trên tab
        req.setAttribute("countAll", countAll);
        req.setAttribute("count1", count1);
        req.setAttribute("count2", count2);
        req.setAttribute("count3", count3);
        req.setAttribute("count4", count4);
        req.setAttribute("count5", count5);
        req.setAttribute("count6", count6);
        req.setAttribute("count7", count7);
        req.setAttribute("count8", count8);

        req.getRequestDispatcher("/WEB-INF/views/cart/my-orders.jsp").forward(req, resp);
    }
}

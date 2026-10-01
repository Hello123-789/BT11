package vn.edu.ute.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.edu.ute.entity.CartItem_24110341;
import vn.edu.ute.entity.Cart_24110341;
import vn.edu.ute.entity.Product_24110341;
import vn.edu.ute.entity.User_24110341;
import vn.edu.ute.service.ICartService_24110341;
import vn.edu.ute.service.IProductService_24110341;
import vn.edu.ute.service.impl.CartServiceImpl_24110341;
import vn.edu.ute.service.impl.ProductServiceImpl_24110341;

import java.io.IOException;
import java.util.Date;
import java.util.List;

@WebServlet("/checkout")
public class CheckoutController_24110341 extends HttpServlet {

    private final ICartService_24110341 cartService = new CartServiceImpl_24110341();
    private final IProductService_24110341 productService = new ProductServiceImpl_24110341();

    @SuppressWarnings("unchecked")
    private List<CartItem_24110341> getCart(HttpSession session) {
        return (List<CartItem_24110341>) session.getAttribute("cart");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        List<CartItem_24110341> cart = getCart(session);

        if (cart == null || cart.isEmpty()) {
            session.setAttribute("cartWarning", "Giỏ hàng của bạn đang trống! Vui lòng chọn sản phẩm trước khi thanh toán.");
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        double total = 0.0;
        for (CartItem_24110341 item : cart) {
            total += item.getSubtotal();
        }

        // Tự động điền thông tin nếu người dùng đã đăng nhập
        User_24110341 currentUser = (User_24110341) session.getAttribute("currentUser");
        if (currentUser != null) {
            req.setAttribute("defaultName", currentUser.getFullname());
            req.setAttribute("defaultPhone", currentUser.getPhone());
            req.setAttribute("defaultEmail", currentUser.getEmail());
        }

        req.setAttribute("cartTotal", total);
        req.getRequestDispatcher("/WEB-INF/views/cart/checkout.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        List<CartItem_24110341> cart = getCart(session);

        if (cart == null || cart.isEmpty()) {
            session.setAttribute("cartError", "Giỏ hàng rỗng, không thể thực hiện thanh toán!");
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        String receiverName = req.getParameter("receiverName");
        String receiverPhone = req.getParameter("receiverPhone");
        String address = req.getParameter("address");
        String note = req.getParameter("note");
        String paymentMethod = req.getParameter("paymentMethod");

        if (paymentMethod == null || paymentMethod.trim().isEmpty()) {
            paymentMethod = "COD";
        }

        // Kiểm tra dữ liệu đầu vào
        if (receiverName == null || receiverName.trim().isEmpty() ||
            receiverPhone == null || receiverPhone.trim().isEmpty() ||
            address == null || address.trim().isEmpty()) {

            req.setAttribute("error", "Vui lòng nhập đầy đủ Họ tên, Số điện thoại và Địa chỉ giao hàng!");
            doGet(req, resp);
            return;
        }

        // Kiểm tra tồn kho trước khi đặt hàng
        for (CartItem_24110341 item : cart) {
            Product_24110341 p = productService.findById(item.getProduct().getProductId());
            if (p == null) {
                session.setAttribute("cartError", "Sản phẩm \"" + item.getProduct().getProductName() + "\" không còn tồn tại!");
                resp.sendRedirect(req.getContextPath() + "/cart");
                return;
            }
            if (p.getStock() < item.getQuantity()) {
                session.setAttribute("cartError", "Sản phẩm \"" + p.getProductName() + "\" trong kho chỉ còn " + p.getStock() + " cây, không đủ số lượng " + item.getQuantity() + " cây bạn yêu cầu. Vui lòng điều chỉnh lại!");
                resp.sendRedirect(req.getContextPath() + "/cart");
                return;
            }
        }

        try {
            // Tạo đơn hàng COD
            Cart_24110341 order = new Cart_24110341();
            User_24110341 currentUser = (User_24110341) session.getAttribute("currentUser");
            order.setUser(currentUser);
            order.setReceiverName(receiverName.trim());
            order.setReceiverPhone(receiverPhone.trim());
            order.setAddress(address.trim());
            order.setNote(note != null ? note.trim() : "");
            order.setPaymentMethod(paymentMethod.trim());
            order.setStatus(1); // 1 = Chờ xác nhận / Đang chuẩn bị giao COD
            order.setBuyDate(new Date());

            // Lưu đơn hàng và trừ tồn kho các sản phẩm
            Cart_24110341 savedOrder = cartService.createOrder(order, cart);

            if (savedOrder == null || savedOrder.getCartId() <= 0) {
                req.setAttribute("error", "Không thể tạo đơn hàng! Vui lòng thử lại sau.");
                doGet(req, resp);
                return;
            }

            // Xóa sạch giỏ hàng trong session chỉ khi đã lưu đơn thành công
            session.removeAttribute("cart");
            session.setAttribute("cartTotalQty", 0);

            // Chuyển hướng đến trang đặt hàng thành công
            resp.sendRedirect(req.getContextPath() + "/order-success?orderId=" + savedOrder.getCartId());

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Lỗi khi xử lý thanh toán đơn hàng: " + e.getMessage());
            doGet(req, resp);
        }
    }
}

package vn.edu.ute.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.edu.ute.entity.CartItem_24110341;
import vn.edu.ute.entity.Product_24110341;
import vn.edu.ute.service.IProductService_24110341;
import vn.edu.ute.service.impl.ProductServiceImpl_24110341;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/cart")
public class CartController_24110341 extends HttpServlet {

    private final IProductService_24110341 productService = new ProductServiceImpl_24110341();

    @SuppressWarnings("unchecked")
    private List<CartItem_24110341> getCart(HttpSession session) {
        List<CartItem_24110341> cart = (List<CartItem_24110341>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }
        return cart;
    }

    private void updateSessionCartCount(HttpSession session, List<CartItem_24110341> cart) {
        int count = 0;
        for (CartItem_24110341 item : cart) {
            count += item.getQuantity();
        }
        session.setAttribute("cartTotalQty", count);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        List<CartItem_24110341> cart = getCart(session);

        double total = 0.0;
        for (CartItem_24110341 item : cart) {
            total += item.getSubtotal();
        }

        updateSessionCartCount(session, cart);
        req.setAttribute("cartTotal", total);
        req.getRequestDispatcher("/WEB-INF/views/cart/cart.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        List<CartItem_24110341> cart = getCart(session);
        String action = req.getParameter("action");

        try {
            if ("add".equalsIgnoreCase(action)) {
                int productId = Integer.parseInt(req.getParameter("id"));
                int addQty = 1;
                try {
                    String qParam = req.getParameter("quantity");
                    if (qParam != null && !qParam.trim().isEmpty()) {
                        addQty = Integer.parseInt(qParam);
                    }
                } catch (NumberFormatException ignored) {}

                if (addQty < 1) addQty = 1;

                Product_24110341 product = productService.findById(productId);
                if (product == null) {
                    session.setAttribute("cartError", "Sản phẩm không tồn tại!");
                } else if (product.getStock() <= 0) {
                    session.setAttribute("cartError", "Sản phẩm \"" + product.getProductName() + "\" hiện tại đã hết hàng!");
                } else {
                    CartItem_24110341 existingItem = null;
                    for (CartItem_24110341 item : cart) {
                        if (item.getProduct().getProductId() == productId) {
                            existingItem = item;
                            break;
                        }
                    }

                    int maxStock = product.getStock();
                    if (existingItem != null) {
                        int currentQty = existingItem.getQuantity();
                        int desiredQty = currentQty + addQty;
                        if (desiredQty > maxStock) {
                            existingItem.setQuantity(maxStock);
                            session.setAttribute("cartWarning", "Số lượng trong giỏ hàng đã được điều chỉnh về mức tồn kho tối đa (" + maxStock + " sản phẩm)!");
                        } else {
                            existingItem.setQuantity(desiredQty);
                            session.setAttribute("cartSuccess", "Đã thêm sản phẩm \"" + product.getProductName() + "\" vào giỏ hàng!");
                        }
                    } else {
                        int finalQty = Math.min(addQty, maxStock);
                        cart.add(new CartItem_24110341(product, finalQty));
                        if (addQty > maxStock) {
                            session.setAttribute("cartWarning", "Đã thêm " + finalQty + " sản phẩm (giới hạn theo tồn kho tối đa " + maxStock + ") vào giỏ!");
                        } else {
                            session.setAttribute("cartSuccess", "Đã thêm sản phẩm \"" + product.getProductName() + "\" vào giỏ hàng!");
                        }
                    }
                }
            } else if ("update".equalsIgnoreCase(action)) {
                int productId = Integer.parseInt(req.getParameter("id"));
                int newQty = Integer.parseInt(req.getParameter("quantity"));

                if (newQty <= 0) {
                    cart.removeIf(i -> i.getProduct().getProductId() == productId);
                    session.setAttribute("cartSuccess", "Đã xóa sản phẩm khỏi giỏ hàng!");
                } else {
                    Product_24110341 product = productService.findById(productId);
                    int maxStock = (product != null) ? product.getStock() : newQty;

                    for (CartItem_24110341 item : cart) {
                        if (item.getProduct().getProductId() == productId) {
                            if (newQty > maxStock) {
                                item.setQuantity(maxStock);
                                session.setAttribute("cartWarning", "Số lượng điều chỉnh vượt quá tồn kho. Đã tự động đưa về mức tối đa: " + maxStock + " sản phẩm!");
                            } else {
                                item.setQuantity(newQty);
                                session.setAttribute("cartSuccess", "Đã cập nhật số lượng thành công!");
                            }
                            break;
                        }
                    }
                }
            } else if ("remove".equalsIgnoreCase(action)) {
                int productId = Integer.parseInt(req.getParameter("id"));
                cart.removeIf(i -> i.getProduct().getProductId() == productId);
                session.setAttribute("cartSuccess", "Đã xóa sản phẩm khỏi giỏ hàng!");
            } else if ("clear".equalsIgnoreCase(action)) {
                cart.clear();
                session.setAttribute("cartSuccess", "Đã xóa tất cả sản phẩm trong giỏ hàng!");
            }
        } catch (Exception e) {
            session.setAttribute("cartError", "Có lỗi xảy ra khi xử lý giỏ hàng: " + e.getMessage());
        }

        updateSessionCartCount(session, cart);

        // Chuyển hướng về giỏ hàng (hoặc trang trước đó nếu được yêu cầu)
        String redirect = req.getParameter("redirect");
        if ("detail".equalsIgnoreCase(redirect)) {
            String pId = req.getParameter("id");
            resp.sendRedirect(req.getContextPath() + "/product/detail?id=" + pId);
        } else {
            resp.sendRedirect(req.getContextPath() + "/cart");
        }
    }
}

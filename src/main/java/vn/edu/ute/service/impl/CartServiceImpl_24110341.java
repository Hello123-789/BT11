package vn.edu.ute.service.impl;

import vn.edu.ute.dao.ICartDao_24110341;
import vn.edu.ute.dao.IProductDao_24110341;
import vn.edu.ute.dao.impl.CartDaoImpl_24110341;
import vn.edu.ute.dao.impl.ProductDaoImpl_24110341;
import vn.edu.ute.entity.CartItem_24110341;
import vn.edu.ute.entity.Cart_24110341;
import vn.edu.ute.entity.Product_24110341;
import vn.edu.ute.service.ICartService_24110341;

import java.util.List;

public class CartServiceImpl_24110341 implements ICartService_24110341 {

    private final ICartDao_24110341 cartDao = new CartDaoImpl_24110341();
    private final IProductDao_24110341 productDao = new ProductDaoImpl_24110341();

    @Override
    public Cart_24110341 createOrder(Cart_24110341 cart, List<CartItem_24110341> items) {
        if (cart == null || items == null || items.isEmpty()) {
            return null;
        }

        // 1. Tính tổng tiền đơn hàng
        double total = 0.0;
        for (CartItem_24110341 item : items) {
            total += item.getSubtotal();
        }
        cart.setTotalMoney(total);

        // 2. Lưu đơn hàng Cart
        cartDao.insert(cart);

        // 3. Lưu từng chi tiết đơn hàng CartItem và trừ số lượng tồn kho (stock)
        for (CartItem_24110341 item : items) {
            item.setCart(cart);
            cartDao.insertItem(item);

            // Cập nhật tồn kho sản phẩm
            Product_24110341 p = productDao.findById(item.getProduct().getProductId());
            if (p != null) {
                int currentStock = p.getStock();
                int newStock = Math.max(0, currentStock - item.getQuantity());
                p.setStock(newStock);
                productDao.update(p);
            }
        }

        return cart;
    }

    @Override
    public Cart_24110341 findById(int cartId) {
        return cartDao.findById(cartId);
    }

    @Override
    public List<Cart_24110341> findByUserId(int userId) {
        return cartDao.findByUserId(userId);
    }

    @Override
    public List<CartItem_24110341> findItemsByCartId(int cartId) {
        return cartDao.findItemsByCartId(cartId);
    }

    @Override
    public void update(Cart_24110341 cart) {
        cartDao.update(cart);
    }
}

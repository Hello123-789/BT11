package vn.edu.ute.dao;

import vn.edu.ute.entity.CartItem_24110341;
import vn.edu.ute.entity.Cart_24110341;
import java.util.List;

public interface ICartDao_24110341 {
    void insert(Cart_24110341 cart);
    void update(Cart_24110341 cart);
    Cart_24110341 findById(int cartId);
    List<Cart_24110341> findAll();
    List<Cart_24110341> findByUserId(int userId);
    void insertItem(CartItem_24110341 item);
    List<CartItem_24110341> findItemsByCartId(int cartId);
}

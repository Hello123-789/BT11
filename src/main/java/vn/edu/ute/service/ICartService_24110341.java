package vn.edu.ute.service;

import vn.edu.ute.entity.CartItem_24110341;
import vn.edu.ute.entity.Cart_24110341;

import java.util.List;

public interface ICartService_24110341 {
    Cart_24110341 createOrder(Cart_24110341 cart, List<CartItem_24110341> items);
    Cart_24110341 findById(int cartId);
    List<Cart_24110341> findAll();
    List<Cart_24110341> findByUserId(int userId);
    List<Cart_24110341> findByUserIdAndStatus(int userId, int status);
    List<Cart_24110341> findByStatus(int status);
    List<CartItem_24110341> findItemsByCartId(int cartId);
    void update(Cart_24110341 cart);
}

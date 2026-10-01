package vn.edu.ute.entity;

import jakarta.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "CartItem")
public class CartItem_24110341 implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int cartItemId;

    @Column(name = "quantity")
    private int quantity = 1;

    @Column(name = "unitPrice")
    private Double unitPrice = 0.0;

    @ManyToOne
    @JoinColumn(name = "productId")
    private Product_24110341 product;

    @ManyToOne
    @JoinColumn(name = "cartId")
    private Cart_24110341 cart;

    public CartItem_24110341() {}

    public int getCartItemId() { return cartItemId; }
    public void setCartItemId(int cartItemId) { this.cartItemId = cartItemId; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public Double getUnitPrice() { return unitPrice; }
    public void setUnitPrice(Double unitPrice) { this.unitPrice = unitPrice; }

    public Product_24110341 getProduct() { return product; }
    public void setProduct(Product_24110341 product) { this.product = product; }

    public Cart_24110341 getCart() { return cart; }
    public void setCart(Cart_24110341 cart) { this.cart = cart; }
}

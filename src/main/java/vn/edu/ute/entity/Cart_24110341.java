package vn.edu.ute.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "Cart")
public class Cart_24110341 implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int cartId;

    @ManyToOne
    @JoinColumn(name = "userId")
    private User_24110341 user;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "buyDate")
    private Date buyDate = new Date();

    @Column(name = "status")
    private int status = 1; // 1: Chờ xử lý / Đã đặt hàng COD, 0: Đã hủy, 2: Đang giao, 3: Hoàn thành

    @Column(name = "receiverName", length = 100)
    private String receiverName;

    @Column(name = "receiverPhone", length = 20)
    private String receiverPhone;

    @Column(name = "address", length = 500)
    private String address;

    @Column(name = "note", length = 500)
    private String note;

    @Column(name = "paymentMethod", length = 50)
    private String paymentMethod = "COD";

    @Column(name = "totalMoney")
    private Double totalMoney = 0.0;

    @OneToMany(mappedBy = "cart", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<CartItem_24110341> items = new ArrayList<>();

    public Cart_24110341() {}

    public int getCartId() { return cartId; }
    public void setCartId(int cartId) { this.cartId = cartId; }

    public User_24110341 getUser() { return user; }
    public void setUser(User_24110341 user) { this.user = user; }

    public Date getBuyDate() { return buyDate; }
    public void setBuyDate(Date buyDate) { this.buyDate = buyDate; }

    public int getStatus() { return status; }
    public void setStatus(int status) { this.status = status; }

    public String getReceiverName() { return receiverName; }
    public void setReceiverName(String receiverName) { this.receiverName = receiverName; }

    public String getReceiverPhone() { return receiverPhone; }
    public void setReceiverPhone(String receiverPhone) { this.receiverPhone = receiverPhone; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getNote() { return note; }
    public void setNote(String note) { this.note = note; }

    public String getPaymentMethod() { return paymentMethod; }
    public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }

    public Double getTotalMoney() { return totalMoney; }
    public void setTotalMoney(Double totalMoney) { this.totalMoney = totalMoney; }

    public List<CartItem_24110341> getItems() { return items; }
    public void setItems(List<CartItem_24110341> items) { this.items = items; }
}

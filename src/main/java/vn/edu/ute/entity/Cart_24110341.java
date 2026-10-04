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

    public String getStatusName() {
        switch (status) {
            case 1: return "Đơn hàng mới";
            case 2: return "Đã xác nhận";
            case 3: return "Chuẩn bị hàng";
            case 4: return "Vận chuyển";
            case 5: return "Giao hàng";
            case 6: return "Đã giao";
            case 7:
            case 0: return "Đơn hàng hủy";
            case 8: return "Đơn hàng hoàn";
            default: return "Trạng thái #" + status;
        }
    }

    public String getStatusBadgeClass() {
        switch (status) {
            case 1: return "bg-primary";
            case 2: return "bg-secondary";
            case 3: return "bg-warning text-dark";
            case 4: return "bg-info text-dark";
            case 5: return "bg-dark text-white";
            case 6: return "bg-success";
            case 7:
            case 0: return "bg-danger";
            case 8: return "bg-secondary-subtle text-secondary border border-secondary";
            default: return "bg-light text-dark border";
        }
    }

    public String getStatusIcon() {
        switch (status) {
            case 1: return "bi-sparkles";
            case 2: return "bi-clipboard-check";
            case 3: return "bi-box-seam";
            case 4: return "bi-truck";
            case 5: return "bi-bicycle";
            case 6: return "bi-check-circle-fill";
            case 7:
            case 0: return "bi-x-circle-fill";
            case 8: return "bi-arrow-counterclockwise";
            default: return "bi-info-circle";
        }
    }

    public String getStatusDescription() {
        switch (status) {
            case 1: return "Đơn hàng mới tạo, đang chờ người bán xác nhận";
            case 2: return "Đơn hàng đã được xác nhận thành công";
            case 3: return "Người bán đang chuẩn bị hàng và đóng gói sản phẩm";
            case 4: return "Đơn hàng đang trong quá trình luân chuyển vận chuyển";
            case 5: return "Shipper đang trên đường giao hàng đến địa chỉ của bạn";
            case 6: return "Đơn hàng đã được giao thành công";
            case 7:
            case 0: return "Đơn hàng đã bị hủy";
            case 8: return "Đơn hàng hoàn trả về người bán";
            default: return "Đang cập nhật";
        }
    }

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

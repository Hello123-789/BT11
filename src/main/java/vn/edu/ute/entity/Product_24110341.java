package vn.edu.ute.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "Product")
public class Product_24110341 implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int productId;

    @Column(name = "productName", length = 200, nullable = false)
    private String productName;

    @Column(name = "productCode")
    private Long productCode;

    @ManyToOne
    @JoinColumn(name = "categoryId")
    private Category_24110341 category;

    @Column(name = "description", length = 500)
    private String description;

    @Column(name = "price")
    private Double price = 0.0;

    @Column(name = "amount")
    private int amount = 0;

    @Column(name = "stock")
    private int stock = 0;

    @Column(name = "images", length = 500)
    private String images;

    @Column(name = "wishlist")
    private int wishlist = 0;

    @Column(name = "status")
    private int status = 1;

    @Temporal(TemporalType.DATE)
    @Column(name = "createDate")
    private Date createDate = new Date();

    @ManyToOne
    @JoinColumn(name = "sellerId")
    private Seller_24110341 seller;

    public Product_24110341() {}

    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }

    public Long getProductCode() { return productCode; }
    public void setProductCode(Long productCode) { this.productCode = productCode; }

    public Category_24110341 getCategory() { return category; }
    public void setCategory(Category_24110341 category) { this.category = category; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public Double getPrice() { return price; }
    public void setPrice(Double price) { this.price = price; }

    public int getAmount() { return amount; }
    public void setAmount(int amount) { this.amount = amount; }

    public int getStock() { return stock; }
    public void setStock(int stock) { this.stock = stock; }

    public String getImages() { return images; }
    public void setImages(String images) { this.images = images; }

    public int getWishlist() { return wishlist; }
    public void setWishlist(int wishlist) { this.wishlist = wishlist; }

    public int getStatus() { return status; }
    public void setStatus(int status) { this.status = status; }

    public Date getCreateDate() { return createDate; }
    public void setCreateDate(Date createDate) { this.createDate = createDate; }

    public Seller_24110341 getSeller() { return seller; }
    public void setSeller(Seller_24110341 seller) { this.seller = seller; }
}

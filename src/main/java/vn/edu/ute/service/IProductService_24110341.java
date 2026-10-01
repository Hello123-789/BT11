package vn.edu.ute.service;

import vn.edu.ute.entity.Product_24110341;
import java.util.List;

public interface IProductService_24110341 {
    List<Product_24110341> findAll();
    List<Product_24110341> findAll(int page, int pageSize);
    int count();
    List<Product_24110341> findBySellerId(int sellerId);
    Product_24110341 findById(int id);
    void insert(Product_24110341 product);
    void update(Product_24110341 product);
    void delete(int id);

    // Tìm kiếm và phân trang
    List<Product_24110341> searchAndPaginate(String keyword, Integer categoryId, Integer sellerId, int page, int pageSize);
    int countSearch(String keyword, Integer categoryId, Integer sellerId);
}

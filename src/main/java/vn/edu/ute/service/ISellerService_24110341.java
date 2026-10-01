package vn.edu.ute.service;

import vn.edu.ute.entity.Seller_24110341;
import java.util.List;

public interface ISellerService_24110341 {
    List<Seller_24110341> findAll();
    List<Seller_24110341> findAll(int page, int pageSize);
    int count();
    Seller_24110341 findById(int id);
    void insert(Seller_24110341 seller);
    void update(Seller_24110341 seller);
    void delete(int id);
}

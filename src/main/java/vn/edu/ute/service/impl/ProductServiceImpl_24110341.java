package vn.edu.ute.service.impl;

import vn.edu.ute.dao.IProductDao_24110341;
import vn.edu.ute.dao.impl.ProductDaoImpl_24110341;
import vn.edu.ute.entity.Product_24110341;
import vn.edu.ute.service.IProductService_24110341;
import java.util.List;

public class ProductServiceImpl_24110341 implements IProductService_24110341 {
    private final IProductDao_24110341 productDao = new ProductDaoImpl_24110341();

    @Override public List<Product_24110341> findAll() { return productDao.findAll(); }
    @Override public List<Product_24110341> findAll(int page, int pageSize) { return productDao.findAll(page, pageSize); }
    @Override public int count() { return productDao.count(); }
    @Override public List<Product_24110341> findBySellerId(int sellerId) { return productDao.findBySellerId(sellerId); }
    @Override public Product_24110341 findById(int id) { return productDao.findById(id); }
    @Override public void insert(Product_24110341 p) { productDao.insert(p); }
    @Override public void update(Product_24110341 p) { productDao.update(p); }
    @Override public void delete(int id) { productDao.delete(id); }

    @Override
    public List<Product_24110341> searchAndPaginate(String keyword, Integer categoryId, Integer sellerId, int page, int pageSize) {
        return productDao.searchAndPaginate(keyword, categoryId, sellerId, page, pageSize);
    }

    @Override
    public int countSearch(String keyword, Integer categoryId, Integer sellerId) {
        return productDao.countSearch(keyword, categoryId, sellerId);
    }
}

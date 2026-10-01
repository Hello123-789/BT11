package vn.edu.ute.service.impl;

import vn.edu.ute.dao.ISellerDao_24110341;
import vn.edu.ute.dao.impl.SellerDaoImpl_24110341;
import vn.edu.ute.entity.Seller_24110341;
import vn.edu.ute.service.ISellerService_24110341;
import java.util.List;

public class SellerServiceImpl_24110341 implements ISellerService_24110341 {
    private final ISellerDao_24110341 sellerDao = new SellerDaoImpl_24110341();

    @Override public List<Seller_24110341> findAll() { return sellerDao.findAll(); }
    @Override public List<Seller_24110341> findAll(int page, int pageSize) { return sellerDao.findAll(page, pageSize); }
    @Override public int count() { return sellerDao.count(); }
    @Override public Seller_24110341 findById(int id) { return sellerDao.findById(id); }
    @Override public void insert(Seller_24110341 seller) { sellerDao.insert(seller); }
    @Override public void update(Seller_24110341 seller) { sellerDao.update(seller); }
    @Override public void delete(int id) { sellerDao.delete(id); }
}

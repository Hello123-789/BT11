package vn.edu.ute.service.impl;

import vn.edu.ute.dao.ICategoryDao_24110341;
import vn.edu.ute.dao.impl.CategoryDaoImpl_24110341;
import vn.edu.ute.entity.Category_24110341;
import vn.edu.ute.service.ICategoryService_24110341;
import java.util.List;

public class CategoryServiceImpl_24110341 implements ICategoryService_24110341 {
    private final ICategoryDao_24110341 categoryDao = new CategoryDaoImpl_24110341();

    @Override public List<Category_24110341> findAll() { return categoryDao.findAll(); }
    @Override public List<Category_24110341> findAll(int page, int pageSize) { return categoryDao.findAll(page, pageSize); }
    @Override public int count() { return categoryDao.count(); }
    @Override public Category_24110341 findById(int id) { return categoryDao.findById(id); }
    @Override public void insert(Category_24110341 cat) { categoryDao.insert(cat); }
    @Override public void update(Category_24110341 cat) { categoryDao.update(cat); }
    @Override public void delete(int id) { categoryDao.delete(id); }
}

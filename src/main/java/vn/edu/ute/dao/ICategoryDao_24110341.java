package vn.edu.ute.dao;

import vn.edu.ute.entity.Category_24110341;
import java.util.List;

public interface ICategoryDao_24110341 {
    List<Category_24110341> findAll();
    List<Category_24110341> findAll(int page, int pageSize);
    int count();
    Category_24110341 findById(int id);
    void insert(Category_24110341 category);
    void update(Category_24110341 category);
    void delete(int id);
}

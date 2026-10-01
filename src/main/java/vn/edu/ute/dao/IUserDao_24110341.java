package vn.edu.ute.dao;

import vn.edu.ute.entity.User_24110341;
import java.util.List;

public interface IUserDao_24110341 {
    User_24110341 findByUsername(String username);
    User_24110341 findByEmail(String email);
    User_24110341 findById(int id);
    List<User_24110341> findAll();
    List<User_24110341> findAll(int page, int pageSize);
    int count();
    void insert(User_24110341 user);
    void update(User_24110341 user);
    void delete(int id);
}

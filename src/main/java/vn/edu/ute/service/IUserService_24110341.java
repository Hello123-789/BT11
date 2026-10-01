package vn.edu.ute.service;

import vn.edu.ute.entity.User_24110341;
import java.util.List;

public interface IUserService_24110341 {
    User_24110341 login(String username, String password);
    boolean register(User_24110341 user);
    boolean verifyOtp(String email, String otp);
    User_24110341 findById(int id);
    List<User_24110341> findAll();
    List<User_24110341> findAll(int page, int pageSize);
    int count();
    void insert(User_24110341 user);
    void update(User_24110341 user);
    void delete(int id);
}

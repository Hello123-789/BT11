package vn.edu.ute.service.impl;

import vn.edu.ute.configs.EmailUtil_24110341;
import vn.edu.ute.dao.IUserDao_24110341;
import vn.edu.ute.dao.impl.UserDaoImpl_24110341;
import vn.edu.ute.entity.User_24110341;
import vn.edu.ute.service.IUserService_24110341;
import java.util.List;
import java.util.Random;

public class UserServiceImpl_24110341 implements IUserService_24110341 {
    private final IUserDao_24110341 userDao = new UserDaoImpl_24110341();

    @Override
    public User_24110341 login(String username, String password) {
        User_24110341 user = userDao.findByUsername(username);
        if (user != null && user.getPassword().equals(password) && user.getStatus() == 1) {
            return user;
        }
        return null;
    }

    @Override
    public boolean register(User_24110341 user) {
        if (userDao.findByUsername(user.getUsername()) != null) return false;
        if (userDao.findByEmail(user.getEmail()) != null) return false;

        String otp = String.format("%06d", new Random().nextInt(999999));
        user.setCode(otp);
        user.setStatus(0); // Chưa kích hoạt

        userDao.insert(user);
        EmailUtil_24110341.sendOtpEmail(user.getEmail(), otp);
        return true;
    }

    @Override
    public boolean verifyOtp(String email, String otp) {
        User_24110341 user = userDao.findByEmail(email);
        if (user != null && user.getCode() != null && user.getCode().equals(otp)) {
            user.setStatus(1); // Kích hoạt tài khoản
            user.setCode(null);
            userDao.update(user);
            return true;
        }
        return false;
    }

    @Override public User_24110341 findById(int id) { return userDao.findById(id); }
    @Override public List<User_24110341> findAll() { return userDao.findAll(); }
    @Override public List<User_24110341> findAll(int page, int pageSize) { return userDao.findAll(page, pageSize); }
    @Override public int count() { return userDao.count(); }
    @Override public void insert(User_24110341 user) { userDao.insert(user); }
    @Override public void update(User_24110341 user) { userDao.update(user); }
    @Override public void delete(int id) { userDao.delete(id); }
}

package vn.edu.ute.dao;

import vn.edu.ute.entity.UserRole_24110341;
import java.util.List;

public interface IUserRoleDao_24110341 {
    List<UserRole_24110341> findAll();
    UserRole_24110341 findById(int id);
}

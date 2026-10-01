package vn.edu.ute.dao.impl;

import jakarta.persistence.EntityManager;
import vn.edu.ute.configs.JPAConfig_24110341;
import vn.edu.ute.dao.IUserRoleDao_24110341;
import vn.edu.ute.entity.UserRole_24110341;
import java.util.List;

public class UserRoleDaoImpl_24110341 implements IUserRoleDao_24110341 {
    @Override
    public List<UserRole_24110341> findAll() {
        EntityManager em = JPAConfig_24110341.getEntityManager();
        try {
            return em.createQuery("SELECT r FROM UserRole_24110341 r", UserRole_24110341.class).getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public UserRole_24110341 findById(int id) {
        EntityManager em = JPAConfig_24110341.getEntityManager();
        try {
            return em.find(UserRole_24110341.class, id);
        } finally {
            em.close();
        }
    }
}

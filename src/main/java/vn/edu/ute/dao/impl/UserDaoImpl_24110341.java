package vn.edu.ute.dao.impl;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;
import vn.edu.ute.configs.JPAConfig_24110341;
import vn.edu.ute.dao.IUserDao_24110341;
import vn.edu.ute.entity.User_24110341;
import java.util.List;

public class UserDaoImpl_24110341 implements IUserDao_24110341 {
    @Override
    public User_24110341 findByUsername(String username) {
        EntityManager em = JPAConfig_24110341.getEntityManager();
        try {
            TypedQuery<User_24110341> query = em.createQuery("SELECT u FROM User_24110341 u WHERE u.username = :username", User_24110341.class);
            query.setParameter("username", username);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }

    @Override
    public User_24110341 findByEmail(String email) {
        EntityManager em = JPAConfig_24110341.getEntityManager();
        try {
            TypedQuery<User_24110341> query = em.createQuery("SELECT u FROM User_24110341 u WHERE u.email = :email", User_24110341.class);
            query.setParameter("email", email);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }

    @Override
    public User_24110341 findById(int id) {
        EntityManager em = JPAConfig_24110341.getEntityManager();
        try {
            return em.find(User_24110341.class, id);
        } finally {
            em.close();
        }
    }

    @Override
    public List<User_24110341> findAll() {
        EntityManager em = JPAConfig_24110341.getEntityManager();
        try {
            return em.createQuery("SELECT u FROM User_24110341 u ORDER BY u.userId DESC", User_24110341.class).getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<User_24110341> findAll(int page, int pageSize) {
        EntityManager em = JPAConfig_24110341.getEntityManager();
        try {
            TypedQuery<User_24110341> query = em.createQuery("SELECT u FROM User_24110341 u ORDER BY u.userId DESC", User_24110341.class);
            query.setFirstResult((page - 1) * pageSize);
            query.setMaxResults(pageSize);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public int count() {
        EntityManager em = JPAConfig_24110341.getEntityManager();
        try {
            return ((Long) em.createQuery("SELECT COUNT(u) FROM User_24110341 u").getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }

    @Override
    public void insert(User_24110341 user) {
        EntityManager em = JPAConfig_24110341.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(user);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public void update(User_24110341 user) {
        EntityManager em = JPAConfig_24110341.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(user);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public void delete(int id) {
        EntityManager em = JPAConfig_24110341.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            User_24110341 user = em.find(User_24110341.class, id);
            if (user != null) {
                em.remove(user);
            }
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            throw e;
        } finally {
            em.close();
        }
    }
}

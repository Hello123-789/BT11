package vn.edu.ute.dao.impl;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import vn.edu.ute.configs.JPAConfig_24110341;
import vn.edu.ute.dao.ISellerDao_24110341;
import vn.edu.ute.entity.Seller_24110341;
import java.util.List;

public class SellerDaoImpl_24110341 implements ISellerDao_24110341 {
    @Override
    public List<Seller_24110341> findAll() {
        EntityManager em = JPAConfig_24110341.getEntityManager();
        try {
            return em.createQuery("SELECT s FROM Seller_24110341 s ORDER BY s.sellerId DESC", Seller_24110341.class).getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Seller_24110341> findAll(int page, int pageSize) {
        EntityManager em = JPAConfig_24110341.getEntityManager();
        try {
            TypedQuery<Seller_24110341> query = em.createQuery("SELECT s FROM Seller_24110341 s ORDER BY s.sellerId DESC", Seller_24110341.class);
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
            return ((Long) em.createQuery("SELECT COUNT(s) FROM Seller_24110341 s").getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }

    @Override
    public Seller_24110341 findById(int id) {
        EntityManager em = JPAConfig_24110341.getEntityManager();
        try {
            return em.find(Seller_24110341.class, id);
        } finally {
            em.close();
        }
    }

    @Override
    public void insert(Seller_24110341 seller) {
        EntityManager em = JPAConfig_24110341.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(seller);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public void update(Seller_24110341 seller) {
        EntityManager em = JPAConfig_24110341.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(seller);
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
            Seller_24110341 seller = em.find(Seller_24110341.class, id);
            if (seller != null) {
                em.remove(seller);
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

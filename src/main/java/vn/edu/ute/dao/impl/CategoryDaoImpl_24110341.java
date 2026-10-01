package vn.edu.ute.dao.impl;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import vn.edu.ute.configs.JPAConfig_24110341;
import vn.edu.ute.dao.ICategoryDao_24110341;
import vn.edu.ute.entity.Category_24110341;
import java.util.List;

public class CategoryDaoImpl_24110341 implements ICategoryDao_24110341 {
    @Override
    public List<Category_24110341> findAll() {
        EntityManager em = JPAConfig_24110341.getEntityManager();
        try {
            return em.createQuery("SELECT c FROM Category_24110341 c", Category_24110341.class).getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Category_24110341> findAll(int page, int pageSize) {
        EntityManager em = JPAConfig_24110341.getEntityManager();
        try {
            TypedQuery<Category_24110341> query = em.createQuery("SELECT c FROM Category_24110341 c ORDER BY c.categoryId DESC", Category_24110341.class);
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
            return ((Long) em.createQuery("SELECT COUNT(c) FROM Category_24110341 c").getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }

    @Override
    public Category_24110341 findById(int id) {
        EntityManager em = JPAConfig_24110341.getEntityManager();
        try {
            return em.find(Category_24110341.class, id);
        } finally {
            em.close();
        }
    }

    @Override
    public void insert(Category_24110341 category) {
        EntityManager em = JPAConfig_24110341.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(category);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public void update(Category_24110341 category) {
        EntityManager em = JPAConfig_24110341.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(category);
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
            Category_24110341 cat = em.find(Category_24110341.class, id);
            if (cat != null) em.remove(cat);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            throw e;
        } finally {
            em.close();
        }
    }
}

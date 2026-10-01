package vn.edu.ute.dao.impl;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import vn.edu.ute.configs.JPAConfig_24110341;
import vn.edu.ute.dao.IProductDao_24110341;
import vn.edu.ute.entity.Product_24110341;
import java.util.List;

public class ProductDaoImpl_24110341 implements IProductDao_24110341 {
    @Override
    public List<Product_24110341> findAll() {
        EntityManager em = JPAConfig_24110341.getEntityManager();
        try {
            return em.createQuery("SELECT p FROM Product_24110341 p ORDER BY p.productId DESC", Product_24110341.class).getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Product_24110341> findAll(int page, int pageSize) {
        EntityManager em = JPAConfig_24110341.getEntityManager();
        try {
            TypedQuery<Product_24110341> query = em.createQuery("SELECT p FROM Product_24110341 p ORDER BY p.productId DESC", Product_24110341.class);
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
            return ((Long) em.createQuery("SELECT COUNT(p) FROM Product_24110341 p").getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Product_24110341> findBySellerId(int sellerId) {
        EntityManager em = JPAConfig_24110341.getEntityManager();
        try {
            TypedQuery<Product_24110341> query = em.createQuery("SELECT p FROM Product_24110341 p WHERE p.seller.sellerId = :sellerId ORDER BY p.productId DESC", Product_24110341.class);
            query.setParameter("sellerId", sellerId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public Product_24110341 findById(int id) {
        EntityManager em = JPAConfig_24110341.getEntityManager();
        try {
            return em.find(Product_24110341.class, id);
        } finally {
            em.close();
        }
    }

    @Override
    public void insert(Product_24110341 product) {
        EntityManager em = JPAConfig_24110341.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(product);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public void update(Product_24110341 product) {
        EntityManager em = JPAConfig_24110341.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(product);
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
            Product_24110341 p = em.find(Product_24110341.class, id);
            if (p != null) em.remove(p);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public List<Product_24110341> searchAndPaginate(String keyword, Integer categoryId, Integer sellerId, int page, int pageSize) {
        EntityManager em = JPAConfig_24110341.getEntityManager();
        try {
            StringBuilder jpql = new StringBuilder("SELECT p FROM Product_24110341 p WHERE 1=1 ");
            if (keyword != null && !keyword.trim().isEmpty()) {
                jpql.append("AND (LOWER(p.productName) LIKE :keyword OR LOWER(p.description) LIKE :keyword) ");
            }
            if (categoryId != null && categoryId > 0) {
                jpql.append("AND p.category.categoryId = :categoryId ");
            }
            if (sellerId != null && sellerId > 0) {
                jpql.append("AND p.seller.sellerId = :sellerId ");
            }
            jpql.append("ORDER BY p.productId DESC");

            TypedQuery<Product_24110341> query = em.createQuery(jpql.toString(), Product_24110341.class);
            if (keyword != null && !keyword.trim().isEmpty()) {
                query.setParameter("keyword", "%" + keyword.trim().toLowerCase() + "%");
            }
            if (categoryId != null && categoryId > 0) {
                query.setParameter("categoryId", categoryId);
            }
            if (sellerId != null && sellerId > 0) {
                query.setParameter("sellerId", sellerId);
            }

            query.setFirstResult((page - 1) * pageSize);
            query.setMaxResults(pageSize);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public int countSearch(String keyword, Integer categoryId, Integer sellerId) {
        EntityManager em = JPAConfig_24110341.getEntityManager();
        try {
            StringBuilder jpql = new StringBuilder("SELECT COUNT(p) FROM Product_24110341 p WHERE 1=1 ");
            if (keyword != null && !keyword.trim().isEmpty()) {
                jpql.append("AND (LOWER(p.productName) LIKE :keyword OR LOWER(p.description) LIKE :keyword) ");
            }
            if (categoryId != null && categoryId > 0) {
                jpql.append("AND p.category.categoryId = :categoryId ");
            }
            if (sellerId != null && sellerId > 0) {
                jpql.append("AND p.seller.sellerId = :sellerId ");
            }

            TypedQuery<Long> query = em.createQuery(jpql.toString(), Long.class);
            if (keyword != null && !keyword.trim().isEmpty()) {
                query.setParameter("keyword", "%" + keyword.trim().toLowerCase() + "%");
            }
            if (categoryId != null && categoryId > 0) {
                query.setParameter("categoryId", categoryId);
            }
            if (sellerId != null && sellerId > 0) {
                query.setParameter("sellerId", sellerId);
            }

            return query.getSingleResult().intValue();
        } finally {
            em.close();
        }
    }
}

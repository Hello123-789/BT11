package vn.edu.ute.dao.impl;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import vn.edu.ute.configs.JPAConfig_24110341;
import vn.edu.ute.dao.ICartDao_24110341;
import vn.edu.ute.entity.CartItem_24110341;
import vn.edu.ute.entity.Cart_24110341;

import java.util.ArrayList;
import java.util.List;

public class CartDaoImpl_24110341 implements ICartDao_24110341 {

    @Override
    public void insert(Cart_24110341 cart) {
        EntityManager em = JPAConfig_24110341.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(cart);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    @Override
    public void update(Cart_24110341 cart) {
        EntityManager em = JPAConfig_24110341.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(cart);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    @Override
    public Cart_24110341 findById(int cartId) {
        EntityManager em = JPAConfig_24110341.getEntityManager();
        try {
            return em.find(Cart_24110341.class, cartId);
        } finally {
            em.close();
        }
    }

    @Override
    public List<Cart_24110341> findAll() {
        EntityManager em = JPAConfig_24110341.getEntityManager();
        try {
            TypedQuery<Cart_24110341> query = em.createQuery("SELECT c FROM Cart_24110341 c ORDER BY c.buyDate DESC", Cart_24110341.class);
            return query.getResultList();
        } catch (Exception e) {
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Cart_24110341> findByUserId(int userId) {
        EntityManager em = JPAConfig_24110341.getEntityManager();
        try {
            TypedQuery<Cart_24110341> query = em.createQuery("SELECT c FROM Cart_24110341 c WHERE c.user.userId = :userId ORDER BY c.buyDate DESC", Cart_24110341.class);
            query.setParameter("userId", userId);
            return query.getResultList();
        } catch (Exception e) {
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }

    @Override
    public void insertItem(CartItem_24110341 item) {
        EntityManager em = JPAConfig_24110341.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(item);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    @Override
    public List<CartItem_24110341> findItemsByCartId(int cartId) {
        EntityManager em = JPAConfig_24110341.getEntityManager();
        try {
            TypedQuery<CartItem_24110341> query = em.createQuery("SELECT i FROM CartItem_24110341 i WHERE i.cart.cartId = :cartId", CartItem_24110341.class);
            query.setParameter("cartId", cartId);
            return query.getResultList();
        } catch (Exception e) {
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }
}

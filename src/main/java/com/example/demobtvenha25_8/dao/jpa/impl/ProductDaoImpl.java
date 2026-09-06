package com.example.demobtvenha25_8.dao.jpa.impl;

import com.example.demobtvenha25_8.config.JPAConfig;
import com.example.demobtvenha25_8.dao.jpa.IProductDao;
import com.example.demobtvenha25_8.model.Product;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;

import java.util.List;

public class ProductDaoImpl implements IProductDao {

    @Override
    public Product save(Product product) {
        EntityManager em = JPAConfig.getEntityManager();
        EntityTransaction transaction = em.getTransaction();
        try {
            transaction.begin();
            em.persist(product);
            transaction.commit();
            return product;
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public Product update(Product product) {
        EntityManager em = JPAConfig.getEntityManager();
        EntityTransaction transaction = em.getTransaction();
        try {
            transaction.begin();
            product.setUpdatedAt(new java.sql.Timestamp(System.currentTimeMillis()));
            Product mergedProduct = em.merge(product);
            transaction.commit();
            return mergedProduct;
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public void delete(int productId) {
        EntityManager em = JPAConfig.getEntityManager();
        EntityTransaction transaction = em.getTransaction();
        try {
            transaction.begin();
            Product product = em.find(Product.class, productId);
            if (product != null) {
                em.remove(product);
            }
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public Product findById(int productId) {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            return em.find(Product.class, productId);
        } finally {
            em.close();
        }
    }

    @Override
    public List<Product> findAll() {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            TypedQuery<Product> query = em.createQuery(
                    "SELECT p FROM Product p ORDER BY p.createdAt DESC", Product.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Product> findLatest(int limit) {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            TypedQuery<Product> query = em.createQuery(
                    "SELECT p FROM Product p ORDER BY p.createdAt DESC", Product.class);
            query.setMaxResults(limit);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Product> findPaginated(int page, int pageSize) {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            TypedQuery<Product> query = em.createQuery(
                    "SELECT p FROM Product p ORDER BY p.createdAt DESC", Product.class);
            query.setFirstResult((page - 1) * pageSize);
            query.setMaxResults(pageSize);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public int countTotal() {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery(
                    "SELECT COUNT(p) FROM Product p", Long.class);
            return query.getSingleResult().intValue();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Product> findByCategory(int cateId) {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            TypedQuery<Product> query = em.createQuery(
                    "SELECT p FROM Product p WHERE p.cateId = :cateId ORDER BY p.createdAt DESC", Product.class);
            query.setParameter("cateId", cateId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}

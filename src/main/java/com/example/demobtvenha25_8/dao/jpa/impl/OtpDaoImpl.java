package com.example.demobtvenha25_8.dao.jpa.impl;

import com.example.demobtvenha25_8.config.JPAConfig;
import com.example.demobtvenha25_8.dao.jpa.IOtpDao;
import com.example.demobtvenha25_8.model.Otp;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;

import java.sql.Timestamp;
import java.util.List;

public class OtpDaoImpl implements IOtpDao {

    @Override
    public Otp save(Otp otp) {
        EntityManager em = JPAConfig.getEntityManager();
        EntityTransaction transaction = em.getTransaction();
        try {
            transaction.begin();
            em.persist(otp);
            transaction.commit();
            return otp;
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
    public Otp findLatestValidOtp(String email) {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            TypedQuery<Otp> query = em.createQuery(
                    "SELECT o FROM Otp o WHERE o.email = :email " +
                            "AND o.isUsed = false " +
                            "AND o.expiryTime > :currentTime " +
                            "ORDER BY o.createdAt DESC", Otp.class);
            query.setParameter("email", email);
            query.setParameter("currentTime", new Timestamp(System.currentTimeMillis()));
            query.setMaxResults(1);
            List<Otp> results = query.getResultList();
            return results.isEmpty() ? null : results.get(0);
        } finally {
            em.close();
        }
    }

    @Override
    public boolean markAsUsed(int otpId) {
        EntityManager em = JPAConfig.getEntityManager();
        EntityTransaction transaction = em.getTransaction();
        try {
            transaction.begin();
            Otp otp = em.find(Otp.class, otpId);
            if (otp != null) {
                otp.setUsed(true);
                em.merge(otp);
                transaction.commit();
                return true;
            }
            return false;
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
    public void invalidateOldOtps(String email) {
        EntityManager em = JPAConfig.getEntityManager();
        EntityTransaction transaction = em.getTransaction();
        try {
            transaction.begin();
            em.createQuery(
                            "UPDATE Otp o SET o.isUsed = true WHERE o.email = :email AND o.isUsed = false")
                    .setParameter("email", email)
                    .executeUpdate();
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
}
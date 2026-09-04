package com.example.demobtvenha25_8.dao.jpa;

import com.example.demobtvenha25_8.model.User;

public interface UserJpaDao {
    User findByUsername(String username);
    User save(User user);
    User update(User user);
    boolean existsByUsername(String username);
}

package com.example.demobtvenha25_8.service;

import com.example.demobtvenha25_8.model.Product;

import java.util.List;

public interface IProductService {
    Product save(Product product);
    Product update(Product product);
    void delete(int productId);
    Product findById(int productId);
    List<Product> findAll();
    List<Product> findLatest(int limit);
    List<Product> findPaginated(int page, int pageSize);
    int countTotal();
    List<Product> findByCategory(int cateId);
}
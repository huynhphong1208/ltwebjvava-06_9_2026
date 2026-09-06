package com.example.demobtvenha25_8.service.impl;

import com.example.demobtvenha25_8.dao.jpa.IProductDao;
import com.example.demobtvenha25_8.dao.jpa.impl.ProductDaoImpl;
import com.example.demobtvenha25_8.model.Product;
import com.example.demobtvenha25_8.service.IProductService;

import java.util.List;

public class ProductServiceImpl implements IProductService {
    private IProductDao productDao = new ProductDaoImpl();

    @Override
    public Product save(Product product) {
        return productDao.save(product);
    }

    @Override
    public Product update(Product product) {
        return productDao.update(product);
    }

    @Override
    public void delete(int productId) {
        productDao.delete(productId);
    }

    @Override
    public Product findById(int productId) {
        return productDao.findById(productId);
    }

    @Override
    public List<Product> findAll() {
        return productDao.findAll();
    }

    @Override
    public List<Product> findLatest(int limit) {
        return productDao.findLatest(limit);
    }

    @Override
    public List<Product> findPaginated(int page, int pageSize) {
        return productDao.findPaginated(page, pageSize);
    }

    @Override
    public int countTotal() {
        return productDao.countTotal();
    }

    @Override
    public List<Product> findByCategory(int cateId) {
        return productDao.findByCategory(cateId);
    }
}

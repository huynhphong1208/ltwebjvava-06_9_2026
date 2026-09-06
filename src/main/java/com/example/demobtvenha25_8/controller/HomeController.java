package com.example.demobtvenha25_8.controller;

import com.example.demobtvenha25_8.model.Product;
import com.example.demobtvenha25_8.service.IProductService;
import com.example.demobtvenha25_8.service.impl.ProductServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/home")
public class HomeController extends HttpServlet {
    private IProductService productService = new ProductServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // Lấy 10 sản phẩm mới nhất
        List<Product> latestProducts = productService.findLatest(10);
        req.setAttribute("latestProducts", latestProducts);

        req.getRequestDispatcher("/views/home.jsp").forward(req, resp);
    }
}

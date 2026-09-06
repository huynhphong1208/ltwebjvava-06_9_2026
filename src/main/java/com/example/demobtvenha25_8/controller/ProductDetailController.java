package com.example.demobtvenha25_8.controller;

import com.example.demobtvenha25_8.model.Product;
import com.example.demobtvenha25_8.service.IProductService;
import com.example.demobtvenha25_8.service.impl.ProductServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/product/detail")
public class ProductDetailController extends HttpServlet {
    private IProductService productService = new ProductServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // Lấy productId từ parameter
        String productIdStr = req.getParameter("id");

        if (productIdStr == null || productIdStr.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/product");
            return;
        }

        try {
            int productId = Integer.parseInt(productIdStr);
            Product product = productService.findById(productId);

            if (product == null) {
                req.setAttribute("alert", "Sản phẩm không tồn tại!");
                resp.sendRedirect(req.getContextPath() + "/product");
                return;
            }

            // Lấy 5 sản phẩm cùng category để gợi ý
            if (product.getCategory() != null) {
                var relatedProducts = productService.findByCategory(product.getCateId());
                req.setAttribute("relatedProducts", relatedProducts);
            }

            req.setAttribute("product", product);
            req.getRequestDispatcher("/views/product/detail.jsp").forward(req, resp);

        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/product");
        }
    }
}
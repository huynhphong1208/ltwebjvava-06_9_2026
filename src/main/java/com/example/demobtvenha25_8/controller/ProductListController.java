package com.example.demobtvenha25_8.controller;

import com.example.demobtvenha25_8.model.Category;
import com.example.demobtvenha25_8.model.Product;
import com.example.demobtvenha25_8.service.IProductService;
import com.example.demobtvenha25_8.service.impl.ProductServiceImpl;
import com.example.demobtvenha25_8.service.jpa.CategoryServiceImpl;
import com.example.demobtvenha25_8.service.jpa.ICategoryService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/product")
public class ProductListController extends HttpServlet {
    private IProductService productService = new ProductServiceImpl();
    private ICategoryService categoryService = new CategoryServiceImpl();
    private static final int PAGE_SIZE = 6;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // Lấy số trang từ parameter (mặc định là 1)
        String pageStr = req.getParameter("page");
        int page = (pageStr == null || pageStr.isEmpty()) ? 1 : Integer.parseInt(pageStr);

        // Lấy cateId từ parameter (filter theo category)
        String cateIdStr = req.getParameter("cateId");
        Integer cateId = null;
        Category selectedCategory = null;

        if (cateIdStr != null && !cateIdStr.isEmpty()) {
            try {
                cateId = Integer.parseInt(cateIdStr);
                selectedCategory = categoryService.findById(cateId);
            } catch (NumberFormatException e) {
                cateId = null;
            }
        }

        // Lấy danh sách category để hiển thị filter
        List<Category> categories = categoryService.findAll();

        // Lấy sản phẩm theo filter
        List<Product> products;
        int totalProducts;

        if (cateId != null && selectedCategory != null) {
            products = productService.findByCategory(cateId);
            totalProducts = products.size();
            // Phân trang thủ công cho danh sách đã filter
            int fromIndex = (page - 1) * PAGE_SIZE;
            int toIndex = Math.min(fromIndex + PAGE_SIZE, totalProducts);
            if (fromIndex < totalProducts) {
                products = products.subList(fromIndex, toIndex);
            } else {
                products = List.of();
            }
        } else {
            totalProducts = productService.countTotal();
            products = productService.findPaginated(page, PAGE_SIZE);
        }

        // Tính tổng số trang
        int totalPages = (int) Math.ceil((double) totalProducts / PAGE_SIZE);

        // Kiểm tra page không vượt quá totalPages
        if (page < 1) page = 1;
        if (page > totalPages && totalPages > 0) page = totalPages;

        // Truyền dữ liệu sang JSP
        req.setAttribute("products", products);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("totalProducts", totalProducts);
        req.setAttribute("categories", categories);
        req.setAttribute("selectedCategory", selectedCategory);
        req.setAttribute("cateId", cateId);

        req.getRequestDispatcher("/views/product/list.jsp").forward(req, resp);
    }
}
package com.example.demobtvenha25_8.controller;

import com.example.demobtvenha25_8.model.Category;
import com.example.demobtvenha25_8.model.Product;
import com.example.demobtvenha25_8.service.IProductService;
import com.example.demobtvenha25_8.service.impl.ProductServiceImpl;
import com.example.demobtvenha25_8.service.jpa.CategoryServiceImpl;
import com.example.demobtvenha25_8.service.jpa.ICategoryService;
import com.example.demobtvenha25_8.util.Constant;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.UUID;

@WebServlet("/admin/product/*")
@MultipartConfig(maxFileSize = 5 * 1024 * 1024, maxRequestSize = 6 * 1024 * 1024)
public class ProductController extends HttpServlet {
    private final IProductService productService = new ProductServiceImpl();
    private final ICategoryService categoryService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String pathInfo = req.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/list")) listProducts(req, resp);
        else if (pathInfo.equals("/add")) showAddForm(req, resp);
        else if (pathInfo.equals("/edit")) showEditForm(req, resp);
        else if (pathInfo.equals("/delete")) deleteProduct(req, resp);
        else resp.sendError(HttpServletResponse.SC_NOT_FOUND);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String pathInfo = req.getPathInfo();
        if ("/add".equals(pathInfo)) addProduct(req, resp);
        else if ("/edit".equals(pathInfo)) updateProduct(req, resp);
        else resp.sendError(HttpServletResponse.SC_NOT_FOUND);
    }

    private void listProducts(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Category category = findCategory(req.getParameter("cateId"));
        if (req.getParameter("cateId") != null && category == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/category/list");
            return;
        }
        req.setAttribute("products", category == null ? productService.findAll() : productService.findByCategory(category.getCateId()));
        req.setAttribute("category", category);
        req.getRequestDispatcher("/views/admin/product/list.jsp").forward(req, resp);
    }

    private void showAddForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Category category = findCategory(req.getParameter("cateId"));
        if (req.getParameter("cateId") != null && category == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/category/list");
            return;
        }
        req.setAttribute("category", category);
        req.setAttribute("categories", category == null ? categoryService.findAll() : List.of(category));
        req.getRequestDispatcher("/views/admin/product/add.jsp").forward(req, resp);
    }

    private void showEditForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Product product = findProduct(req.getParameter("id"));
        if (product == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/product/list");
            return;
        }
        Category category = categoryService.findById(product.getCateId());
        req.setAttribute("product", product);
        req.setAttribute("category", category);
        req.getRequestDispatcher("/views/admin/product/edit.jsp").forward(req, resp);
    }

    private void addProduct(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        Category category = findCategory(req.getParameter("cateId"));
        if (category == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/category/list");
            return;
        }
        try {
            Product product = new Product(required(req.getParameter("productName"), "Tên sản phẩm không được để trống"),
                    req.getParameter("description"), new BigDecimal(req.getParameter("price")),
                    saveProductImage(req.getPart("image")), Integer.parseInt(req.getParameter("stock")), category.getCateId());
            productService.save(product);
            redirectToCategoryProducts(req, resp, category.getCateId());
        } catch (IllegalArgumentException e) {
            showAddError(req, resp, category, e.getMessage());
        }
    }

    private void updateProduct(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        Product product = findProduct(req.getParameter("productId"));
        if (product == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/product/list");
            return;
        }
        Category category = categoryService.findById(product.getCateId());
        try {
            product.setProductName(required(req.getParameter("productName"), "Tên sản phẩm không được để trống"));
            product.setDescription(req.getParameter("description"));
            product.setPrice(new BigDecimal(req.getParameter("price")));
            product.setStock(Integer.parseInt(req.getParameter("stock")));
            Part imagePart = req.getPart("image");
            if (imagePart != null && imagePart.getSize() > 0) {
                String imagePath = saveProductImage(imagePart);
                deleteProductImage(product.getImage());
                product.setImage(imagePath);
            }
            productService.update(product);
            redirectToCategoryProducts(req, resp, product.getCateId());
        } catch (IllegalArgumentException e) {
            req.setAttribute("product", product);
            req.setAttribute("category", category);
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/views/admin/product/edit.jsp").forward(req, resp);
        }
    }

    private void deleteProduct(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Product product = findProduct(req.getParameter("id"));
        if (product == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/product/list");
            return;
        }
        productService.delete(product.getProductId());
        deleteProductImage(product.getImage());
        redirectToCategoryProducts(req, resp, product.getCateId());
    }

    private void showAddError(HttpServletRequest req, HttpServletResponse resp, Category category, String error) throws ServletException, IOException {
        req.setAttribute("category", category);
        req.setAttribute("error", error);
        req.getRequestDispatcher("/views/admin/product/add.jsp").forward(req, resp);
    }

    private Category findCategory(String id) {
        try { return id == null ? null : categoryService.findById(Integer.parseInt(id)); }
        catch (NumberFormatException e) { return null; }
    }

    private Product findProduct(String id) {
        try { return id == null ? null : productService.findById(Integer.parseInt(id)); }
        catch (NumberFormatException e) { return null; }
    }

    private String saveProductImage(Part imagePart) throws IOException {
        if (imagePart == null || imagePart.getSize() == 0) throw new IllegalArgumentException("Vui lòng chọn ảnh sản phẩm JPG hoặc JPEG");
        String filename = imagePart.getSubmittedFileName();
        int dot = filename == null ? -1 : filename.lastIndexOf('.');
        String extension = dot < 0 ? "" : filename.substring(dot + 1).toLowerCase();
        if (!"image/jpeg".equalsIgnoreCase(imagePart.getContentType()) || !("jpg".equals(extension) || "jpeg".equals(extension))) {
            throw new IllegalArgumentException("Chỉ được upload ảnh JPG hoặc JPEG");
        }
        Path uploadDir = Paths.get(Constant.UPLOAD_DIR, "product");
        Files.createDirectories(uploadDir);
        String savedName = UUID.randomUUID() + "." + extension;
        imagePart.write(uploadDir.resolve(savedName).toString());
        return "product/" + savedName;
    }

    private void deleteProductImage(String imagePath) {
        if (imagePath == null || !imagePath.startsWith("product/")) return;
        try {
            Path uploadRoot = Paths.get(Constant.UPLOAD_DIR).toAbsolutePath().normalize();
            Path image = uploadRoot.resolve(imagePath).normalize();
            if (image.startsWith(uploadRoot)) Files.deleteIfExists(image);
        } catch (IOException ignored) {
            // The product change is still valid if storage cleanup fails.
        }
    }

    private String required(String value, String message) {
        if (value == null || value.isBlank()) throw new IllegalArgumentException(message);
        return value.trim();
    }

    private void redirectToCategoryProducts(HttpServletRequest req, HttpServletResponse resp, int cateId) throws IOException {
        resp.sendRedirect(req.getContextPath() + "/admin/product/list?cateId=" + cateId);
    }
}

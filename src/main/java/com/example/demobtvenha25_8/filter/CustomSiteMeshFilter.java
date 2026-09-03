package com.example.demobtvenha25_8.filter;

import jakarta.servlet.annotation.WebFilter;
import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;

@WebFilter("/*")
public class CustomSiteMeshFilter extends ConfigurableSiteMeshFilter {

    @Override
    protected void applyCustomConfiguration(SiteMeshFilterBuilder builder) {
        builder
                // Đặt prefix rỗng để không bị tự động nối chuỗi lặp /WEB-INF/decorators/
                .setDecoratorPrefix("")
                
                // Quản trị Category Decorator
                .addDecoratorPath("/admin/*", "/WEB-INF/decorators/admin.jsp")
                
                // Giao diện chung người dùng Decorator
                .addDecoratorPath("/*", "/WEB-INF/decorators/web.jsp")
                
                // Loại trừ các đường dẫn không bọc decorator
                .addExcludedPath("/WEB-INF/*")
                .addExcludedPath("/views/login.jsp")
                .addExcludedPath("/views/register.jsp")
                .addExcludedPath("/login")
                .addExcludedPath("/register")
                .addExcludedPath("/image*")
                .addExcludedPath("/static/*")
                .addExcludedPath("/css/*")
                .addExcludedPath("/js/*");
    }
}

package com.example.demobtvenha25_8.model;

import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import jakarta.persistence.Id;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Column;
import jakarta.persistence.OneToMany;
import jakarta.persistence.CascadeType;
import jakarta.persistence.FetchType;
import java.util.List;

@Entity
@Table(name = "Category")
public class Category {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "cate_id")
    private int cateId;

    @Column(name = "cate_name", nullable = false)
    private String cateName;

    @Column(name = "icons")
    private String icons;

    public Category() {
    }
    // Thêm field sau các field hiện tại
    @OneToMany(mappedBy = "category", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Product> products;
    public Category(int cateId, String cateName, String icons) {
        this.cateId = cateId;
        this.cateName = cateName;
        this.icons = icons;
    }

    public Category(String cateName, String icons) {
        this.cateName = cateName;
        this.icons = icons;
    }

    public int getCateId() {
        return cateId;
    }

    public void setCateId(int cateId) {
        this.cateId = cateId;
    }

    public String getCateName() {
        return cateName;
    }

    public void setCateName(String cateName) {
        this.cateName = cateName;
    }

    public String getIcons() {
        return icons;
    }

    public void setIcons(String icons) {
        this.icons = icons;
    }

    // Thêm getter và setter
    public List<Product> getProducts() { return products; }
    public void setProducts(List<Product> products) { this.products = products; }
    @Override
    public String toString() {
        return "Category{" +
                "cateId=" + cateId +
                ", cateName='" + cateName + '\'' +
                ", icons='" + icons + '\'' +
                '}';
    }
}

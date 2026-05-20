package com.uniquefancy.model;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;

/**
 * Model class representing a product in the store.
 */
public class Product {
    private int           productId;
    private String        productName;
    private String        description;
    private BigDecimal    price;
    private int           stock;
    private String        image;
    private int           categoryId;
    private String        categoryName;
    private Timestamp     createdAt;
    private List<ProductSize> sizes;

    public Product() {}

    // ---- Getters ----
    public int           getProductId()   { return productId; }
    public String        getProductName() { return productName; }
    public String        getDescription() { return description; }
    public BigDecimal    getPrice()       { return price; }
    public int           getStock()       { return stock; }
    public String        getImage()       { return image; }
    public int           getCategoryId()  { return categoryId; }
    public String        getCategoryName(){ return categoryName; }
    public Timestamp     getCreatedAt()   { return createdAt; }
    public List<ProductSize> getSizes()   { return sizes; }

    // ---- Setters ----
    public void setProductId(int productId)          { this.productId   = productId; }
    public void setProductName(String productName)   { this.productName = productName; }
    public void setDescription(String description)   { this.description = description; }
    public void setPrice(BigDecimal price)           { this.price       = price; }
    public void setStock(int stock)                  { this.stock       = stock; }
    public void setImage(String image)               { this.image       = image; }
    public void setCategoryId(int categoryId)        { this.categoryId  = categoryId; }
    public void setCategoryName(String categoryName) { this.categoryName = categoryName; }
    public void setCreatedAt(Timestamp createdAt)    { this.createdAt   = createdAt; }
    public void setSizes(List<ProductSize> sizes)    { this.sizes       = sizes; }

    /** Returns true if product is low on stock (< 10 units). */
    public boolean isLowStock() { return stock < 10; }

    /** Returns true if product is out of stock. */
    public boolean isOutOfStock() { return stock <= 0; }

    /** Get discounted price (10% off for featured products). */
    public BigDecimal getDiscountedPrice() {
        return price.multiply(new BigDecimal("0.9"));
    }

    @Override
    public String toString() {
        return "Product{id=" + productId + ", name='" + productName + "', price=" + price + "}";
    }
}
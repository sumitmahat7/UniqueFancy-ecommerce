package com.uniquefancy.model;

/**
 * Model class representing size-wise stock for a product.
 */
public class ProductSize {
    private int    sizeId;
    private int    productId;
    private String sizeName;
    private int    sizeStock;

    public ProductSize() {}

    public ProductSize(int sizeId, int productId, String sizeName, int sizeStock) {
        this.sizeId    = sizeId;
        this.productId = productId;
        this.sizeName  = sizeName;
        this.sizeStock = sizeStock;
    }

    public int    getSizeId()    { return sizeId; }
    public int    getProductId() { return productId; }
    public String getSizeName()  { return sizeName; }
    public int    getSizeStock() { return sizeStock; }

    public void setSizeId(int sizeId)       { this.sizeId    = sizeId; }
    public void setProductId(int productId) { this.productId = productId; }
    public void setSizeName(String sizeName){ this.sizeName  = sizeName; }
    public void setSizeStock(int sizeStock) { this.sizeStock = sizeStock; }
}
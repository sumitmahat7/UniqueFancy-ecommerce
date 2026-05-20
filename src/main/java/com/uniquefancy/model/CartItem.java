package com.uniquefancy.model;

import java.math.BigDecimal;

/**
 * Model class representing a single item in the shopping cart.
 * Cart is stored in HttpSession as List&lt;CartItem&gt;.
 */
public class CartItem {
    private int        productId;
    private String     productName;
    private String     productImage;
    private String     size;
    private int        quantity;
    private BigDecimal unitPrice;

    public CartItem() {}

    public CartItem(int productId, String productName, String productImage,
                    String size, int quantity, BigDecimal unitPrice) {
        this.productId    = productId;
        this.productName  = productName;
        this.productImage = productImage;
        this.size         = size;
        this.quantity     = quantity;
        this.unitPrice    = unitPrice;
    }

    // ---- Getters ----
    public int        getProductId()    { return productId; }
    public String     getProductName()  { return productName; }
    public String     getProductImage() { return productImage; }
    public String     getSize()         { return size; }
    public int        getQuantity()     { return quantity; }
    public BigDecimal getUnitPrice()    { return unitPrice; }

    // Alias for getUnitPrice() to work with OrderServlet
    public BigDecimal getPrice()        { return unitPrice; }

    // Alias for getProductImage() to work with other classes
    public String     getImage()        { return productImage; }

    /** Subtotal = unitPrice × quantity */
    public BigDecimal getSubtotal() {
        return unitPrice.multiply(new BigDecimal(quantity));
    }

    // ---- Setters ----
    public void setProductId(int productId)       { this.productId    = productId; }
    public void setProductName(String name)       { this.productName  = name; }
    public void setProductImage(String img)       { this.productImage = img; }
    public void setSize(String size)              { this.size         = size; }
    public void setQuantity(int quantity)         { this.quantity     = quantity; }
    public void setUnitPrice(BigDecimal price)    { this.unitPrice    = price; }

    /** Unique key combining productId and size for cart lookup. */
    public String getCartKey() {
        return productId + "_" + size;
    }
}
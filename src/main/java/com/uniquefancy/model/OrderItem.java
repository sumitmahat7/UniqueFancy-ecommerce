package com.uniquefancy.model;

import java.math.BigDecimal;

/**
 * Model class representing one line-item within an order.
 */
public class OrderItem {
    private int        orderItemId;
    private int        orderId;
    private int        productId;
    private String     productName;
    private String     productImage;
    private int        quantity;
    private BigDecimal price;
    private String     size;

    public OrderItem() {}

    // ---- Getters ----
    public int        getOrderItemId()  { return orderItemId; }
    public int        getOrderId()      { return orderId; }
    public int        getProductId()    { return productId; }
    public String     getProductName()  { return productName; }
    public String     getProductImage() { return productImage; }
    public int        getQuantity()     { return quantity; }
    public BigDecimal getPrice()        { return price; }
    public String     getSize()         { return size; }

    /** Subtotal = price × quantity */
    public BigDecimal getSubtotal() {
        return price.multiply(new BigDecimal(quantity));
    }

    // ---- Setters ----
    public void setOrderItemId(int id)           { this.orderItemId  = id; }
    public void setOrderId(int orderId)          { this.orderId      = orderId; }
    public void setProductId(int productId)      { this.productId    = productId; }
    public void setProductName(String name)      { this.productName  = name; }
    public void setProductImage(String img)      { this.productImage = img; }
    public void setQuantity(int quantity)        { this.quantity     = quantity; }
    public void setPrice(BigDecimal price)       { this.price        = price; }
    public void setSize(String size)             { this.size         = size; }
}
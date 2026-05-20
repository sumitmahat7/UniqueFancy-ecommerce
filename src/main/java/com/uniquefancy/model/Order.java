package com.uniquefancy.model;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;

/**
 * Model class representing a customer order.
 */
public class Order {
    private int          orderId;
    private int          userId;
    private String       userName;
    private String       userEmail;
    private Timestamp    orderDate;
    private BigDecimal   totalAmount;
    private String       status;
    private String       paymentMethod;
    private String       shippingAddress;
    private List<OrderItem> items;

    public Order() {}

    // ---- Getters ----
    public int         getOrderId()        { return orderId; }
    public int         getUserId()         { return userId; }
    public String      getUserName()       { return userName; }
    public String      getUserEmail()      { return userEmail; }
    public Timestamp   getOrderDate()      { return orderDate; }
    public BigDecimal  getTotalAmount()    { return totalAmount; }
    public String      getStatus()         { return status; }
    public String      getPaymentMethod()  { return paymentMethod; }
    public String      getShippingAddress(){ return shippingAddress; }
    public List<OrderItem> getItems()      { return items; }

    // ---- Setters ----
    public void setOrderId(int orderId)                  { this.orderId         = orderId; }
    public void setUserId(int userId)                    { this.userId          = userId; }
    public void setUserName(String name)                 { this.userName        = name; }
    public void setUserEmail(String email)               { this.userEmail       = email; }
    public void setOrderDate(Timestamp orderDate)        { this.orderDate       = orderDate; }
    public void setTotalAmount(BigDecimal totalAmount)   { this.totalAmount     = totalAmount; }
    public void setStatus(String status)                 { this.status          = status; }
    public void setPaymentMethod(String paymentMethod)   { this.paymentMethod   = paymentMethod; }
    public void setShippingAddress(String addr)          { this.shippingAddress = addr; }
    public void setItems(List<OrderItem> items)          { this.items           = items; }

    public boolean isCancellable() { return "pending".equalsIgnoreCase(status); }
}
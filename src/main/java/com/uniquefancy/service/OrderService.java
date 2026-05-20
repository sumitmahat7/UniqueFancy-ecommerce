package com.uniquefancy.service;

import com.uniquefancy.dao.OrderDAO;
import com.uniquefancy.dao.ProductDAO;
import com.uniquefancy.model.*;

import java.math.BigDecimal;
import java.util.List;

/**
 * Service layer for order-related business logic.
 */
public class OrderService {

    private final OrderDAO   orderDAO   = new OrderDAO();
    private final ProductDAO productDAO = new ProductDAO();

    /**
     * Places an order and reduces stock for each item.
     * @param order     Order metadata (userId, address, payment)
     * @param items     List of order items
     * @return generated orderId, or -1 on failure
     */
    public int placeOrder(Order order, List<OrderItem> items) {
        // Verify stock
        for (OrderItem item : items) {
            Product p = productDAO.getProductById(item.getProductId());
            if (p == null || p.getStock() < item.getQuantity()) return -1;
        }

        // Calculate total
        BigDecimal total = items.stream()
                .map(OrderItem::getSubtotal)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
        order.setTotalAmount(total);

        int orderId = orderDAO.createOrder(order);
        if (orderId < 0) return -1;

        for (OrderItem item : items) {
            item.setOrderId(orderId);
            orderDAO.addOrderItem(item);
        }

        // Reduce stock
        for (OrderItem item : items) {
            productDAO.updateStock(item.getProductId(), item.getSize(), item.getQuantity());
        }

        return orderId;
    }

    public List<Order> getOrdersByUser(int userId)    { return orderDAO.getOrdersByUser(userId); }
    public Order       getOrderById(int orderId)      { return orderDAO.getOrderById(orderId); }
    public List<Order> getAllOrders()                  { return orderDAO.getAllOrders(); }
    public boolean     updateStatus(int id, String s) { return orderDAO.updateOrderStatus(id, s); }
    public boolean     cancelOrder(int id)            { return orderDAO.cancelOrder(id); }

    // Sales analytics (return double to match OrderDAO)
    public double getTotalSales()   { return orderDAO.getTotalSales(); }
    public double getTodaySales()   { return orderDAO.getTodaySales(); }
    public double getMonthlySales() { return orderDAO.getMonthlySales(); }
    public int    getTotalOrders()  { return orderDAO.getTotalOrderCount(); }
}
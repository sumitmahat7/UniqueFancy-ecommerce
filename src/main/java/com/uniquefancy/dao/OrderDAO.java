package com.uniquefancy.dao;

import com.uniquefancy.model.Order;
import com.uniquefancy.model.OrderItem;
import com.uniquefancy.util.DBConnection;


import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Handles all database operations for orders.
 * This class manages everything from creating orders to updating status and generating sales reports.
 */
public class OrderDAO {

    /**
     * Saves a new order to the database and returns the generated order ID.
     * The order starts with "pending" status by default.
     *
     * @param order The order to save
     * @return The auto-generated order ID, or -1 if something went wrong
     */
    public int createOrder(Order order) {
        String sql = "INSERT INTO orders (user_id, total_amount, status, payment_method, shipping_address) VALUES (?,?,?,?,?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, order.getUserId());
            ps.setBigDecimal(2, order.getTotalAmount());
            ps.setString(3, order.getStatus() != null ? order.getStatus() : "pending");
            ps.setString(4, order.getPaymentMethod());
            ps.setString(5, order.getShippingAddress());
            ps.executeUpdate();
            ResultSet keys = ps.getGeneratedKeys();
            if (keys.next()) return keys.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    /**
     * Adds a single product item to an existing order.
     *
     * @param item The order item to add (product, quantity, size, price)
     * @return true if saved successfully, false otherwise
     */
    public boolean addOrderItem(OrderItem item) {
        String sql = "INSERT INTO order_items (order_id, product_id, quantity, price, size) VALUES (?,?,?,?,?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, item.getOrderId());
            ps.setInt(2, item.getProductId());
            ps.setInt(3, item.getQuantity());
            ps.setBigDecimal(4, item.getPrice());
            ps.setString(5, item.getSize());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Gets all orders placed by a specific user, newest first.
     * Includes the customer's name and email for easy reference.
     *
     * @param userId The user's ID
     * @return List of orders, empty list if none found
     */
    public List<Order> getOrdersByUser(int userId) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT o.*, u.full_name, u.email FROM orders o " +
                "JOIN users u ON o.user_id = u.user_id " +
                "WHERE o.user_id = ? ORDER BY o.order_date DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order order = mapRow(rs);
                order.setUserName(rs.getString("full_name"));
                order.setUserEmail(rs.getString("email"));
                list.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Fetches a single order with all its details - customer info and items.
     * Perfect for the order details page.
     *
     * @param orderId The order ID to look up
     * @return Complete order object, or null if not found
     */
    public Order getOrderById(int orderId) {
        String sql = "SELECT o.*, u.full_name, u.email FROM orders o " +
                "JOIN users u ON o.user_id = u.user_id " +
                "WHERE o.order_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Order order = mapRow(rs);
                order.setUserName(rs.getString("full_name"));
                order.setUserEmail(rs.getString("email"));
                order.setItems(getOrderItems(orderId));
                return order;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Retrieves all items (products) that belong to a specific order.
     * Joins with products table to get the product names.
     *
     * @param orderId The order ID
     * @return List of items in that order
     */
    public List<OrderItem> getOrderItems(int orderId) {
        List<OrderItem> items = new ArrayList<>();
        String sql = "SELECT oi.*, p.product_name FROM order_items oi " +
                "JOIN products p ON oi.product_id = p.product_id WHERE oi.order_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                OrderItem item = new OrderItem();
                item.setOrderItemId(rs.getInt("order_item_id"));
                item.setOrderId(rs.getInt("order_id"));
                item.setProductId(rs.getInt("product_id"));
                item.setProductName(rs.getString("product_name"));
                item.setQuantity(rs.getInt("quantity"));
                item.setPrice(rs.getBigDecimal("price"));
                item.setSize(rs.getString("size"));
                items.add(item);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return items;
    }

    /**
     * Gets every order in the system with customer details.
     * Used by the admin panel to manage all orders.
     *
     * @return Complete list of all orders
     */
    public List<Order> getAllOrders() {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT o.*, u.full_name, u.email FROM orders o " +
                "JOIN users u ON o.user_id = u.user_id ORDER BY o.order_date DESC";
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                Order order = mapRow(rs);
                order.setUserName(rs.getString("full_name"));
                order.setUserEmail(rs.getString("email"));
                list.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Changes the status of an order (pending, processing, shipped, cancelled).
     * Used by admin when processing customer orders.
     *
     * @param orderId The order to update
     * @param newStatus The new status value
     * @return true if update worked, false if it failed
     */
    public boolean updateOrderStatus(int orderId, String newStatus) {
        String sql = "UPDATE orders SET status = ? WHERE order_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newStatus);
            ps.setInt(2, orderId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Cancels an order - only works if the order is still pending.
     * Customers can cancel their orders before they get processed.
     *
     * @param orderId The order to cancel
     * @return true if cancelled successfully, false otherwise
     */
    public boolean cancelOrder(int orderId) {
        String sql = "UPDATE orders SET status='cancelled' WHERE order_id=? AND status='pending'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Calculates total sales revenue from all completed orders (excluding cancelled).
     *
     * @return Total sales amount
     */
    public double getTotalSales() {
        String sql = "SELECT COALESCE(SUM(total_amount),0) FROM orders WHERE status != 'cancelled'";
        return querySingleDouble(sql);
    }

    /**
     * Gets today's total sales - only orders placed today.
     *
     * @return Today's sales revenue
     */
    public double getTodaySales() {
        String sql = "SELECT COALESCE(SUM(total_amount),0) FROM orders WHERE DATE(order_date) = CURDATE() AND status != 'cancelled'";
        return querySingleDouble(sql);
    }

    /**
     * Gets total sales for the current month.
     *
     * @return Monthly sales revenue
     */
    public double getMonthlySales() {
        String sql = "SELECT COALESCE(SUM(total_amount),0) FROM orders WHERE MONTH(order_date)=MONTH(CURDATE()) AND YEAR(order_date)=YEAR(CURDATE()) AND status != 'cancelled'";
        return querySingleDouble(sql);
    }

    /**
     * Counts how many orders exist in total.
     *
     * @return Total order count
     */
    public int getTotalOrderCount() {
        return queryCount("SELECT COUNT(*) FROM orders");
    }

    /**
     * Same as getTotalOrderCount() - just a different name for convenience.
     * Used by the admin dashboard.
     *
     * @return Total order count
     */
    public int getTotalOrders() {
        return getTotalOrderCount();
    }

    /**
     * Gets orders filtered by their current status.
     * Useful for admin to see all pending orders, shipped orders, etc.
     *
     * @param status The status to filter by (pending, processing, shipped, cancelled)
     * @return List of orders with that status
     */
    public List<Order> getOrdersByStatus(String status) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.*, u.full_name, u.email FROM orders o " +
                "JOIN users u ON o.user_id = u.user_id " +
                "WHERE o.status = ? ORDER BY o.order_date DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order order = mapRow(rs);
                order.setUserName(rs.getString("full_name"));
                order.setUserEmail(rs.getString("email"));
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    /**
     * Fetches the most recent orders for displaying on the admin dashboard.
     *
     * @param limit How many orders to get
     * @return List of recent orders
     */
    public List<Order> getRecentOrders(int limit) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.*, u.full_name, u.email FROM orders o " +
                "JOIN users u ON o.user_id = u.user_id " +
                "ORDER BY o.order_date DESC LIMIT ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order order = mapRow(rs);
                order.setUserName(rs.getString("full_name"));
                order.setUserEmail(rs.getString("email"));
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    /**
     * Calculates revenue only from delivered orders (completed sales).
     * Excludes pending, processing, shipped, and cancelled orders.
     *
     * @return Revenue from delivered orders
     */
    public double getTotalRevenue() {
        String sql = "SELECT COALESCE(SUM(total_amount), 0) FROM orders WHERE status = 'delivered'";
        return querySingleDouble(sql);
    }

    /**
     * Helper method that runs a query and returns a single number.
     *
     * @param sql The query to run
     * @return The result as a double
     */
    private double querySingleDouble(String sql) {
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            if (rs.next()) return rs.getDouble(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * Helper method that counts rows from a query.
     *
     * @param sql The count query
     * @return The count result
     */
    private int queryCount(String sql) {
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * Converts a database row into an Order object.
     * Used internally by many methods to avoid repeating code.
     *
     * @param rs The ResultSet containing order data
     * @return A populated Order object
     * @throws SQLException If there's an issue reading from the ResultSet
     */
    private Order mapRow(ResultSet rs) throws SQLException {
        Order order = new Order();
        order.setOrderId(rs.getInt("order_id"));
        order.setUserId(rs.getInt("user_id"));
        order.setOrderDate(rs.getTimestamp("order_date"));
        order.setTotalAmount(rs.getBigDecimal("total_amount"));
        order.setStatus(rs.getString("status"));
        order.setPaymentMethod(rs.getString("payment_method"));
        order.setShippingAddress(rs.getString("shipping_address"));
        return order;
    }
}
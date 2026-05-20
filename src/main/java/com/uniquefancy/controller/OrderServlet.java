package com.uniquefancy.controller;

import com.uniquefancy.dao.OrderDAO;
import com.uniquefancy.dao.ProductDAO;
import com.uniquefancy.model.*;
import com.uniquefancy.util.FlashMessageUtil;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

@WebServlet(urlPatterns = {"/checkout", "/place-order", "/order-history", "/order-details", "/cancel-order"})
public class OrderServlet extends HttpServlet {
    private OrderDAO orderDAO = new OrderDAO();
    private ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();

        // Block admin from accessing order pages
        User user = (User) req.getSession().getAttribute("loggedInUser");
        if (user != null && "admin".equals(user.getRole())) {
            resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
            return;
        }

        if ("/checkout".equals(path)) {
            HttpSession session = req.getSession();
            List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

            if (user == null) {
                resp.sendRedirect(req.getContextPath() + "/login");
                return;
            }

            if (cart == null || cart.isEmpty()) {
                FlashMessageUtil.setError(req, "Your cart is empty");
                resp.sendRedirect(req.getContextPath() + "/cart");
                return;
            }

            BigDecimal total = BigDecimal.ZERO;
            for (CartItem item : cart) {
                total = total.add(item.getPrice().multiply(BigDecimal.valueOf(item.getQuantity())));
            }

            req.setAttribute("user", user);
            req.setAttribute("cart", cart);
            req.setAttribute("cartTotal", total);
            req.getRequestDispatcher("/WEB-INF/views/public/checkout.jsp").forward(req, resp);

        } else if ("/order-history".equals(path)) {
            if (user == null) {
                resp.sendRedirect(req.getContextPath() + "/login");
                return;
            }
            List<Order> orders = orderDAO.getOrdersByUser(user.getUserId());
            req.setAttribute("orders", orders);
            req.getRequestDispatcher("/WEB-INF/views/public/order-history.jsp").forward(req, resp);

        } else if ("/order-details".equals(path)) {
            int id = Integer.parseInt(req.getParameter("id"));
            Order order = orderDAO.getOrderById(id);
            List<OrderItem> items = orderDAO.getOrderItems(id);
            req.setAttribute("order", order);
            req.setAttribute("items", items);
            req.getRequestDispatcher("/WEB-INF/views/public/order-details.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String path = req.getServletPath();

        // Block admin from placing or cancelling orders
        User user = (User) req.getSession().getAttribute("loggedInUser");
        if (user != null && "admin".equals(user.getRole())) {
            resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
            return;
        }

        if ("/place-order".equals(path)) {
            HttpSession session = req.getSession();

            if (user == null) {
                resp.sendRedirect(req.getContextPath() + "/login");
                return;
            }

            List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

            if (cart == null || cart.isEmpty()) {
                FlashMessageUtil.setError(req, "Your cart is empty");
                resp.sendRedirect(req.getContextPath() + "/cart");
                return;
            }

            // Calculate total
            BigDecimal total = BigDecimal.ZERO;
            for (CartItem ci : cart) {
                BigDecimal itemTotal = ci.getPrice().multiply(BigDecimal.valueOf(ci.getQuantity()));
                total = total.add(itemTotal);
            }

            // Add shipping if total < 5000
            if (total.compareTo(BigDecimal.valueOf(5000)) < 0) {
                total = total.add(BigDecimal.valueOf(150));
            }

            // Create order with user details
            Order order = new Order();
            order.setUserId(user.getUserId());
            order.setUserName(user.getFullName());
            order.setUserEmail(user.getEmail());
            order.setTotalAmount(total);
            order.setPaymentMethod(req.getParameter("paymentMethod"));
            order.setShippingAddress(req.getParameter("shippingAddress"));
            order.setStatus("pending");

            int orderId = orderDAO.createOrder(order);

            if (orderId > 0) {
                for (CartItem ci : cart) {
                    OrderItem oi = new OrderItem();
                    oi.setOrderId(orderId);
                    oi.setProductId(ci.getProductId());
                    oi.setQuantity(ci.getQuantity());
                    oi.setPrice(ci.getPrice());
                    oi.setSize(ci.getSize());
                    orderDAO.addOrderItem(oi);
                    productDAO.updateStock(ci.getProductId(), ci.getSize(), ci.getQuantity());
                }

                session.setAttribute("cart", new ArrayList<>());
                FlashMessageUtil.setSuccess(req, "Order placed successfully");
                resp.sendRedirect(req.getContextPath() + "/order-history");
            } else {
                FlashMessageUtil.setError(req, "Failed to place order. Please try again.");
                resp.sendRedirect(req.getContextPath() + "/checkout");
            }

        } else if ("/cancel-order".equals(path)) {
            int id = Integer.parseInt(req.getParameter("orderId"));
            orderDAO.cancelOrder(id);
            FlashMessageUtil.setSuccess(req, "Order cancelled successfully");
            resp.sendRedirect(req.getContextPath() + "/order-history");
        }
    }
}
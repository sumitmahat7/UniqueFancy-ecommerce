package com.uniquefancy.controller;

import com.uniquefancy.dao.ProductDAO;
import com.uniquefancy.dao.CategoryDAO;
import com.uniquefancy.dao.OrderDAO;
import com.uniquefancy.dao.UserDAO;
import com.uniquefancy.model.Product;
import com.uniquefancy.model.Category;
import com.uniquefancy.model.Order;
import com.uniquefancy.model.User;
import com.uniquefancy.util.FlashMessageUtil;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/admin/*")
public class AdminServlet extends HttpServlet {
    private ProductDAO productDAO = new ProductDAO();
    private CategoryDAO categoryDAO = new CategoryDAO();
    private OrderDAO orderDAO = new OrderDAO();
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String path = req.getPathInfo();

        // Dashboard - fixed duplicate condition
        if (path == null || "/dashboard".equals(path)) {
            // Statistics
            req.setAttribute("totalProducts", productDAO.getProductCount());
            req.setAttribute("totalOrders", orderDAO.getTotalOrderCount());
            req.setAttribute("totalUsers", userDAO.getUserCount());
            req.setAttribute("totalRevenue", orderDAO.getTotalRevenue());

            // Recent Orders
            req.setAttribute("recentOrders", orderDAO.getRecentOrders(5));

            // Recent Users
            req.setAttribute("recentUsers", userDAO.getRecentUsers(5));

            req.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(req, resp);

        } else if ("/manage-products".equals(path)) {
            List<Product> products = productDAO.getAllProducts();
            req.setAttribute("products", products);
            req.getRequestDispatcher("/WEB-INF/views/admin/manage-products.jsp").forward(req, resp);

        } else if ("/add-product".equals(path)) {
            List<Category> categories = categoryDAO.getAllCategories();
            req.setAttribute("categories", categories);
            req.getRequestDispatcher("/WEB-INF/views/admin/add-product.jsp").forward(req, resp);

        } else if ("/edit-product".equals(path)) {
            int id = Integer.parseInt(req.getParameter("id"));
            Product product = productDAO.getProductById(id);
            List<Category> categories = categoryDAO.getAllCategories();
            req.setAttribute("product", product);
            req.setAttribute("categories", categories);
            req.getRequestDispatcher("/WEB-INF/views/admin/edit-product.jsp").forward(req, resp);

        } else if ("/manage-categories".equals(path)) {
            List<Category> categories = categoryDAO.getAllCategories();
            req.setAttribute("categories", categories);
            req.getRequestDispatcher("/WEB-INF/views/admin/manage-categories.jsp").forward(req, resp);

        } else if ("/manage-orders".equals(path)) {
            String status = req.getParameter("status");
            List<Order> orders;
            if (status != null && !status.isEmpty()) {
                orders = orderDAO.getOrdersByStatus(status);
            } else {
                orders = orderDAO.getAllOrders();
            }
            req.setAttribute("orders", orders);
            req.getRequestDispatcher("/WEB-INF/views/admin/manage-orders.jsp").forward(req, resp);

        } else if ("/order-detail".equals(path)) {
            int id = Integer.parseInt(req.getParameter("id"));
            Order order = orderDAO.getOrderById(id);
            req.setAttribute("order", order);
            req.getRequestDispatcher("/WEB-INF/views/admin/Order-detail.jsp").forward(req, resp);

        } else if ("/manage-users".equals(path)) {
            List<User> users = userDAO.getAllUsers();
            req.setAttribute("users", users);
            req.getRequestDispatcher("/WEB-INF/views/admin/manage-users.jsp").forward(req, resp);

        } else if ("/user-detail".equals(path)) {
            int id = Integer.parseInt(req.getParameter("id"));
            User user = userDAO.getUserById(id);
            List<Order> orders = orderDAO.getOrdersByUser(id);
            req.setAttribute("user", user);
            req.setAttribute("orders", orders);
            req.getRequestDispatcher("/WEB-INF/views/admin/user-detail.jsp").forward(req, resp);

        } else if ("/reports".equals(path)) {
            double totalSales = orderDAO.getTotalSales();
            double todaySales = orderDAO.getTodaySales();
            double monthlySales = orderDAO.getMonthlySales();
            int totalOrders = orderDAO.getTotalOrders();
            List<Product> topProducts = productDAO.getTopSellingProducts();
            List<Product> lowStock = productDAO.getLowStockProducts();

            req.setAttribute("totalSales", totalSales);
            req.setAttribute("todaySales", todaySales);
            req.setAttribute("monthlySales", monthlySales);
            req.setAttribute("totalOrders", totalOrders);
            req.setAttribute("topProducts", topProducts);
            req.setAttribute("lowStock", lowStock);
            req.getRequestDispatcher("/WEB-INF/views/admin/reports.jsp").forward(req, resp);

        } else {
            resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        String path = req.getPathInfo();

        if ("/add-product".equals(path)) {
            Product product = new Product();
            product.setProductName(req.getParameter("productName"));
            product.setDescription(req.getParameter("description"));
            product.setPrice(BigDecimal.valueOf(Double.parseDouble(req.getParameter("price"))));
            product.setStock(Integer.parseInt(req.getParameter("stock")));
            product.setImage(req.getParameter("image"));
            product.setCategoryId(Integer.parseInt(req.getParameter("categoryId")));
            productDAO.addProduct(product);
            FlashMessageUtil.setSuccess(req, "Product added successfully");
            resp.sendRedirect(req.getContextPath() + "/admin/manage-products");

        } else if ("/update-product".equals(path)) {
            Product product = new Product();
            product.setProductId(Integer.parseInt(req.getParameter("productId")));
            product.setProductName(req.getParameter("productName"));
            product.setDescription(req.getParameter("description"));
            product.setPrice(BigDecimal.valueOf(Double.parseDouble(req.getParameter("price"))));
            product.setStock(Integer.parseInt(req.getParameter("stock")));
            product.setImage(req.getParameter("image"));
            product.setCategoryId(Integer.parseInt(req.getParameter("categoryId")));
            productDAO.updateProduct(product);
            FlashMessageUtil.setSuccess(req, "Product updated successfully");
            resp.sendRedirect(req.getContextPath() + "/admin/manage-products");

        } else if ("/delete-product".equals(path)) {
            int id = Integer.parseInt(req.getParameter("productId"));
            productDAO.deleteProduct(id);
            FlashMessageUtil.setSuccess(req, "Product deleted successfully");
            resp.sendRedirect(req.getContextPath() + "/admin/manage-products");

        } else if ("/add-category".equals(path)) {
            Category category = new Category();
            category.setCategoryName(req.getParameter("categoryName"));
            category.setDescription(req.getParameter("description"));
            categoryDAO.addCategory(category);
            FlashMessageUtil.setSuccess(req, "Category added successfully");
            resp.sendRedirect(req.getContextPath() + "/admin/manage-categories");

        } else if ("/update-category".equals(path)) {
            Category category = new Category();
            category.setCategoryId(Integer.parseInt(req.getParameter("categoryId")));
            category.setCategoryName(req.getParameter("categoryName"));
            category.setDescription(req.getParameter("description"));
            categoryDAO.updateCategory(category);
            FlashMessageUtil.setSuccess(req, "Category updated successfully");
            resp.sendRedirect(req.getContextPath() + "/admin/manage-categories");

        } else if ("/delete-category".equals(path)) {
            int id = Integer.parseInt(req.getParameter("categoryId"));
            categoryDAO.deleteCategory(id);
            FlashMessageUtil.setSuccess(req, "Category deleted successfully");
            resp.sendRedirect(req.getContextPath() + "/admin/manage-categories");

        } else if ("/update-order".equals(path)) {
            int id = Integer.parseInt(req.getParameter("orderId"));
            String status = req.getParameter("status");
            orderDAO.updateOrderStatus(id, status);
            FlashMessageUtil.setSuccess(req, "Order status updated successfully");
            resp.sendRedirect(req.getContextPath() + "/admin/manage-orders");

        } else {
            resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
        }
    }
}
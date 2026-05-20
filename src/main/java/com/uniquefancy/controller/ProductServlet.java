package com.uniquefancy.controller;

import com.uniquefancy.dao.ProductDAO;
import com.uniquefancy.dao.CategoryDAO;
import com.uniquefancy.model.Product;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/products", "/product-details"})
public class ProductServlet extends HttpServlet {
    private ProductDAO productDAO = new ProductDAO();
    private CategoryDAO categoryDAO = new CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();

        if ("/products".equals(path)) {
            // Pagination parameters
            int currentPage = 1;
            int itemsPerPage = 8;

            String pageParam = req.getParameter("page");
            if (pageParam != null && !pageParam.isEmpty()) {
                currentPage = Integer.parseInt(pageParam);
            }

            String search = req.getParameter("search");
            String catId = req.getParameter("category");

            // Calculate offset
            int offset = (currentPage - 1) * itemsPerPage;

            // Get products and total count based on search/filter
            List<Product> products;
            int totalProducts;

            if (search != null && !search.isEmpty()) {
                totalProducts = productDAO.getSearchCount(search);
                products = productDAO.searchProducts(search, offset, itemsPerPage);
            } else if (catId != null && !catId.isEmpty()) {
                totalProducts = productDAO.getCategoryCount(Integer.parseInt(catId));
                products = productDAO.getProductsByCategory(Integer.parseInt(catId), offset, itemsPerPage);
            } else {
                totalProducts = productDAO.getTotalProductCount();
                products = productDAO.getProductsByPage(offset, itemsPerPage);
            }

            // Calculate total pages
            int totalPages = (int) Math.ceil((double) totalProducts / itemsPerPage);

            // Set attributes for JSP
            req.setAttribute("products", products);
            req.setAttribute("categories", categoryDAO.getAllCategories());
            req.setAttribute("currentPage", currentPage);
            req.setAttribute("totalPages", totalPages);
            req.setAttribute("hasPrevious", currentPage > 1);
            req.setAttribute("hasNext", currentPage < totalPages);

            req.getRequestDispatcher("/WEB-INF/views/public/products.jsp").forward(req, resp);

        } else if ("/product-details".equals(path)) {
            int id = Integer.parseInt(req.getParameter("id"));
            Product product = productDAO.getProductById(id);
            req.setAttribute("product", product);
            req.getRequestDispatcher("/WEB-INF/views/public/product-details.jsp").forward(req, resp);
        }
    }
}
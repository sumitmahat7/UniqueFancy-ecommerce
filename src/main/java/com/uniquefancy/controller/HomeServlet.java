package com.uniquefancy.controller;

import com.uniquefancy.dao.ProductDAO;
import com.uniquefancy.model.Product;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet({"/", "/home"})
public class HomeServlet extends HttpServlet {
    private ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Product> featured = productDAO.getFeaturedProducts();
        req.setAttribute("featuredProducts", featured);
        req.getRequestDispatcher("/WEB-INF/views/public/index.jsp").forward(req, resp);
    }
}
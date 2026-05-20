package com.uniquefancy.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

@WebFilter("/*")
public class AuthFilter implements Filter {

    // List of valid paths that should be handled by the application
    private static final List<String> VALID_PATHS = Arrays.asList(
            "/", "/login", "/register", "/logout",
            "/products", "/product-details", "/cart", "/wishlist",
            "/checkout", "/place-order", "/order-history", "/order-details",
            "/cancel-order", "/profile", "/home",
            "/about.jsp", "/contact.jsp"
    );

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        String path = req.getRequestURI().substring(req.getContextPath().length());

        HttpSession session = req.getSession(false);
        boolean loggedIn = (session != null && session.getAttribute("loggedInUser") != null);

        // Check if it's a static JSP in webapp root (about.jsp, contact.jsp, etc.)
        boolean isStaticJsp = path.matches("/[a-zA-Z0-9_-]+\\.jsp");

        // Check if path starts with valid resource folders
        boolean isResource = path.startsWith("/css/") ||
                path.startsWith("/js/") ||
                path.startsWith("/images/");

        // Check if path is valid (exists in our application)
        boolean isValidPath = isStaticJsp || isResource;
        for (String validPath : VALID_PATHS) {
            if (path.equals(validPath) || path.startsWith(validPath + "?")) {
                isValidPath = true;
                break;
            }
        }

        // Also allow admin paths
        if (path.startsWith("/admin/")) {
            isValidPath = true;
        }

        // If path is not valid, show 404 error page
        if (!isValidPath) {
            resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
            req.getRequestDispatcher("/error/404.jsp").forward(req, resp);
            return;
        }

        // Public resources - allow without login
        boolean isPublic =
                path.equals("/") ||
                        path.equals("/login") ||
                        path.equals("/register") ||
                        path.equals("/products") ||
                        path.equals("/product-details") ||
                        isResource ||
                        isStaticJsp;

        // Allow public pages without login
        if (isPublic) {
            chain.doFilter(request, response);
            return;
        }

        // Admin pages - require login
        if (path.startsWith("/admin/")) {
            if (!loggedIn) {
                resp.sendRedirect(req.getContextPath() + "/login");
                return;
            }
            chain.doFilter(request, response);
            return;
        }

        // All other pages (cart, profile, wishlist, orders) require login
        if (!loggedIn) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        chain.doFilter(request, response);
    }
}
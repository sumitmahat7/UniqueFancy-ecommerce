package com.uniquefancy.controller;

import com.uniquefancy.dao.ProductDAO;
import com.uniquefancy.model.CartItem;
import com.uniquefancy.model.Product;
import com.uniquefancy.model.User;
import com.uniquefancy.util.CookieUtil;
import com.uniquefancy.util.FlashMessageUtil;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.lang.reflect.Type;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    private ProductDAO productDAO = new ProductDAO();
    private Gson gson = new Gson();

    // Load cart from session or cookie
    private List<CartItem> loadCart(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        if (cart == null) {
            String cartJson = CookieUtil.getCartFromCookie(request);
            if (cartJson != null && !cartJson.isEmpty()) {
                try {
                    Type type = new TypeToken<List<CartItem>>(){}.getType();
                    cart = gson.fromJson(cartJson, type);
                } catch (Exception e) {
                    cart = new ArrayList<>();
                }
            } else {
                cart = new ArrayList<>();
            }
            session.setAttribute("cart", cart);
        }
        return cart;
    }

    // Save cart to cookie
    private void saveCart(HttpServletRequest request, HttpServletResponse response) {
        List<CartItem> cart = (List<CartItem>) request.getSession().getAttribute("cart");
        if (cart != null && !cart.isEmpty()) {
            String cartJson = gson.toJson(cart);
            CookieUtil.saveCartToCookie(response, cartJson);
        } else {
            CookieUtil.clearCartCookie(response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Block admin from accessing cart
        User user = (User) req.getSession().getAttribute("loggedInUser");
        if (user != null && "admin".equals(user.getRole())) {
            resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
            return;
        }

        List<CartItem> cart = loadCart(req, resp);

        BigDecimal total = BigDecimal.ZERO;
        for (CartItem item : cart) {
            BigDecimal itemTotal = item.getPrice().multiply(BigDecimal.valueOf(item.getQuantity()));
            total = total.add(itemTotal);
        }

        req.setAttribute("cart", cart);
        req.setAttribute("total", total);
        req.getRequestDispatcher("/WEB-INF/views/public/cart.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        // Block admin from accessing cart
        User user = (User) req.getSession().getAttribute("loggedInUser");
        if (user != null && "admin".equals(user.getRole())) {
            resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
            return;
        }

        String action = req.getParameter("action");
        List<CartItem> cart = loadCart(req, resp);

        if ("update".equals(action)) {
            String cartKey = req.getParameter("cartKey");
            int newQuantity = Integer.parseInt(req.getParameter("quantity"));

            for (CartItem item : cart) {
                if (item.getCartKey().equals(cartKey)) {
                    if (newQuantity <= 0) {
                        cart.remove(item);
                    } else {
                        item.setQuantity(newQuantity);
                    }
                    break;
                }
            }
            FlashMessageUtil.setSuccess(req, "Cart updated successfully");
        } else if ("add".equals(action)) {
            int id = Integer.parseInt(req.getParameter("productId"));
            int qty = Integer.parseInt(req.getParameter("quantity"));
            String size = req.getParameter("size");

            if (size == null || size.isEmpty()) {
                size = "M";
            }

            Product p = productDAO.getProductById(id);
            if (p != null) {
                boolean found = false;
                for (CartItem item : cart) {
                    if (item.getProductId() == id && item.getSize().equals(size)) {
                        item.setQuantity(item.getQuantity() + qty);
                        found = true;
                        break;
                    }
                }
                if (!found) {
                    cart.add(new CartItem(id, p.getProductName(), p.getImage(), size, qty, p.getPrice()));
                    FlashMessageUtil.setSuccess(req, "Item added to cart successfully");
                } else {
                    FlashMessageUtil.setSuccess(req, "Cart updated successfully");
                }
            }
        } else if ("remove".equals(action)) {
            String key = req.getParameter("cartKey");
            cart.removeIf(c -> c.getCartKey().equals(key));
            FlashMessageUtil.setSuccess(req, "Item removed from cart");
        } else if ("clear".equals(action)) {
            cart.clear();
            FlashMessageUtil.setSuccess(req, "Cart cleared successfully");
        }

        req.getSession().setAttribute("cart", cart);
        saveCart(req, resp);
        resp.sendRedirect(req.getContextPath() + "/cart");
    }
}
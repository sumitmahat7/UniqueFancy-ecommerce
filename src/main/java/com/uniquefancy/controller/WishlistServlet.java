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

@WebServlet("/wishlist")
public class WishlistServlet extends HttpServlet {
    private ProductDAO productDAO = new ProductDAO();
    private Gson gson = new Gson();

    private List<Product> loadWishlist(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        List<Product> wishlist = (List<Product>) session.getAttribute("wishlist");

        if (wishlist == null) {
            String wishlistJson = CookieUtil.getWishlistFromCookie(request);
            if (wishlistJson != null && !wishlistJson.isEmpty()) {
                try {
                    Type type = new TypeToken<List<Product>>(){}.getType();
                    wishlist = gson.fromJson(wishlistJson, type);
                } catch (Exception e) {
                    wishlist = new ArrayList<>();
                }
            } else {
                wishlist = new ArrayList<>();
            }
            session.setAttribute("wishlist", wishlist);
        }
        return wishlist;
    }

    private void saveWishlist(HttpServletRequest request, HttpServletResponse response) {
        List<Product> wishlist = (List<Product>) request.getSession().getAttribute("wishlist");
        if (wishlist != null && !wishlist.isEmpty()) {
            String wishlistJson = gson.toJson(wishlist);
            CookieUtil.saveWishlistToCookie(response, wishlistJson);
        } else {
            CookieUtil.clearWishlistCookie(response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        User user = (User) req.getSession().getAttribute("loggedInUser");

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Block admin from accessing wishlist
        if ("admin".equals(user.getRole())) {
            resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
            return;
        }

        List<Product> wishlist = loadWishlist(req, resp);
        req.setAttribute("wishlist", wishlist);
        req.getRequestDispatcher("/WEB-INF/views/user/wishlist.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        User user = (User) req.getSession().getAttribute("loggedInUser");

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Block admin from accessing wishlist
        if ("admin".equals(user.getRole())) {
            resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
            return;
        }

        String action = req.getParameter("action");
        int productId = Integer.parseInt(req.getParameter("productId"));
        List<Product> wishlist = loadWishlist(req, resp);

        if ("add".equals(action)) {
            boolean exists = wishlist.stream().anyMatch(p -> p.getProductId() == productId);
            if (!exists) {
                Product product = productDAO.getProductById(productId);
                if (product != null) {
                    wishlist.add(product);
                    FlashMessageUtil.setSuccess(req, "Product added to wishlist");
                }
            } else {
                FlashMessageUtil.setInfo(req, "Product already in wishlist");
            }
        } else if ("remove".equals(action)) {
            wishlist.removeIf(p -> p.getProductId() == productId);
            FlashMessageUtil.setSuccess(req, "Product removed from wishlist");
        } else if ("moveCart".equals(action)) {
            String size = req.getParameter("size");

            if (size == null || size.isEmpty()) {
                FlashMessageUtil.setError(req, "Please select a size");
                resp.sendRedirect(req.getContextPath() + "/wishlist");
                return;
            }

            Product product = productDAO.getProductById(productId);

            if (product != null) {
                List<CartItem> cart = (List<CartItem>) req.getSession().getAttribute("cart");
                if (cart == null) {
                    cart = new ArrayList<>();
                }

                boolean found = false;
                for (CartItem item : cart) {
                    if (item.getProductId() == productId && item.getSize().equals(size)) {
                        item.setQuantity(item.getQuantity() + 1);
                        found = true;
                        break;
                    }
                }

                if (!found) {
                    CartItem newItem = new CartItem(
                            productId, product.getProductName(), product.getImage(), size, 1, product.getPrice());
                    cart.add(newItem);
                }

                req.getSession().setAttribute("cart", cart);
                String cartJson = gson.toJson(cart);
                CookieUtil.saveCartToCookie(resp, cartJson);

                wishlist.removeIf(p -> p.getProductId() == productId);
                req.getSession().setAttribute("wishlist", wishlist);
                String wishlistJson = gson.toJson(wishlist);
                CookieUtil.saveWishlistToCookie(resp, wishlistJson);

                FlashMessageUtil.setSuccess(req, "Item moved to cart successfully");
                resp.sendRedirect(req.getContextPath() + "/cart");
                return;
            }
        }

        req.getSession().setAttribute("wishlist", wishlist);
        saveWishlist(req, resp);
        resp.sendRedirect(req.getContextPath() + "/wishlist");
    }
}
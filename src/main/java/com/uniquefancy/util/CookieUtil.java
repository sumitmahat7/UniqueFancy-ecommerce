package com.uniquefancy.util;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.net.URLDecoder;
import java.net.URLEncoder;

/**
 * Helper class for working with cookies in the application.
 * Cookies are small pieces of data stored in the user's browser.
 * This class helps us create, read, and delete cookies easily.
 * We use cookies for three main purposes:
 * 1. Remember Me - saves user email for 7 days
 * 2. Cart Persistence - saves cart items even after logout (30 days)
 * 3. Wishlist Persistence - saves wishlist items even after logout (30 days)
 *
 */
public class CookieUtil {

    /**
     * Creates a new cookie and adds it to the response.
     * This is the main method that all other cookie methods use.
     *
     * @param response The response object to add the cookie to
     * @param name The name of the cookie (like "cart" or "rememberedEmail")
     * @param value The value to store in the cookie
     * @param maxAge How long the cookie should live in seconds (7 days = 604800 seconds)
     * @param path The URL path where the cookie is valid ("/" means whole website)
     */
    public static void createCookie(HttpServletResponse response, String name, String value, int maxAge, String path) {
        Cookie cookie = new Cookie(name, value);
        cookie.setMaxAge(maxAge);
        cookie.setPath(path);
        cookie.setHttpOnly(true);
        response.addCookie(cookie);
    }

    /**
     * Gets the value of a cookie by its name.
     *
     * @param request The request object containing all cookies
     * @param name The name of the cookie we want to read
     * @return The cookie value, or null if cookie doesn't exist
     */
    public static String getCookieValue(HttpServletRequest request, String name) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals(name)) {
                    return cookie.getValue();
                }
            }
        }
        return null;
    }

    /**
     * Deletes a cookie by setting its max age to 0.
     * Browser will remove the cookie immediately.
     *
     * @param response The response object to send the delete instruction
     * @param name The name of the cookie to delete
     * @param path The path where the cookie was valid
     */
    public static void deleteCookie(HttpServletResponse response, String name, String path) {
        Cookie cookie = new Cookie(name, "");
        cookie.setMaxAge(0);
        cookie.setPath(path);
        response.addCookie(cookie);
    }

    /**
     * Creates a "Remember Me" cookie that saves user's email for 7 days.
     * When user returns to login page, their email will be auto-filled.
     *
     * @param response The response object to add the cookie
     * @param email The user's email address to save
     */
    public static void createRememberMeCookie(HttpServletResponse response, String email) {
        createCookie(response, "rememberedEmail", email, 7 * 24 * 60 * 60, "/");
    }

    /**
     * Gets the saved email from Remember Me cookie.
     * Called when login page loads to auto-fill the email field.
     *
     * @param request The request object containing cookies
     * @return The saved email, or null if no cookie exists
     */
    public static String getRememberedEmail(HttpServletRequest request) {
        return getCookieValue(request, "rememberedEmail");
    }

    /**
     * Deletes the Remember Me cookie.
     * Called when user logs out or manually clears it.
     *
     * @param response The response object to delete the cookie
     */
    public static void clearRememberMeCookie(HttpServletResponse response) {
        deleteCookie(response, "rememberedEmail", "/");
    }

    // ============ CART COOKIE METHODS ============

    /**
     * Saves the shopping cart to a cookie.
     * Cart items are converted to JSON string before saving.
     * Cookie lasts for 30 days.
     *
     * @param response The response object to add the cookie
     * @param cartData JSON string containing all cart items
     */
    public static void saveCartToCookie(HttpServletResponse response, String cartData) {
        try {
            Cookie cookie = new Cookie("cart", URLEncoder.encode(cartData, "UTF-8"));
            cookie.setMaxAge(30 * 24 * 60 * 60);
            cookie.setPath("/");
            response.addCookie(cookie);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Retrieves the cart data from cookie.
     * Called when user logs in to restore their previous cart.
     *
     * @param request The request object containing cookies
     * @return JSON string of cart items, or null if no cart cookie exists
     */
    public static String getCartFromCookie(HttpServletRequest request) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("cart".equals(cookie.getName())) {
                    try {
                        return URLDecoder.decode(cookie.getValue(), "UTF-8");
                    } catch (Exception e) {
                        return null;
                    }
                }
            }
        }
        return null;
    }

    /**
     * Deletes the cart cookie.
     * Called when user clears their cart or logs out.
     *
     * @param response The response object to delete the cookie
     */
    public static void clearCartCookie(HttpServletResponse response) {
        Cookie cookie = new Cookie("cart", "");
        cookie.setMaxAge(0);
        cookie.setPath("/");
        response.addCookie(cookie);
    }

    // WISHLIST COOKIE METHODS

    /**
     * Saves the wishlist to a cookie.
     * Wishlist items are converted to JSON string before saving.
     * Cookie lasts for 30 days.
     *
     * @param response The response object to add the cookie
     * @param wishlistData JSON string containing all wishlist items
     */
    public static void saveWishlistToCookie(HttpServletResponse response, String wishlistData) {
        try {
            Cookie cookie = new Cookie("wishlist", URLEncoder.encode(wishlistData, "UTF-8"));
            cookie.setMaxAge(30 * 24 * 60 * 60);
            cookie.setPath("/");
            response.addCookie(cookie);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Retrieves the wishlist data from cookie.
     * Called when user logs in to restore their previous wishlist.
     *
     * @param request The request object containing cookies
     * @return JSON string of wishlist items, or null if no wishlist cookie exists
     */
    public static String getWishlistFromCookie(HttpServletRequest request) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("wishlist".equals(cookie.getName())) {
                    try {
                        return URLDecoder.decode(cookie.getValue(), "UTF-8");
                    } catch (Exception e) {
                        return null;
                    }
                }
            }
        }
        return null;
    }

    /**
     * Deletes the wishlist cookie.
     * Called when user removes all items from wishlist or logs out.
     *
     * @param response The response object to delete the cookie
     */
    public static void clearWishlistCookie(HttpServletResponse response) {
        Cookie cookie = new Cookie("wishlist", "");
        cookie.setMaxAge(0);
        cookie.setPath("/");
        response.addCookie(cookie);
    }
}
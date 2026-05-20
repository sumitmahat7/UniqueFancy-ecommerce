package com.uniquefancy.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * Utility class for flash messages.
 * Flash messages are temporary messages that survive only one redirect.
 * They are stored in session and automatically removed after being displayed.
 *
 */
public class FlashMessageUtil {

    /**
     * Stores a success message in session (survives one redirect)
     * @param request HttpServletRequest
     * @param message Success message to display
     */
    public static void setSuccess(HttpServletRequest request, String message) {
        HttpSession session = request.getSession();
        session.setAttribute("flashSuccess", message);
    }

    /**
     * Stores an error message in session (survives one redirect)
     * @param request HttpServletRequest
     * @param message Error message to display
     */
    public static void setError(HttpServletRequest request, String message) {
        HttpSession session = request.getSession();
        session.setAttribute("flashError", message);
    }

    /**
     * Stores an info message in session (survives one redirect)
     * @param request HttpServletRequest
     * @param message Info message to display
     */
    public static void setInfo(HttpServletRequest request, String message) {
        HttpSession session = request.getSession();
        session.setAttribute("flashInfo", message);
    }

    /**
     * Retrieves and removes flash messages from session.
     * Call this in every JSP that should display flash messages.
     * @param request HttpServletRequest
     */
    public static void getFlashMessages(HttpServletRequest request) {
        HttpSession session = request.getSession();

        if (session.getAttribute("flashSuccess") != null) {
            request.setAttribute("successMsg", session.getAttribute("flashSuccess"));
            session.removeAttribute("flashSuccess");
        }

        if (session.getAttribute("flashError") != null) {
            request.setAttribute("errorMsg", session.getAttribute("flashError"));
            session.removeAttribute("flashError");
        }

        if (session.getAttribute("flashInfo") != null) {
            request.setAttribute("infoMsg", session.getAttribute("flashInfo"));
            session.removeAttribute("flashInfo");
        }
    }
}
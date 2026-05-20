package com.uniquefancy.controller;

import com.uniquefancy.dao.UserDAO;
import com.uniquefancy.model.User;
import com.uniquefancy.util.ValidationUtil;
import com.uniquefancy.util.PasswordUtil;
import com.uniquefancy.util.CookieUtil;
import com.uniquefancy.util.FlashMessageUtil;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(urlPatterns = {"/login", "/register", "/logout"})
public class AuthServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        if ("/login".equals(path)) {
            // Check if already logged in
            HttpSession session = request.getSession(false);
            if (session != null && session.getAttribute("loggedInUser") != null) {
                User user = (User) session.getAttribute("loggedInUser");
                if ("admin".equals(user.getRole())) {
                    response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                } else {
                    response.sendRedirect(request.getContextPath() + "/");
                }
                return;
            }

            // Get remembered email from cookie
            String rememberedEmail = CookieUtil.getRememberedEmail(request);
            request.setAttribute("rememberedEmail", rememberedEmail);

            request.getRequestDispatcher("/WEB-INF/views/public/login.jsp")
                    .forward(request, response);

        } else if ("/register".equals(path)) {
            request.getRequestDispatcher("/WEB-INF/views/public/register.jsp")
                    .forward(request, response);

        } else if ("/logout".equals(path)) {
            doLogout(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        if ("/login".equals(path)) {
            doLogin(request, response);
        } else if ("/register".equals(path)) {
            doRegister(request, response);
        }
    }

    private void doLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String rememberMe = request.getParameter("rememberMe");

        // Validate input
        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            FlashMessageUtil.setError(request, "Email and password are required");
            request.getRequestDispatcher("/WEB-INF/views/public/login.jsp")
                    .forward(request, response);
            return;
        }

        // Check user credentials
        User user = userDAO.loginUser(email.trim(), password.trim());

        if (user != null) {
            // Create session
            HttpSession session = request.getSession();
            session.setAttribute("loggedInUser", user);
            session.setAttribute("userId", user.getUserId());
            session.setAttribute("userName", user.getFullName());
            session.setAttribute("userRole", user.getRole());
            session.setMaxInactiveInterval(30 * 60);

            // Remember me cookie using CookieUtil
            if ("on".equals(rememberMe)) {
                CookieUtil.createRememberMeCookie(response, email);
            }

            // Redirect based on role
            if ("admin".equals(user.getRole())) {
                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            } else {
                response.sendRedirect(request.getContextPath() + "/");
            }
        } else {
            FlashMessageUtil.setError(request, "Invalid email or password");
            request.setAttribute("email", email);
            request.getRequestDispatcher("/WEB-INF/views/public/login.jsp")
                    .forward(request, response);
        }
    }

    private void doRegister(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String address = request.getParameter("address");

        // Validation
        StringBuilder errors = new StringBuilder();

        if (!ValidationUtil.isValidName(fullName)) {
            errors.append("Name must be at least 2 characters. ");
        }
        if (!ValidationUtil.isValidEmail(email)) {
            errors.append("Valid email required. ");
        }
        if (!ValidationUtil.isValidPhone(phone)) {
            errors.append("Phone must be 10-15 digits. ");
        }
        if (!ValidationUtil.isValidPassword(password)) {
            errors.append("Password must be at least 6 characters. ");
        }
        if (!password.equals(confirmPassword)) {
            errors.append("Passwords do not match. ");
        }
        if (userDAO.emailExists(email)) {
            errors.append("Email already registered. ");
        }

        if (errors.length() > 0) {
            FlashMessageUtil.setError(request, errors.toString().trim());
            request.setAttribute("fullName", fullName);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.setAttribute("address", address);
            request.getRequestDispatcher("/WEB-INF/views/public/register.jsp")
                    .forward(request, response);
            return;
        }

        // Hash password
        String hashedPassword = PasswordUtil.hashPassword(password.trim());

        // Create user
        User user = new User();
        user.setFullName(fullName.trim());
        user.setEmail(email.trim().toLowerCase());
        user.setPhone(phone.trim());
        user.setPassword(hashedPassword);
        user.setAddress(address != null ? address.trim() : "");
        user.setRole("user");

        // Register user
        if (userDAO.registerUser(user)) {
            FlashMessageUtil.setSuccess(request, "Registration successful! Please login.");
            response.sendRedirect(request.getContextPath() + "/login");
        } else {
            FlashMessageUtil.setError(request, "Registration failed. Please try again.");
            request.getRequestDispatcher("/WEB-INF/views/public/register.jsp")
                    .forward(request, response);
        }
    }

    private void doLogout(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        // Invalidate session
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }

        // Clear remember me cookie using CookieUtil
        CookieUtil.clearRememberMeCookie(response);

        FlashMessageUtil.setSuccess(request, "Logged out successfully");
        response.sendRedirect(request.getContextPath() + "/");
    }
}
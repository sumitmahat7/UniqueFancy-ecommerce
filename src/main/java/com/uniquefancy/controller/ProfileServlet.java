package com.uniquefancy.controller;

import com.uniquefancy.dao.UserDAO;
import com.uniquefancy.model.User;
import com.uniquefancy.util.ValidationUtil;
import com.uniquefancy.util.FlashMessageUtil;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("loggedInUser");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        req.setAttribute("user", userDAO.getUserById(user.getUserId()));
        req.getRequestDispatcher("/WEB-INF/views/user/profile.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        User user = (User) req.getSession().getAttribute("loggedInUser");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String name = req.getParameter("fullName");
        String phone = req.getParameter("phone");
        String address = req.getParameter("address");

        if (ValidationUtil.isValidName(name) && ValidationUtil.isValidPhone(phone)) {
            user.setFullName(name);
            user.setPhone(phone);
            user.setAddress(address);
            userDAO.updateProfile(user);
            req.getSession().setAttribute("loggedInUser", user);
            FlashMessageUtil.setSuccess(req, "Profile updated successfully");
            resp.sendRedirect(req.getContextPath() + "/profile");
        } else {
            FlashMessageUtil.setError(req, "Invalid data. Please check your inputs.");
            resp.sendRedirect(req.getContextPath() + "/profile");
        }
    }
}
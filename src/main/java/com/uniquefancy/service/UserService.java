package com.uniquefancy.service;

import com.uniquefancy.dao.UserDAO;
import com.uniquefancy.model.User;
import com.uniquefancy.util.ValidationUtil;
import com.uniquefancy.util.PasswordUtil;

import java.util.List;

/**
 * Service layer for user-related business logic.
 * Sits between Controller and DAO, enforcing rules.
 */
public class UserService {

    private final UserDAO userDAO = new UserDAO();

    /**
     * Registers a new user after validating all fields.
     * @param user User object with plain-text password
     * @return null on success, error message string on failure
     */
    public String register(User user) {
        if (!ValidationUtil.isValidName(user.getFullName()))
            return "Full name must be at least 2 characters (letters only).";
        if (!ValidationUtil.isValidEmail(user.getEmail()))
            return "Please enter a valid email address.";
        if (!ValidationUtil.isValidPhone(user.getPhone()))
            return "Phone must be 10–15 digits.";
        if (!ValidationUtil.isValidPassword(user.getPassword()))
            return "Password must be at least 6 characters.";
        if (userDAO.emailExists(user.getEmail()))
            return "This email is already registered.";

        boolean created = userDAO.registerUser(user);
        return created ? null : "Registration failed. Please try again.";
    }

    /**
     * Authenticates a user.
     * @return authenticated User or null
     */
    public User login(String email, String password) {
        if (ValidationUtil.isBlank(email) || ValidationUtil.isBlank(password)) return null;
        return userDAO.loginUser(email.trim(), password);
    }

    /**
     * Updates profile (name, phone, address).
     * @return null on success, error message on failure
     */
    public String updateProfile(User user) {
        if (!ValidationUtil.isValidName(user.getFullName()))
            return "Full name must be at least 2 characters (letters only).";
        if (!ValidationUtil.isValidPhone(user.getPhone()))
            return "Phone must be 10–15 digits.";
        boolean ok = userDAO.updateProfile(user);
        return ok ? null : "Profile update failed.";
    }

    /**
     * Changes password after verifying old one.
     * @param userId      User ID
     * @param oldPassword Current password (plain text)
     * @param newPassword New password (plain text)
     * @return null on success, error message on failure
     */
    public String changePassword(int userId, String oldPassword, String newPassword) {
        if (!ValidationUtil.isValidPassword(newPassword))
            return "New password must be at least 6 characters.";
        User user = userDAO.getUserById(userId);
        if (user == null) return "User not found.";
        if (!PasswordUtil.verifyPassword(oldPassword, user.getPassword()))
            return "Current password is incorrect.";
        boolean ok = userDAO.changePassword(userId, newPassword);
        return ok ? null : "Password change failed.";
    }

    public User getUserById(int userId) {
        return userDAO.getUserById(userId);
    }

    public List<User> getAllUsers() {
        return userDAO.getAllUsers();
    }

    public int getUserCount() {
        return userDAO.getUserCount();
    }
}
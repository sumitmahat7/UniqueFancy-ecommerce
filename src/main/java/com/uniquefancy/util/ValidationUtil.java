package com.uniquefancy.util;

/**
 * Utility class providing common validation methods.
 */
public class ValidationUtil {

    /**
     * Validates email format (must contain @ and .).
     * @param email Email string to validate
     * @return true if valid
     */
    public static boolean isValidEmail(String email) {
        if (email == null || email.trim().isEmpty()) return false;
        return email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$");
    }

    /**
     * Validates phone number (10–15 digits only).
     * @param phone Phone string to validate
     * @return true if valid
     */
    public static boolean isValidPhone(String phone) {
        if (phone == null || phone.trim().isEmpty()) return false;
        return phone.matches("^\\d{10,15}$");
    }

    /**
     * Validates name (letters and spaces only, min 2 chars).
     * @param name Name string to validate
     * @return true if valid
     */
    public static boolean isValidName(String name) {
        if (name == null || name.trim().length() < 2) return false;
        return name.matches("^[A-Za-z\\s]+$");
    }

    /**
     * Validates password (minimum 6 characters).
     * @param password Password string to validate
     * @return true if valid
     */
    public static boolean isValidPassword(String password) {
        return password != null && password.length() >= 6;
    }

    /**
     * Checks if a string is null or blank.
     * @param value String to check
     * @return true if null or blank
     */
    public static boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }

    /**
     * Checks if a string is not null or blank.
     * @param value String to check
     * @return true if not blank
     */
    public static boolean isNotBlank(String value) {
        return !isBlank(value);
    }

    /**
     * Validates that a price is a positive number.
     * @param priceStr String representation of the price
     * @return true if valid positive number
     */
    public static boolean isValidPrice(String priceStr) {
        try {
            double price = Double.parseDouble(priceStr);
            return price > 0;
        } catch (NumberFormatException e) {
            return false;
        }
    }

    /**
     * Validates that a stock value is a non-negative integer.
     * @param stockStr String representation of stock
     * @return true if valid non-negative integer
     */
    public static boolean isValidStock(String stockStr) {
        try {
            int stock = Integer.parseInt(stockStr);
            return stock >= 0;
        } catch (NumberFormatException e) {
            return false;
        }
    }

    /**
     * Get error message for a field
     * @param field Field name
     * @return Error message
     */
    public static String getErrorMessage(String field) {
        switch (field) {
            case "email":
                return "Invalid email format! Example: name@domain.com";
            case "phone":
                return "Phone number must be 10-15 digits!";
            case "name":
                return "Name must be at least 2 characters (letters only)!";
            case "password":
                return "Password must be at least 6 characters!";
            case "price":
                return "Price must be greater than 0!";
            case "stock":
                return "Stock must be 0 or more!";
            default:
                return "Invalid input!";
        }
    }
}
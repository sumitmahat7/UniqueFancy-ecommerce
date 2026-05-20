package com.uniquefancy.dao;

import com.uniquefancy.model.Category;
import com.uniquefancy.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for Category operations.
 * Handles all database operations related to product categories including
 * retrieving, adding, updating, and deleting categories.
 *
 * Categories are used to organize products (Men, Women, Kids, Footwear, Accessories).
 *
 **/
public class CategoryDAO {

    /**
     * Retrieves all categories from the database.
     * Categories are ordered alphabetically by name.
     * Used in product filter dropdown and category management pages.
     *
     * @return List of all Category objects, empty list if found none
     */
    public List<Category> getAllCategories() {
        List<Category> list = new ArrayList<>();
        String sql = "SELECT * FROM categories ORDER BY category_name";
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) {
            System.err.println("CategoryDAO.getAllCategories error: " + e.getMessage());
        }
        return list;
    }

    /**
     * Retrieves a single category by its ID.
     * Used to get category details when editing or viewing a specific category.
     *
     * @param id The category ID to look up
     * @return Category object if found, null if not found
     */
    public Category getCategoryById(int id) {
        String sql = "SELECT * FROM categories WHERE category_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);
        } catch (SQLException e) {
            System.err.println("CategoryDAO.getCategoryById error: " + e.getMessage());
        }
        return null;
    }

    /**
     * Adds a new category to the database.
     * Used by admin to create new product categories.
     *
     * @param cat Category object containing category_name and description
     * @return true if category added successfully, otherwise false
     */
    public boolean addCategory(Category cat) {
        String sql = "INSERT INTO categories (category_name, description) VALUES (?,?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, cat.getCategoryName());
            ps.setString(2, cat.getDescription());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("CategoryDAO.addCategory error: " + e.getMessage());
            return false;
        }
    }

    /**
     * Updates an existing category in the database.
     * Used by admin to edit category name or description.
     *
     * @param cat Category object with updated information
     * @return true if category updated successfully,  otherwise false
     */
    public boolean updateCategory(Category cat) {
        String sql = "UPDATE categories SET category_name=?, description=? WHERE category_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, cat.getCategoryName());
            ps.setString(2, cat.getDescription());
            ps.setInt(3, cat.getCategoryId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("CategoryDAO.updateCategory error: " + e.getMessage());
            return false;
        }
    }

    /**
     * Deletes a category from the database.
     * First checks if any products are linked to this category.
     * If products exist, deletion is prevented to maintain data integrity.
     *
     * @param id The category ID to delete
     * @return true if category deleted successfully, false if products exist or error occurs
     */
    public boolean deleteCategory(int id) {
        String checkSql = "SELECT COUNT(*) FROM products WHERE category_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(checkSql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) return false; // has linked products
        } catch (SQLException e) {
            System.err.println("CategoryDAO.deleteCategory check error: " + e.getMessage());
            return false;
        }
        String delSql = "DELETE FROM categories WHERE category_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(delSql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("CategoryDAO.deleteCategory error: " + e.getMessage());
            return false;
        }
    }



    /**
     * Maps a ResultSet row to a Category object.
     * Internal helper method used by multiple query methods.
     *
     * @param rs ResultSet positioned at a row from the categories table
     * @return Category object populated with data from the ResultSet
     * @throws SQLException if database access error occurs
     */
    private Category mapRow(ResultSet rs) throws SQLException {
        Category category = new Category();
        category.setCategoryId(rs.getInt("category_id"));
        category.setCategoryName(rs.getString("category_name"));
        category.setDescription(rs.getString("description"));
        return category;
    }
}
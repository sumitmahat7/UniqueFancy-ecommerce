package com.uniquefancy.dao;

import com.uniquefancy.model.Product;
import com.uniquefancy.model.ProductSize;
import com.uniquefancy.util.DBConnection;


import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    // GET PRODUCTS

    public List<Product> getAllProducts() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT p.*, c.category_name FROM products p " +
                "LEFT JOIN categories c ON p.category_id = c.category_id " +
                "ORDER BY p.created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Product getProductById(int productId) {
        String sql = "SELECT p.*, c.category_name FROM products p " +
                "LEFT JOIN categories c ON p.category_id = c.category_id " +
                "WHERE p.product_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Product p = mapRow(rs);
                p.setSizes(getSizesByProductId(productId));
                return p;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Product> getProductsByCategory(int categoryId) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT p.*, c.category_name FROM products p " +
                "LEFT JOIN categories c ON p.category_id = c.category_id " +
                "WHERE p.category_id = ? ORDER BY p.created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, categoryId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Product> searchProducts(String keyword) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT p.*, c.category_name FROM products p " +
                "LEFT JOIN categories c ON p.category_id = c.category_id " +
                "WHERE p.product_name LIKE ? OR p.description LIKE ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            String pattern = "%" + keyword + "%";
            ps.setString(1, pattern);
            ps.setString(2, pattern);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Product> getFeaturedProducts() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT p.*, c.category_name FROM products p " +
                "LEFT JOIN categories c ON p.category_id = c.category_id " +
                "ORDER BY p.created_at DESC LIMIT 6";
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Product> getLowStockProducts() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT p.*, c.category_name FROM products p " +
                "LEFT JOIN categories c ON p.category_id = c.category_id " +
                "WHERE p.stock < 10 ORDER BY p.stock ASC";
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Product> getTopSellingProducts() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT p.product_id, p.product_name, p.price, p.image, p.stock, " +
                "SUM(oi.quantity) as total_sold " +
                "FROM order_items oi " +
                "JOIN products p ON oi.product_id = p.product_id " +
                "GROUP BY p.product_id ORDER BY total_sold DESC LIMIT 5";
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                Product p = new Product();
                p.setProductId(rs.getInt("product_id"));
                p.setProductName(rs.getString("product_name"));
                p.setPrice(rs.getBigDecimal("price"));
                p.setImage(rs.getString("image"));
                p.setStock(rs.getInt("stock"));
                list.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getProductCount() {
        String sql = "SELECT COUNT(*) FROM products";
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // ============ PRODUCT CRUD ============

    public int addProduct(Product product) {
        String sql = "INSERT INTO products (product_name, description, price, stock, image, category_id) " +
                "VALUES (?,?,?,?,?,?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, product.getProductName());
            ps.setString(2, product.getDescription());
            ps.setBigDecimal(3, product.getPrice());
            ps.setInt(4, product.getStock());
            ps.setString(5, product.getImage());
            ps.setInt(6, product.getCategoryId());
            ps.executeUpdate();
            ResultSet keys = ps.getGeneratedKeys();
            if (keys.next()) return keys.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    public boolean updateProduct(Product product) {
        String sql = "UPDATE products SET product_name=?, description=?, price=?, stock=?, image=?, category_id=? " +
                "WHERE product_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, product.getProductName());
            ps.setString(2, product.getDescription());
            ps.setBigDecimal(3, product.getPrice());
            ps.setInt(4, product.getStock());
            ps.setString(5, product.getImage());
            ps.setInt(6, product.getCategoryId());
            ps.setInt(7, product.getProductId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteProduct(int productId) {
        String sql = "DELETE FROM products WHERE product_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ============ SIZE METHODS ============

    public List<ProductSize> getSizesByProductId(int productId) {
        List<ProductSize> sizes = new ArrayList<>();
        String sql = "SELECT * FROM product_sizes WHERE product_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ProductSize sz = new ProductSize();
                sz.setSizeId(rs.getInt("size_id"));
                sz.setProductId(rs.getInt("product_id"));
                sz.setSizeName(rs.getString("size_name"));
                sz.setSizeStock(rs.getInt("size_stock"));
                sizes.add(sz);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return sizes;
    }

    public void saveSizes(int productId, List<ProductSize> sizes) {
        String deleteSql = "DELETE FROM product_sizes WHERE product_id = ?";
        String insertSql = "INSERT INTO product_sizes (product_id, size_name, size_stock) VALUES (?,?,?)";
        try (Connection conn = DBConnection.getConnection()) {
            try (PreparedStatement del = conn.prepareStatement(deleteSql)) {
                del.setInt(1, productId);
                del.executeUpdate();
            }
            try (PreparedStatement ins = conn.prepareStatement(insertSql)) {
                for (ProductSize sz : sizes) {
                    ins.setInt(1, productId);
                    ins.setString(2, sz.getSizeName());
                    ins.setInt(3, sz.getSizeStock());
                    ins.addBatch();
                }
                ins.executeBatch();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // ============ STOCK MANAGEMENT ============

    public boolean updateStock(int productId, String size, int quantity) {
        String updateSizeSql = "UPDATE product_sizes SET size_stock = size_stock - ? WHERE product_id = ? AND size_name = ? AND size_stock >= ?";
        String updateProductSql = "UPDATE products SET stock = stock - ? WHERE product_id = ? AND stock >= ?";

        try (Connection conn = DBConnection.getConnection()) {
            try (PreparedStatement ps = conn.prepareStatement(updateSizeSql)) {
                ps.setInt(1, quantity);
                ps.setInt(2, productId);
                ps.setString(3, size);
                ps.setInt(4, quantity);
                ps.executeUpdate();
            }
            try (PreparedStatement ps = conn.prepareStatement(updateProductSql)) {
                ps.setInt(1, quantity);
                ps.setInt(2, productId);
                ps.setInt(3, quantity);
                return ps.executeUpdate() > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean reduceStock(int productId, String size, int quantity) {
        return updateStock(productId, size, quantity);
    }

    // ============ HELPER ============

    private Product mapRow(ResultSet rs) throws SQLException {
        Product p = new Product();
        p.setProductId(rs.getInt("product_id"));
        p.setProductName(rs.getString("product_name"));
        p.setDescription(rs.getString("description"));
        p.setPrice(rs.getBigDecimal("price"));
        p.setStock(rs.getInt("stock"));
        p.setImage(rs.getString("image"));
        p.setCategoryId(rs.getInt("category_id"));
        p.setCreatedAt(rs.getTimestamp("created_at"));
        try {
            p.setCategoryName(rs.getString("category_name"));
        } catch (SQLException ignored) {}
        return p;
    }

    // ============ PAGINATION METHODS ============

    public int getTotalProductCount() {
        String sql = "SELECT COUNT(*) FROM products";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Product> getProductsByPage(int offset, int limit) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT p.*, c.category_name FROM products p " +
                "LEFT JOIN categories c ON p.category_id = c.category_id " +
                "LIMIT ? OFFSET ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, limit);
            ps.setInt(2, offset);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product product = new Product();
                product.setProductId(rs.getInt("product_id"));
                product.setProductName(rs.getString("product_name"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getBigDecimal("price"));
                product.setStock(rs.getInt("stock"));
                product.setImage(rs.getString("image"));
                product.setCategoryId(rs.getInt("category_id"));
                product.setCategoryName(rs.getString("category_name"));
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public int getSearchCount(String search) {
        String sql = "SELECT COUNT(*) FROM products WHERE product_name LIKE ? OR description LIKE ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + search + "%");
            ps.setString(2, "%" + search + "%");
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Product> searchProducts(String search, int offset, int limit) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT p.*, c.category_name FROM products p " +
                "LEFT JOIN categories c ON p.category_id = c.category_id " +
                "WHERE p.product_name LIKE ? OR p.description LIKE ? " +
                "LIMIT ? OFFSET ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + search + "%");
            ps.setString(2, "%" + search + "%");
            ps.setInt(3, limit);
            ps.setInt(4, offset);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product product = new Product();
                product.setProductId(rs.getInt("product_id"));
                product.setProductName(rs.getString("product_name"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getBigDecimal("price"));
                product.setStock(rs.getInt("stock"));
                product.setImage(rs.getString("image"));
                product.setCategoryId(rs.getInt("category_id"));
                product.setCategoryName(rs.getString("category_name"));
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public int getCategoryCount(int categoryId) {
        String sql = "SELECT COUNT(*) FROM products WHERE category_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, categoryId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Product> getProductsByCategory(int categoryId, int offset, int limit) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT p.*, c.category_name FROM products p " +
                "LEFT JOIN categories c ON p.category_id = c.category_id " +
                "WHERE p.category_id = ? LIMIT ? OFFSET ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, categoryId);
            ps.setInt(2, limit);
            ps.setInt(3, offset);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product product = new Product();
                product.setProductId(rs.getInt("product_id"));
                product.setProductName(rs.getString("product_name"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getBigDecimal("price"));
                product.setStock(rs.getInt("stock"));
                product.setImage(rs.getString("image"));
                product.setCategoryId(rs.getInt("category_id"));
                product.setCategoryName(rs.getString("category_name"));
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }
}
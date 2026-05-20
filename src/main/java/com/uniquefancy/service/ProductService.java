package com.uniquefancy.service;

import com.uniquefancy.dao.ProductDAO;
import com.uniquefancy.model.Product;
import com.uniquefancy.model.ProductSize;

import java.util.List;

/**
 * Service layer for product-related business logic.
 */
public class ProductService {

    private final ProductDAO productDAO = new ProductDAO();

    public List<Product> getAllProducts()                    { return productDAO.getAllProducts(); }
    public List<Product> getProductsByCategory(int catId)   { return productDAO.getProductsByCategory(catId); }
    public List<Product> searchProducts(String keyword)     { return productDAO.searchProducts(keyword); }
    public Product       getProductById(int productId)      { return productDAO.getProductById(productId); }
    public List<Product> getFeaturedProducts()              { return productDAO.getFeaturedProducts(); }
    public List<Product> getLowStockProducts()              { return productDAO.getLowStockProducts(); }
    public List<Product> getTopSellingProducts()            { return productDAO.getTopSellingProducts(); }

    /**
     * Get product count for dashboard
     */
    public int getProductCount() { return productDAO.getProductCount(); }

    /**
     * Adds a product along with its size stocks.
     * @return generated product ID, or -1 on failure
     */
    public int addProduct(Product product, List<ProductSize> sizes) {
        int id = productDAO.addProduct(product);
        if (id > 0 && sizes != null && !sizes.isEmpty()) {
            productDAO.saveSizes(id, sizes);
        }
        return id;
    }

    /**
     * Updates a product and refreshes its sizes.
     * @return true if successful
     */
    public boolean updateProduct(Product product, List<ProductSize> sizes) {
        boolean ok = productDAO.updateProduct(product);
        if (ok && sizes != null) {
            productDAO.saveSizes(product.getProductId(), sizes);
        }
        return ok;
    }

    public boolean deleteProduct(int productId) { return productDAO.deleteProduct(productId); }

    /**
     * Update stock after purchase
     */
    public boolean updateStock(int productId, String size, int quantity) {
        return productDAO.updateStock(productId, size, quantity);
    }

    /**
     * Reduce stock (alias)
     */
    public boolean reduceStock(int productId, String size, int quantity) {
        return productDAO.reduceStock(productId, size, quantity);
    }

    /**
     * Checks if enough stock exists for a given product + size combination.
     */
    public boolean hasSufficientStock(int productId, String size, int quantity) {
        Product product = productDAO.getProductById(productId);
        if (product == null || product.getStock() < quantity) return false;
        if (product.getSizes() != null) {
            return product.getSizes().stream()
                    .filter(s -> s.getSizeName().equals(size))
                    .anyMatch(s -> s.getSizeStock() >= quantity);
        }
        return true;
    }
}
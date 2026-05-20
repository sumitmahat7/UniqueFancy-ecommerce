DROP DATABASE IF EXISTS uniquefancy_db;
CREATE DATABASE uniquefancy_db;
USE uniquefancy_db;

-- ============================================
-- TABLE 1: users
-- ============================================
CREATE TABLE users (
                       user_id INT PRIMARY KEY AUTO_INCREMENT,
                       full_name VARCHAR(100) NOT NULL,
                       email VARCHAR(100) UNIQUE NOT NULL,
                       phone VARCHAR(15) NOT NULL,
                       password VARCHAR(255) NOT NULL,
                       role VARCHAR(10) DEFAULT 'user',
                       address TEXT,
                       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                       updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- ============================================
-- TABLE 2: categories
-- ============================================
CREATE TABLE categories (
                            category_id INT PRIMARY KEY AUTO_INCREMENT,
                            category_name VARCHAR(50) UNIQUE NOT NULL,
                            description TEXT,
                            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                            updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- ============================================
-- TABLE 3: products
-- ============================================
CREATE TABLE products (
                          product_id INT PRIMARY KEY AUTO_INCREMENT,
                          product_name VARCHAR(100) NOT NULL,
                          description TEXT,
                          price DECIMAL(10,2) NOT NULL,
                          stock INT DEFAULT 0,
                          image VARCHAR(255),
                          category_id INT,
                          created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                          updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                          FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- ============================================
-- TABLE 4: product_sizes
-- ============================================
CREATE TABLE product_sizes (
                               size_id INT PRIMARY KEY AUTO_INCREMENT,
                               product_id INT NOT NULL,
                               size_name VARCHAR(10) NOT NULL,
                               size_stock INT DEFAULT 0,
                               created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                               updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                               FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
);

-- ============================================
-- TABLE 5: orders
-- ============================================
CREATE TABLE orders (
                        order_id INT PRIMARY KEY AUTO_INCREMENT,
                        user_id INT NOT NULL,
                        order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                        total_amount DECIMAL(10,2) NOT NULL,
                        status VARCHAR(20) DEFAULT 'pending',
                        payment_method VARCHAR(50),
                        shipping_address TEXT,
                        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                        FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- ============================================
-- TABLE 6: order_items
-- ============================================
CREATE TABLE order_items (
                             order_item_id INT PRIMARY KEY AUTO_INCREMENT,
                             order_id INT NOT NULL,
                             product_id INT NOT NULL,
                             quantity INT NOT NULL,
                             price DECIMAL(10,2) NOT NULL,
                             size VARCHAR(10),
                             created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                             updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                             FOREIGN KEY (order_id) REFERENCES orders(order_id),
                             FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- ============================================
-- INSERT CATEGORIES
-- ============================================
INSERT INTO categories (category_name, description) VALUES
                                                        ('Men', 'Stylish clothing for men'),
                                                        ('Women', 'Elegant dresses for women'),
                                                        ('Kids', 'Clothing for children'),
                                                        ('Footwear', 'Bags, belts, watches'),
                                                        ('Accessories', 'Shoes and sandals');

-- ============================================
-- INSERT PRODUCTS (40 products)
-- ============================================

-- Men Products (1-8)
INSERT INTO products (product_name, description, price, stock, category_id) VALUES
                                                                                ('Men Cotton Casual Shirt', '100% cotton breathable shirt', 1299, 50, 1),
                                                                                ('Men Slim Fit Jeans', 'Classic blue denim jeans', 2499, 40, 1),
                                                                                ('Men Winter Puffer Jacket', 'Warm padded jacket with hood', 4599, 25, 1),
                                                                                ('Men Polo T-Shirt', 'Breathable polo neck t-shirt', 999, 60, 1),
                                                                                ('Men Formal Trousers', 'Office wear trousers', 1999, 35, 1),
                                                                                ('Men Hooded Sweatshirt', 'Warm fleece hoodie', 2999, 30, 1),
                                                                                ('Men Cotton Shorts', 'Summer cotton shorts', 899, 45, 1),
                                                                                ('Men Blazer Coat', 'Formal blazer for special occasions', 4999, 20, 1);

-- Women Products (9-16)
INSERT INTO products (product_name, description, price, stock, category_id) VALUES
                                                                                ('Women Floral Maxi Dress', 'Beautiful floral print summer dress', 3499, 35, 2),
                                                                                ('Women Cotton Crop Top', 'Breathable cotton cropped top', 999, 60, 2),
                                                                                ('Women Skinny Fit Jeans', 'Stylish stretchable skinny jeans', 2599, 45, 2),
                                                                                ('Women Office Blazer', 'Elegant blazer for professional look', 4299, 30, 2),
                                                                                ('Women Pleated Skirt', 'Pleated midi skirt for elegant look', 1899, 40, 2),
                                                                                ('Women Silk Blouse', 'Elegant silk material blouse', 2299, 35, 2),
                                                                                ('Women Knit Cardigan', 'Soft knit cardigan for layering', 2799, 30, 2),
                                                                                ('Women Summer Jumpsuit', 'One-piece summer jumpsuit', 3199, 25, 2);

-- Kids Products (17-24)
INSERT INTO products (product_name, description, price, stock, category_id) VALUES
                                                                                ('Kids Cartoon T-Shirt', 'Colorful cartoon printed t-shirt', 699, 80, 3),
                                                                                ('Kids Comfortable Jeans', 'Soft denim jeans for kids', 1199, 50, 3),
                                                                                ('Kids Party Dress', 'Pretty party dress for girls', 1599, 40, 3),
                                                                                ('Kids Winter Hoodie', 'Warm hoodie for cold weather', 1399, 40, 3),
                                                                                ('Kids Cotton Pajamas', 'Comfortable cotton sleepwear', 999, 45, 3),
                                                                                ('Kids Sports Shoes', 'Comfortable sneakers for kids', 1799, 35, 3),
                                                                                ('Kids Winter Jacket', 'Warm padded jacket for winter', 1999, 30, 3),
                                                                                ('Kids Baseball Cap', 'Cotton cap with adjustable strap', 599, 60, 3);

-- Footwear Products (25-32)
INSERT INTO products (product_name, description, price, stock, category_id) VALUES
                                                                                ('Men Running Shoes', 'Lightweight sports shoes for running', 3599, 45, 4),
                                                                                ('Casual Sneakers', 'Everyday wear comfortable sneakers', 2899, 50, 4),
                                                                                ('Men Formal Shoes', 'Leather office formal shoes', 3999, 30, 4),
                                                                                ('Women Heel Sandals', 'Elegant heel sandals for parties', 2199, 40, 4),
                                                                                ('Women Flats', 'Comfortable flat shoes for daily wear', 1599, 55, 4),
                                                                                ('Sports Shoes', 'Professional running shoes for men', 3899, 30, 4),
                                                                                ('Kids Sandals', 'Adjustable strap sandals for kids', 899, 60, 4),
                                                                                ('Flip Flops', 'Beach and home flip flops', 499, 100, 4);

-- Accessories Products (33-40)
INSERT INTO products (product_name, description, price, stock, category_id) VALUES
                                                                                ('Genuine Leather Belt', 'Premium quality leather belt', 1299, 100, 5),
                                                                                ('Analog Wrist Watch', 'Stylish analog watch for men', 3499, 40, 5),
                                                                                ('UV Protection Sunglasses', 'Premium quality sunglasses', 1899, 60, 5),
                                                                                ('Waterproof Backpack', 'School and travel backpack', 2499, 40, 5),
                                                                                ('Wool Winter Scarf', 'Soft warm scarf for winter', 999, 60, 5),
                                                                                ('Cotton Baseball Cap', 'Adjustable cap with embroidery', 799, 70, 5),
                                                                                ('Cotton Socks Pack', 'Pack of 5 cotton socks', 499, 100, 5),
                                                                                ('Formal Neck Tie', 'Elegant silk neck tie', 999, 45, 5);

-- ============================================
-- INSERT PRODUCT SIZES
-- ============================================

-- Men Products Sizes (1-8)
INSERT INTO product_sizes (product_id, size_name, size_stock) VALUES
                                                                  (1, 'S', 10), (1, 'M', 15), (1, 'L', 15), (1, 'XL', 10),
                                                                  (2, '28', 8), (2, '30', 12), (2, '32', 12), (2, '34', 8),
                                                                  (3, 'S', 5), (3, 'M', 8), (3, 'L', 7), (3, 'XL', 5),
                                                                  (4, 'S', 15), (4, 'M', 20), (4, 'L', 15), (4, 'XL', 10),
                                                                  (5, '28', 8), (5, '30', 12), (5, '32', 10), (5, '34', 5),
                                                                  (6, 'S', 8), (6, 'M', 12), (6, 'L', 8), (6, 'XL', 5),
                                                                  (7, 'S', 12), (7, 'M', 15), (7, 'L', 10), (7, 'XL', 8),
                                                                  (8, 'S', 5), (8, 'M', 8), (8, 'L', 5), (8, 'XL', 2);

-- Women Products Sizes (9-16)
INSERT INTO product_sizes (product_id, size_name, size_stock) VALUES
                                                                  (9, 'XS', 8), (9, 'S', 12), (9, 'M', 10), (9, 'L', 5),
                                                                  (10, 'XS', 15), (10, 'S', 20), (10, 'M', 15), (10, 'L', 10),
                                                                  (11, '26', 8), (11, '28', 12), (11, '30', 10), (11, '32', 5),
                                                                  (12, 'XS', 5), (12, 'S', 8), (12, 'M', 10), (12, 'L', 7),
                                                                  (13, 'XS', 10), (13, 'S', 15), (13, 'M', 10), (13, 'L', 5),
                                                                  (14, 'XS', 8), (14, 'S', 12), (14, 'M', 10), (14, 'L', 5),
                                                                  (15, 'XS', 8), (15, 'S', 12), (15, 'M', 10), (15, 'L', 5),
                                                                  (16, 'XS', 5), (16, 'S', 8), (16, 'M', 7), (16, 'L', 5);

-- Kids Products Sizes (17-24)
INSERT INTO product_sizes (product_id, size_name, size_stock) VALUES
                                                                  (17, '2-3Y', 20), (17, '4-5Y', 25), (17, '6-7Y', 20), (17, '8-9Y', 15),
                                                                  (18, '2-3Y', 12), (18, '4-5Y', 15), (18, '6-7Y', 12), (18, '8-9Y', 10),
                                                                  (19, '2-3Y', 10), (19, '4-5Y', 12), (19, '6-7Y', 10), (19, '8-9Y', 8),
                                                                  (20, '2-3Y', 12), (20, '4-5Y', 15), (20, '6-7Y', 8), (20, '8-9Y', 5),
                                                                  (21, '2-3Y', 15), (21, '4-5Y', 15), (21, '6-7Y', 10), (21, '8-9Y', 5),
                                                                  (22, '9-12', 10), (22, '13-1', 12), (22, '2-3', 8), (22, '4-5', 5),
                                                                  (23, '2-3Y', 8), (23, '4-5Y', 10), (23, '6-7Y', 7), (23, '8-9Y', 5),
                                                                  (24, 'One Size', 60);

-- Footwear Products Sizes (25-32)
INSERT INTO product_sizes (product_id, size_name, size_stock) VALUES
                                                                  (25, '6', 10), (25, '7', 15), (25, '8', 12), (25, '9', 8), (25, '10', 5),
                                                                  (26, '6', 12), (26, '7', 15), (26, '8', 12), (26, '9', 8), (26, '10', 5),
                                                                  (27, '6', 8), (27, '7', 10), (27, '8', 8), (27, '9', 4),
                                                                  (28, '5', 10), (28, '6', 15), (28, '7', 12), (28, '8', 8),
                                                                  (29, '5', 12), (29, '6', 15), (29, '7', 12), (29, '8', 10),
                                                                  (30, '6', 8), (30, '7', 10), (30, '8', 7), (30, '9', 5),
                                                                  (31, '9-12', 15), (31, '13-1', 15), (31, '2-3', 10),
                                                                  (32, 'One Size', 100);

-- Accessories Products Sizes (33-40)
INSERT INTO product_sizes (product_id, size_name, size_stock) VALUES
                                                                  (33, 'M', 30), (33, 'L', 40), (33, 'XL', 30),
                                                                  (34, 'One Size', 40),
                                                                  (35, 'One Size', 60),
                                                                  (36, 'One Size', 40),
                                                                  (37, 'One Size', 60),
                                                                  (38, 'One Size', 70),
                                                                  (39, 'One Size', 100),
                                                                  (40, 'One Size', 45);

-- ============================================
-- INSERT USERS
-- ============================================
INSERT INTO users (full_name, email, phone, password, role, address) VALUES
                                                                         ('Admin User', 'admin@uniquefancy.com', '9800000000', '$2a$10$gqTPyFiwkQQSzgtCL9ZzG.PcAfGIHsI/.vMfgAuVj.OwhKY.SVF3u', 'admin', 'Pokhara'),
                                                                         ('gobin Chhantyal', 'gc@gmail.com', '9800000001', '$2a$10$sMi5jF2fA8KiqOBLaXjcMe424brSKQHRI4ixwgD6pWVnlc5DtXf62', 'user', 'Pokhara'),
                                                                         ('Sid Malla', 'sid@gmail.com', '9090909090', '$2a$10$w9mfQnicwNNZ22j95lwuBeKDJYLsEI2t8oe650taAJfVM6uHdyyCa', 'user', 'Damside');

-- ============================================
-- INSERT ORDERS
-- ============================================
INSERT INTO orders (user_id, total_amount, status, payment_method, shipping_address) VALUES
                                                                                         (2, 3798.00, 'delivered', 'Cash on Delivery', 'Kathmandu, Nepal'),
                                                                                         (2, 5197.00, 'processing', 'eSewa', 'Kathmandu, Nepal');

-- ============================================
-- INSERT ORDER ITEMS
-- ============================================
INSERT INTO order_items (order_id, product_id, quantity, price, size) VALUES
                                                                          (1, 1, 2, 1299.00, 'M'),
                                                                          (1, 4, 1, 999.00, 'L'),
                                                                          (2, 9, 1, 3499.00, 'S'),
                                                                          (2, 33, 1, 1299.00, 'M');
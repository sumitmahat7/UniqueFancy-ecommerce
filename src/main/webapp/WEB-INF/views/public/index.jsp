<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Unique Fancy - Sustainable Fashion Store</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/responsive.css">
    <style>
        /* Hero Section */
        .hero {
            min-height: 600px;
            display: flex;
            align-items: center;
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 50%, #0f3460 100%);
            position: relative;
            overflow: hidden;
        }

        .hero::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('${pageContext.request.contextPath}/images/pattern.png') repeat;
            opacity: 0.05;
        }

        .hero-content {
            position: relative;
            z-index: 2;
            max-width: 600px;
        }

        .hero-badge {
            display: inline-block;
            background: rgba(232,197,71,0.15);
            color: #e8c547;
            padding: 6px 16px;
            border-radius: 30px;
            font-size: 0.8rem;
            font-weight: 600;
            letter-spacing: 2px;
            margin-bottom: 24px;
        }

        .hero h1 {
            font-size: 3.8rem;
            margin-bottom: 20px;
            color: white;
            line-height: 1.2;
        }

        .hero h1 span {
            color: #e8c547;
        }

        .hero p {
            font-size: 1.1rem;
            color: rgba(255,255,255,0.8);
            margin-bottom: 32px;
            line-height: 1.7;
        }

        .hero-stats {
            display: flex;
            gap: 30px;
            margin-top: 40px;
        }

        .hero-stat {
            text-align: left;
        }

        .hero-stat .number {
            font-size: 2rem;
            font-weight: 700;
            color: #e8c547;
            display: block;
        }

        .hero-stat .label {
            font-size: 0.85rem;
            color: rgba(255,255,255,0.6);
        }

        /* Section Headers */
        .section-header {
            text-align: center;
            margin-bottom: 50px;
        }

        .section-header h2 {
            font-size: 2.2rem;
            margin-bottom: 12px;
        }

        .section-header p {
            color: #666;
            max-width: 600px;
            margin: 0 auto;
        }

        /* Category Cards - Modern */
        .categories-modern {
            display: grid;
            grid-template-columns: repeat(5, 1fr);
            gap: 20px;
        }

        .category-card-modern {
            background: white;
            border-radius: 16px;
            padding: 30px 20px;
            text-align: center;
            text-decoration: none;
            transition: all 0.3s;
            box-shadow: 0 2px 15px rgba(0,0,0,0.05);
        }

        .category-card-modern:hover {
            transform: translateY(-8px);
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
        }

        .category-icon-modern {
            width: 70px;
            height: 70px;
            background: linear-gradient(135deg, #1a1a2e, #16213e);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 15px;
            font-size: 1.8rem;
            font-weight: bold;
            color: #e8c547;
        }

        /* Product Cards - Modern */
        .products-grid-modern {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 25px;
        }

        .product-card-modern {
            background: white;
            border-radius: 16px;
            overflow: hidden;
            transition: all 0.3s;
            box-shadow: 0 2px 15px rgba(0,0,0,0.05);
        }

        .product-card-modern:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
        }

        .product-image-modern {
            height: 260px;
            background: #f5f5f5;
            overflow: hidden;
        }

        .product-image-modern img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s;
        }

        .product-card-modern:hover .product-image-modern img {
            transform: scale(1.05);
        }

        .product-info-modern {
            padding: 20px;
        }

        .product-category-modern {
            font-size: 0.7rem;
            color: #e8c547;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 6px;
        }

        .product-name-modern {
            font-size: 1rem;
            font-weight: 600;
            margin-bottom: 8px;
            color: #1a1a2e;
        }

        .product-price-modern {
            font-size: 1.2rem;
            font-weight: 700;
            color: #c0392b;
            margin-bottom: 15px;
        }

        /* Banner */
        .sale-banner {
            background: linear-gradient(135deg, #c0392b 0%, #e74c3c 100%);
            border-radius: 20px;
            padding: 60px 40px;
            text-align: center;
            color: white;
        }

        .sale-banner h3 {
            font-size: 2rem;
            margin-bottom: 15px;
        }

        .sale-banner .code {
            background: rgba(255,255,255,0.2);
            display: inline-block;
            padding: 8px 20px;
            border-radius: 50px;
            font-family: monospace;
            margin-top: 20px;
        }

        @media (max-width: 1024px) {
            .categories-modern {
                grid-template-columns: repeat(3, 1fr);
            }
            .products-grid-modern {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 768px) {
            .hero h1 {
                font-size: 2.5rem;
            }
            .hero-stats {
                flex-wrap: wrap;
            }
            .categories-modern {
                grid-template-columns: repeat(2, 1fr);
            }
            .products-grid-modern {
                grid-template-columns: 1fr;
            }
            .hero-content {
                text-align: center;
            }
            .hero-stat {
                text-align: center;
            }
        }
    </style>
</head>
<body>
<%@ include file="../../../includes/header.jsp" %>
<%@ include file="../../../includes/flash-message.jsp" %>




<!-- Hero Section -->
<section class="hero">
    <div class="container">
        <div class="hero-wrapper">
            <div class="hero-content">
                <span class="hero-badge">SUSTAINABLE FASHION 2026</span>
                <h1>Fashion That Feels <span>Good</span> Inside Out</h1>
                <p>Ethically sourced clothing in sizes from XXS to 5XL. Because every body deserves beautiful, sustainable fashion.</p>
                <div class="hero-buttons-group">
                    <a href="${pageContext.request.contextPath}/products" class="btn-hero-primary">Shop Collection</a>
                    <a href="${pageContext.request.contextPath}/about.jsp" class="btn-hero-secondary">Our Story</a>
                </div>
                <div class="hero-stats">
                    <div class="hero-stat">
                        <span class="number">100%</span>
                        <span class="label">Sustainable</span>
                    </div>
                    <div class="hero-stat">
                        <span class="number">XXS-5XL</span>
                        <span class="label">Inclusive Sizing</span>
                    </div>
                    <div class="hero-stat">
                        <span class="number">200+</span>
                        <span class="label">Artisan Partners</span>
                    </div>
                </div>
            </div>
            <div class="hero-image-right">
                <img src="${pageContext.request.contextPath}/images/hero-bg.png"
                     alt="Fashion Model"
                     onerror="this.src='${pageContext.request.contextPath}/images/placeholder.jpg'">
            </div>
        </div>
    </div>
</section>

<!-- Features Section -->
<section class="features-section">
    <div class="container">
        <div class="features-grid-enhanced">
            <div class="feature-card-enhanced">
                <div class="feature-icon-enhanced">S</div>
                <h4>Sustainable Materials</h4>
                <p>Organic cotton and recycled fabrics</p>
                <div class="feature-line"></div>
            </div>
            <div class="feature-card-enhanced">
                <div class="feature-icon-enhanced">S</div>
                <h4>Size Inclusive</h4>
                <p>available XXS to 5XL </p>
                <div class="feature-line"></div>
            </div>
            <div class="feature-card-enhanced">
                <div class="feature-icon-enhanced">F</div>
                <h4>Fair Trade</h4>
                <p>Ethically sourced products</p>
                <div class="feature-line"></div>
            </div>
            <div class="feature-card-enhanced">
                <div class="feature-icon-enhanced">D</div>
                <h4>Free Delivery</h4>
                <p>On orders over Rs.5000</p>
                <div class="feature-line"></div>
            </div>
        </div>
    </div>
</section>

<!-- Categories -->
<section style="padding: 80px 0;">
    <div class="container">
        <div class="section-header">
            <h2>Shop by Category</h2>
            <p>Find exactly what you're looking for</p>
        </div>
        <div class="categories-modern">
            <a href="${pageContext.request.contextPath}/products?category=1" class="category-card-modern">
                <div class="category-icon-modern">M</div>
                <h4>Men</h4>
            </a>
            <a href="${pageContext.request.contextPath}/products?category=2" class="category-card-modern">
                <div class="category-icon-modern">W</div>
                <h4>Women</h4>
            </a>
            <a href="${pageContext.request.contextPath}/products?category=3" class="category-card-modern">
                <div class="category-icon-modern">K</div>
                <h4>Kids</h4>
            </a>
            <a href="${pageContext.request.contextPath}/products?category=5" class="category-card-modern">
                <div class="category-icon-modern">A</div>
                <h4>Accessories</h4>
            </a>
            <a href="${pageContext.request.contextPath}/products?category=4" class="category-card-modern">
                <div class="category-icon-modern">F</div>
                <h4>Footwear</h4>
            </a>
        </div>
    </div>
</section>

<!-- Featured Products -->
<section class="featured-section">
    <div class="container">
        <div class="section-header">
            <h2>Featured Collection</h2>
            <p>Our most loved pieces, just for you</p>
        </div>
        <div class="products-grid-enhanced">
            <c:forEach var="product" items="${featuredProducts}" end="7">
                <div class="product-card-enhanced">
                    <div class="product-image-enhanced">
                        <c:set var="category" value="${fn:toLowerCase(product.categoryName)}" />
                        <c:set var="imageNum" value="${(product.productId - 1) % 6 + 1}" />
                        <img src="${pageContext.request.contextPath}/images/products/${category}${imageNum}.jpg"
                             alt="${product.productName}"
                             onerror="this.src='${pageContext.request.contextPath}/images/placeholder.jpg'">
                    </div>
                    <div class="product-info-enhanced">
                        <div class="product-category-enhanced">${product.categoryName}</div>
                        <div class="product-name-enhanced">${product.productName}</div>
                        <div class="product-price-enhanced">Rs. <fmt:formatNumber value="${product.price}" pattern="#,##0.00"/></div>
                        <a href="${pageContext.request.contextPath}/product-details?id=${product.productId}" class="btn-view-details">View Details →</a>
                    </div>
                </div>
            </c:forEach>
        </div>
        <div class="view-all-container">
            <a href="${pageContext.request.contextPath}/products" class="btn-view-all">View All Products</a>
        </div>
    </div>
</section>

<!-- Sale Banner -->
<section class="sale-banner-section">
    <div class="container">
        <div class="sale-banner-enhanced">
            <div class="sale-content">
                <span class="sale-tag">LIMITED TIME OFFER</span>
                <h3>Winter Sale - 25% Off</h3>
                <p>Get 25% discount on all winter collection. Limited time offer.</p>
                <a href="${pageContext.request.contextPath}/products" class="btn-shop-now">Shop Now </a>
                <div class="sale-code">Use Code: <span>WINTER25</span></div>
            </div>
        </div>
    </div>
</section>

<!-- Values -->
<section style="padding: 0 0 80px 0; background: #f9f5f0;">
    <div class="container">
        <div class="section-header">
            <h2>Why Choose Us?</h2>
            <p>We're committed to making fashion better for everyone</p>
        </div>
        <div style="display: grid; grid-template-columns: repeat(4, 1fr); gap: 25px;">
            <div style="text-align: center; padding: 30px; background: white; border-radius: 16px;">
                <div style="font-size: 2rem; color: #e8c547; margin-bottom: 15px;">E</div>
                <h4>Eco-Friendly</h4>
                <p style="color: #666;">Organic cotton, recycled polyester</p>
            </div>
            <div style="text-align: center; padding: 30px; background: white; border-radius: 16px;">
                <div style="font-size: 2rem; color: #e8c547; margin-bottom: 15px;">I</div>
                <h4>Inclusive</h4>
                <p style="color: #666;">available sizes from XXS to 5XL </p>
            </div>
            <div style="text-align: center; padding: 30px; background: white; border-radius: 16px;">
                <div style="font-size: 2rem; color: #e8c547; margin-bottom: 15px;">E</div>
                <h4>Ethical</h4>
                <p style="color: #666;">Fair Trade certified</p>
            </div>
            <div style="text-align: center; padding: 30px; background: white; border-radius: 16px;">
                <div style="font-size: 2rem; color: #e8c547; margin-bottom: 15px;">F</div>
                <h4>Fair Price</h4>
                <p style="color: #666;">Premium quality, best value</p>
            </div>
        </div>
    </div>
</section>

<%@ include file="../../../includes/footer.jsp" %>
</body>
</html>
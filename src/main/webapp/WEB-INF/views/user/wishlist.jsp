<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Wishlist - Unique Fancy</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/responsive.css">
    <style>
        .wishlist-container {
            padding: 40px 20px;
            max-width: 1200px;
            margin: 0 auto;
        }
        .page-title {
            font-size: 2rem;
            margin-bottom: 30px;
            text-align: center;
        }
        .empty-wishlist {
            text-align: center;
            padding: 80px 20px;
            background: white;
            border-radius: 16px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        .empty-wishlist h2 {
            margin-bottom: 15px;
            color: #1a1a2e;
        }
        .empty-wishlist p {
            margin-bottom: 25px;
            color: #666;
        }
        .wishlist-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 30px;
        }
        .wishlist-card {
            background: white;
            border-radius: 16px;
            overflow: hidden;
            transition: all 0.3s;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
            position: relative;
        }
        .wishlist-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
        }
        .wishlist-image {
            height: 220px;
            background: #f5f5f5;
            overflow: hidden;
            position: relative;
        }
        .wishlist-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.4s;
        }
        .wishlist-card:hover .wishlist-image img {
            transform: scale(1.05);
        }
        .wishlist-info {
            padding: 20px;
        }
        .wishlist-category {
            font-size: 0.7rem;
            color: #e8c547;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 8px;
        }
        .wishlist-name {
            font-size: 1.1rem;
            font-weight: 700;
            margin-bottom: 8px;
            color: #1a1a2e;
        }
        .wishlist-price {
            font-size: 1.2rem;
            font-weight: 700;
            color: #c0392b;
            margin-bottom: 15px;
        }
        .size-select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 8px;
            margin-bottom: 12px;
            font-size: 0.9rem;
        }
        .btn-add-cart {
            width: 100%;
            background: #e8c547;
            color: #1a1a2e;
            padding: 10px 15px;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            margin-bottom: 10px;
        }
        .btn-add-cart:hover {
            background: #d4b13e;
            transform: translateY(-2px);
        }
        .btn-remove {
            width: 100%;
            background: transparent;
            border: 2px solid #e74c3c;
            color: #e74c3c;
            padding: 8px 15px;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }
        .btn-remove:hover {
            background: #e74c3c;
            color: white;
            transform: translateY(-2px);
        }
        .btn-primary {
            background: #c0392b;
            color: white;
            padding: 12px 28px;
            border-radius: 40px;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s;
        }
        .btn-primary:hover {
            background: #a93226;
            transform: translateY(-2px);
        }
        @media (max-width: 1024px) {
            .wishlist-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }
        @media (max-width: 768px) {
            .wishlist-grid {
                grid-template-columns: 1fr;
            }
            .wishlist-container {
                padding: 20px;
            }
        }
    </style>
</head>
<body>
<%@ include file="../../../includes/header.jsp" %>
<%@ include file="../../../includes/flash-message.jsp" %>

<div class="wishlist-container">
    <h1 class="page-title">My Wishlist</h1>

    <c:choose>
        <c:when test="${empty wishlist}">
            <div class="empty-wishlist">
                <div style="font-size: 4rem; margin-bottom: 20px;">W</div>
                <h2>Your wishlist is empty</h2>
                <p>Save items you love and come back to them later.</p>
                <a href="${pageContext.request.contextPath}/products" class="btn-primary">Browse Products</a>
            </div>
        </c:when>

        <c:otherwise>
            <div class="wishlist-grid">
                <c:forEach var="product" items="${wishlist}">
                    <div class="wishlist-card">
                        <div class="wishlist-image">
                            <c:set var="category" value="${fn:toLowerCase(product.categoryName)}" />
                            <c:set var="imageNum" value="${(product.productId - 1) % 6 + 1}" />
                            <img src="${pageContext.request.contextPath}/images/products/${category}${imageNum}.jpg"
                                 alt="${product.productName}"
                                 onerror="this.src='${pageContext.request.contextPath}/images/placeholder.jpg'">
                        </div>
                        <div class="wishlist-info">
                            <div class="wishlist-category">${product.categoryName}</div>
                            <div class="wishlist-name">${product.productName}</div>
                            <div class="wishlist-price">Rs. <fmt:formatNumber value="${product.price}" pattern="#,##0.00"/></div>

                            <!-- Move to Cart Form -->
                            <form method="post" action="${pageContext.request.contextPath}/wishlist">
                                <input type="hidden" name="action" value="moveCart">
                                <input type="hidden" name="productId" value="${product.productId}">
                                <select name="size" class="size-select" required>
                                    <option value="">Select Size</option>
                                    <option>XS</option>
                                    <option>S</option>
                                    <option>M</option>
                                    <option>L</option>
                                    <option>XL</option>
                                    <option>XXL</option>
                                </select>
                                <button type="submit" class="btn-add-cart">Add to Cart</button>
                            </form>

                            <!-- Remove Form -->
                            <form method="post" action="${pageContext.request.contextPath}/wishlist">
                                <input type="hidden" name="action" value="remove">
                                <input type="hidden" name="productId" value="${product.productId}">
                                <button type="submit" class="btn-remove" onclick="return confirm('Remove this item from wishlist?')">Remove</button>
                            </form>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<%@ include file="../../../includes/footer.jsp" %>
</body>
</html>
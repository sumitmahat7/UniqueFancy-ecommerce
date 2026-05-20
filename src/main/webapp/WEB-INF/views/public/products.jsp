<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shop - Unique Fancy</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/responsive.css">
</head>
<body>
<%@ include file="../../../includes/header.jsp" %>
<%@ include file="../../../includes/flash-message.jsp" %>


<!-- Page Header -->
<div class="page-header">
    <div class="container">
        <div class="breadcrumb"><a href="${pageContext.request.contextPath}/">Home</a> / Shop</div>
        <h1>Our Collection</h1>
        <p class="lead">Ethically made, size-inclusive fashion for every style</p>
    </div>
</div>

<div class="container" style="padding-bottom:80px;">

    <!-- Search + Filter Bar -->
    <div style="background:white;border-radius:12px;padding:24px;box-shadow:var(--shadow);margin-bottom:32px;">
        <form method="get" action="${pageContext.request.contextPath}/products" style="display:flex;gap:16px;flex-wrap:wrap;align-items:flex-end;">
            <div style="flex:2;min-width:200px;">
                <label class="form-label">Search Products</label>
                <input type="text" name="search" class="form-control"
                       placeholder="Search by name or description..."
                       value="${param.search}">
            </div>
            <div style="flex:1;min-width:160px;">
                <label class="form-label">Category</label>
                <select name="category" class="form-control">
                    <option value="">All Categories</option>
                    <c:forEach var="cat" items="${categories}">
                        <option value="${cat.categoryId}" ${param.category == cat.categoryId ? 'selected' : ''}>
                                ${cat.categoryName}
                        </option>
                    </c:forEach>
                </select>
            </div>
            <div>
                <button type="submit" class="btn btn-primary">Search</button>
                <a href="${pageContext.request.contextPath}/products" class="btn btn-outline" style="margin-left:8px;">Clear</a>
            </div>
        </form>
    </div>

    <!-- Category Pills -->
    <div class="categories-strip" style="margin-bottom:24px;">
        <a href="${pageContext.request.contextPath}/products" class="category-pill ${empty param.category && empty param.search ? 'active' : ''}">All</a>
        <c:forEach var="cat" items="${categories}">
            <a href="${pageContext.request.contextPath}/products?category=${cat.categoryId}" class="category-pill ${param.category == cat.categoryId ? 'active' : ''}">
                    ${cat.categoryName}
            </a>
        </c:forEach>
    </div>

    <!-- Result count -->
    <div style="margin-bottom:20px;color:var(--grey);font-size:0.9rem;">
        <c:choose>
            <c:when test="${not empty param.search}">
                Showing results for "<strong>${param.search}</strong>"
            </c:when>
            <c:otherwise>
                Showing <strong>${products.size()}</strong> products
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Products Grid -->
    <c:choose>
        <c:when test="${empty products}">
            <div style="text-align:center;padding:80px 0;">
                <div style="font-size:4rem;margin-bottom:16px;">S</div>
                <h3>No products found</h3>
                <p style="color:var(--grey);">Try a different search or browse all categories.</p>
                <a href="${pageContext.request.contextPath}/products" class="btn btn-primary" style="margin-top:16px;">View All Products</a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="products-grid">
                <c:forEach var="product" items="${products}">
                    <div class="product-card">
                        <div class="product-card-img">
                            <a href="${pageContext.request.contextPath}/product-details?id=${product.productId}">
                                <c:set var="category" value="${fn:toLowerCase(product.categoryName)}" />
                                <c:set var="imageNum" value="${(product.productId - 1) % 6 + 1}" />
                                <img src="${pageContext.request.contextPath}/images/products/${category}${imageNum}.jpg"
                                     alt="${product.productName}"
                                     onerror="this.src='${pageContext.request.contextPath}/images/placeholder.jpg'">
                            </a>
                            <c:if test="${product.stock == 0}">
                                <span class="low-stock-badge" style="background:var(--grey);">Out of Stock</span>
                            </c:if>
                            <c:if test="${product.stock > 0 && product.stock < 10}">
                                <span class="low-stock-badge">Low Stock</span>
                            </c:if>
                        </div>
                        <div class="product-card-body">
                            <div class="product-card-category">${product.categoryName}</div>
                            <a href="${pageContext.request.contextPath}/product-details?id=${product.productId}">
                                <div class="product-card-name">${product.productName}</div>
                            </a>
                            <div class="product-card-price">
                                Rs. <fmt:formatNumber value="${product.price}" pattern="#,##0.00"/>
                            </div>
                            <div class="product-card-actions">
                                <a href="${pageContext.request.contextPath}/product-details?id=${product.productId}"
                                   class="btn btn-outline btn-sm" style="flex:1;justify-content:center;">Details</a>
                                <c:if test="${product.stock > 0}">
                                    <form method="post" action="${pageContext.request.contextPath}/wishlist" style="flex:0;">
                                        <input type="hidden" name="action" value="add">
                                        <input type="hidden" name="productId" value="${product.productId}">
                                        <button type="submit" class="btn btn-sm" title="Add to Wishlist"
                                                style="border:2px solid var(--border);background:white;">W</button>
                                    </form>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <!-- Pagination -->
            <c:if test="${totalPages > 1}">
                <div class="pagination">
                    <c:if test="${currentPage > 1}">
                        <a href="?page=${currentPage - 1}&search=${param.search}&category=${param.category}" class="page-link">&laquo; Previous</a>
                    </c:if>

                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <c:choose>
                            <c:when test="${i == currentPage}">
                                <span class="page-link active">${i}</span>
                            </c:when>
                            <c:otherwise>
                                <a href="?page=${i}&search=${param.search}&category=${param.category}" class="page-link">${i}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>

                    <c:if test="${currentPage < totalPages}">
                        <a href="?page=${currentPage + 1}&search=${param.search}&category=${param.category}" class="page-link">Next &raquo;</a>
                    </c:if>
                </div>
            </c:if>
        </c:otherwise>
    </c:choose>
</div>

<%@ include file="../../../includes/footer.jsp" %>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${product.productName} - Unique Fancy</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/responsive.css">
    <style>
        .product-info-section { padding: 16px 0; border-bottom: 1px solid var(--border); }
        .stock-info { font-size: 0.88rem; color: var(--grey); margin-top: 6px; }
        .size-stock-indicator { font-size: 0.75rem; color: var(--grey); display: block; text-align: center; margin-top: 2px; }
        .size-btn.selected { background: var(--red); color: white; border-color: var(--red); }
        .size-btn:disabled { opacity: 0.4; cursor: not-allowed; }
        .alert-warning { background: #fff3cd; color: #856404; border: 1px solid #ffeeba; padding: 10px; border-radius: 8px; margin-top: 8px; }
        .back-btn { margin-bottom: 20px; display: inline-block; }
    </style>
</head>
<body>
<%@ include file="../../../includes/header.jsp" %>
<%@ include file="../../../includes/flash-message.jsp" %>

<div class="page-header">
    <div class="container">
        <div class="breadcrumb">
            <a href="${pageContext.request.contextPath}/">Home</a> /
            <a href="${pageContext.request.contextPath}/products">Shop</a> /
            ${product.productName}
        </div>
        <div class="back-btn">
            <a href="javascript:history.back()" class="btn btn-outline btn-sm">
                &larr; Back to Products
            </a>
        </div>
    </div>
</div>

<div class="container">
    <div class="product-detail-grid" style="display: flex; gap: 40px; flex-wrap: wrap;">
        <!-- Product Image -->
        <div style="flex: 1; min-width: 250px;">
            <div style="max-width: 350px; margin: 0 auto;">
                <c:set var="category" value="${fn:toLowerCase(product.categoryName)}" />
                <c:set var="imageNum" value="${(product.productId - 1) % 6 + 1}" />
                <img src="${pageContext.request.contextPath}/images/products/${category}${imageNum}.jpg"
                     alt="${product.productName}"
                     style="width: 100%; height: auto; border-radius: 12px; box-shadow: 0 2px 10px rgba(0,0,0,0.1);"
                     onerror="this.src='${pageContext.request.contextPath}/images/placeholder.jpg'">
            </div>
        </div>

        <!-- Product Info -->
        <div style="flex: 1; min-width: 280px;">
            <div style="font-size:0.8rem;text-transform:uppercase;letter-spacing:1px;color:var(--grey);font-weight:600;margin-bottom:8px;">
                ${product.categoryName}
            </div>
            <h1 style="font-size:2rem;margin-bottom:8px;">${product.productName}</h1>

            <div style="font-size:2rem;font-weight:700;color:var(--red);margin-bottom:20px;">
                Rs. <fmt:formatNumber value="${product.price}" pattern="#,##0.00"/>
            </div>

            <div class="product-info-section">
                <p style="color:#4a4a5a;line-height:1.8;">${product.description}</p>
            </div>

            <!-- Availability -->
            <div class="product-info-section">
                <c:choose>
                    <c:when test="${product.stock > 0}">
                        <span style="color:var(--success);font-weight:600;">In Stock</span>
                        <span class="stock-info">${product.stock} units available</span>
                    </c:when>
                    <c:otherwise>
                        <span style="color:var(--red);font-weight:600;">Out of Stock</span>
                    </c:otherwise>
                </c:choose>
            </div>

            <c:if test="${product.stock > 0}">
                <!-- Size Selector -->
                <div class="product-info-section">
                    <div style="font-weight:600;margin-bottom:10px;">Select Size:</div>
                    <div class="size-selector" id="sizeSelector" style="display: flex; gap: 10px; flex-wrap: wrap;">
                        <c:forEach var="sz" items="${product.sizes}">
                            <div style="text-align:center;">
                                <button type="button"
                                        class="size-btn ${sz.sizeStock == 0 ? 'disabled' : ''}"
                                        <c:if test="${sz.sizeStock == 0}">disabled</c:if>
                                        onclick="selectSize('${sz.sizeName}', this)"
                                        data-size="${sz.sizeName}">
                                        ${sz.sizeName}
                                </button>
                                <span class="size-stock-indicator">${sz.sizeStock}</span>
                            </div>
                        </c:forEach>
                    </div>
                    <div id="noSizeWarning" style="display:none;" class="alert-warning">
                        Please select a size.
                    </div>
                </div>

                <!-- Quantity -->
                <div class="product-info-section">
                    <div style="font-weight:600;margin-bottom:10px;">Quantity:</div>
                    <div class="qty-control" style="display: flex; align-items: center; gap: 10px;">
                        <button type="button" class="qty-btn" onclick="changeQty(-1)" style="width: 40px; height: 40px; border: 1px solid var(--border); background: white; border-radius: 8px; cursor: pointer;">-</button>
                        <input type="number" id="quantityDisplay" class="qty-input" value="1" min="1" max="${product.stock}" style="width: 80px; height: 40px; text-align: center; border: 1px solid var(--border); border-radius: 8px;" readonly>
                        <button type="button" class="qty-btn" onclick="changeQty(1)" style="width: 40px; height: 40px; border: 1px solid var(--border); background: white; border-radius: 8px; cursor: pointer;">+</button>
                    </div>
                </div>

                <!-- Action Buttons -->
                <div style="display:flex;gap:12px;margin-top:24px;flex-wrap:wrap;">
                    <!-- Add to Cart -->
                    <form method="post" action="${pageContext.request.contextPath}/cart" id="cartForm" style="flex:1;">
                        <input type="hidden" name="action" value="add">
                        <input type="hidden" name="productId" value="${product.productId}">
                        <input type="hidden" name="size" id="cartSize" value="">
                        <input type="hidden" name="quantity" id="cartQty" value="1">
                        <button type="button" onclick="addToCart()" class="btn btn-primary btn-lg" style="width: 100%;">Add to Cart</button>
                    </form>

                    <!-- Wishlist -->
                    <form method="post" action="${pageContext.request.contextPath}/wishlist" style="flex:0;">
                        <input type="hidden" name="action" value="add">
                        <input type="hidden" name="productId" value="${product.productId}">
                        <button type="submit" class="btn btn-lg" style="border:2px solid var(--border);background:white; cursor: pointer;">W</button>
                    </form>
                </div>
            </c:if>

            <!-- Tags -->
            <div style="margin-top:24px;display:flex;gap:8px;flex-wrap:wrap;">
                <span style="background:var(--cream);padding:4px 12px;border-radius:20px;font-size:0.78rem;font-weight:600;">Sustainable</span>
                <span style="background:var(--cream);padding:4px 12px;border-radius:20px;font-size:0.78rem;font-weight:600;">Fair Trade</span>
                <span style="background:var(--cream);padding:4px 12px;border-radius:20px;font-size:0.78rem;font-weight:600;">Size Inclusive</span>
            </div>
        </div>
    </div>
    <div style="height:60px;"></div>
</div>

<%@ include file="../../../includes/footer.jsp" %>

<script>
    let selectedSize = '';
    let quantity = 1;
    const maxStock = ${product.stock};

    function selectSize(size, btn) {
        document.querySelectorAll('.size-btn').forEach(b => b.classList.remove('selected'));
        btn.classList.add('selected');
        selectedSize = size;
        document.getElementById('noSizeWarning').style.display = 'none';
    }

    function changeQty(delta) {
        quantity = Math.max(1, Math.min(maxStock, quantity + delta));
        document.getElementById('quantityDisplay').value = quantity;
    }

    function addToCart() {
        if (!selectedSize) {
            document.getElementById('noSizeWarning').style.display = 'block';
            return;
        }
        document.getElementById('cartSize').value = selectedSize;
        document.getElementById('cartQty').value = quantity;
        document.getElementById('cartForm').submit();
    }
</script>
</body>
</html>
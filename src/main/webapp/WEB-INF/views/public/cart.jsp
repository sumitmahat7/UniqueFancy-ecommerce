<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart - Unique Fancy</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/responsive.css">
    <style>
        .cart-container {
            padding: 40px 20px;
            max-width: 1200px;
            margin: 0 auto;
        }
        .page-title {
            font-size: 2rem;
            margin-bottom: 30px;
            text-align: center;
        }
        .empty-cart {
            text-align: center;
            padding: 80px 20px;
            background: white;
            border-radius: 16px;
        }
        .cart-layout {
            display: flex;
            gap: 30px;
            flex-wrap: wrap;
        }
        .cart-items-section {
            flex: 2;
            background: white;
            border-radius: 16px;
            padding: 20px;
        }
        .order-summary {
            flex: 1;
            background: white;
            border-radius: 16px;
            padding: 25px;
            height: fit-content;
        }
        .cart-table {
            width: 100%;
            border-collapse: collapse;
        }
        .cart-table th {
            text-align: left;
            padding: 15px 10px;
            background: #f9f5f0;
        }
        .cart-table td {
            padding: 15px 10px;
            border-bottom: 1px solid #eee;
        }
        .product-name {
            font-weight: 600;
        }
        .price-cell, .subtotal-cell {
            font-weight: 600;
            color: #c0392b;
        }
        .quantity-form {
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .qty-btn {
            width: 30px;
            height: 30px;
            border: 1px solid #ddd;
            background: white;
            border-radius: 6px;
            cursor: pointer;
        }
        .qty-value {
            min-width: 30px;
            text-align: center;
        }
        .btn-remove {
            background: transparent;
            border: none;
            color: #e74c3c;
            cursor: pointer;
        }
        .clear-cart {
            margin-top: 20px;
            text-align: right;
        }
        .summary-row {
            display: flex;
            justify-content: space-between;
            margin: 12px 0;
        }
        .summary-divider {
            margin: 15px 0;
            border-top: 1px solid #eee;
        }
        .summary-total {
            display: flex;
            justify-content: space-between;
            margin: 15px 0;
            font-weight: bold;
            font-size: 1.2rem;
        }
        .total-amount {
            color: #c0392b;
        }
        .checkout-btn {
            width: 100%;
            text-align: center;
            margin-top: 20px;
            display: block;
            background: #e8c547;
            color: #1a1a2e;
            padding: 14px;
            border-radius: 40px;
            text-decoration: none;
            font-weight: 600;
        }
        .continue-shopping {
            text-align: center;
            margin-top: 20px;
        }
        @media (max-width: 768px) {
            .cart-table thead {
                display: none;
            }
            .cart-table tbody tr {
                display: block;
                margin-bottom: 20px;
                border: 1px solid #eee;
                border-radius: 12px;
                padding: 10px;
            }
            .cart-table tbody td {
                display: flex;
                justify-content: space-between;
                padding: 8px;
            }
            .cart-table tbody td:before {
                content: attr(data-label);
                font-weight: bold;
                width: 40%;
            }
            .cart-layout {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
<%@ include file="../../../includes/header.jsp" %>
<%@ include file="../../../includes/flash-message.jsp" %>

<div class="cart-container">
    <h1 class="page-title">Shopping Cart</h1>

    <c:choose>
        <c:when test="${empty cart}">
            <div class="empty-cart">
                <h2>Your cart is empty</h2>
                <p>Browse our collection and add items you love.</p>
                <a href="${pageContext.request.contextPath}/products" class="btn btn-primary">Start Shopping</a>
            </div>
        </c:when>

        <c:otherwise>
            <div class="cart-layout">
                <div class="cart-items-section">
                    <div class="table-responsive">
                        <table class="cart-table">
                            <thead>
                            <tr>
                                <th>Product</th>
                                <th>Size</th>
                                <th>Price</th>
                                <th>Quantity</th>
                                <th>Subtotal</th>
                                <th></th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="item" items="${cart}">
                                <tr>
                                    <td data-label="Product">
                                        <div class="product-name">${item.productName}</div>
                                        <small>Size: ${item.size}</small>
                                    </td>
                                    <td data-label="Size">${item.size}</td>
                                    <td data-label="Price" class="price-cell">Rs. ${item.unitPrice}</td>
                                    <td data-label="Quantity">
                                        <form method="post" action="${pageContext.request.contextPath}/cart" class="quantity-form">
                                            <input type="hidden" name="action" value="update">
                                            <input type="hidden" name="cartKey" value="${item.cartKey}">
                                            <button type="submit" name="quantity" value="${item.quantity - 1}" class="qty-btn">-</button>
                                            <span class="qty-value">${item.quantity}</span>
                                            <button type="submit" name="quantity" value="${item.quantity + 1}" class="qty-btn">+</button>
                                        </form>
                                    </td>
                                    <td data-label="Subtotal" class="subtotal-cell">Rs. ${item.subtotal}</td>
                                    <td data-label="Remove">
                                        <form method="post" action="${pageContext.request.contextPath}/cart">
                                            <input type="hidden" name="action" value="remove">
                                            <input type="hidden" name="cartKey" value="${item.cartKey}">
                                            <button type="submit" class="btn-remove" onclick="return confirm('Remove this item?')">Remove</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <div class="clear-cart">
                        <form method="post" action="${pageContext.request.contextPath}/cart">
                            <input type="hidden" name="action" value="clear">
                            <button type="submit" class="btn btn-outline" onclick="return confirm('Clear entire cart?')">Clear Cart</button>
                        </form>
                    </div>

                    <div class="continue-shopping">
                        <a href="${pageContext.request.contextPath}/products">← Continue Shopping</a>
                    </div>
                </div>

                <div class="order-summary">
                    <h3>Order Summary</h3>
                    <div class="summary-row">
                        <span>Subtotal:</span>
                        <span>Rs. <fmt:formatNumber value="${total}" pattern="#,##0.00"/></span>
                    </div>
                    <div class="summary-row">
                        <span>Shipping:</span>
                        <span>
            <c:choose>
                <c:when test="${total >= 5000}">FREE</c:when>
                <c:otherwise>Rs. 150</c:otherwise>
            </c:choose>
        </span>
                    </div>
                    <hr class="summary-divider">
                    <div class="summary-total">
                        <span>Total:</span>
                        <span class="total-amount">
            Rs. <fmt:formatNumber value="${total >= 5000 ? total : total + 150}" pattern="#,##0.00"/>
        </span>
                    </div>
                    <a href="${pageContext.request.contextPath}/checkout" class="checkout-btn">Proceed to Checkout </a>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<%@ include file="../../../includes/footer.jsp" %>
</body>
</html>
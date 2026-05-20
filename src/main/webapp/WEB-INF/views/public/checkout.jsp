<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout - Unique Fancy</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/responsive.css">
    <style>
        .checkout-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 40px 20px;
        }
        .page-header {
            margin-bottom: 30px;
        }
        .page-header h1 {
            font-size: 2rem;
            margin-bottom: 10px;
        }
        .back-link {
            display: inline-block;
            margin-bottom: 20px;
            color: #666;
            text-decoration: none;
            transition: color 0.3s;
        }
        .back-link:hover {
            color: #e8c547;
        }
        .checkout-layout {
            display: flex;
            gap: 40px;
            flex-wrap: wrap;
        }
        .checkout-form-section {
            flex: 2;
            background: white;
            border-radius: 16px;
            padding: 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        .order-summary-section {
            flex: 1;
            background: white;
            border-radius: 16px;
            padding: 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            height: fit-content;
            position: sticky;
            top: 100px;
        }
        .section-title {
            font-size: 1.3rem;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #e8c547;
            display: inline-block;
        }
        .info-box {
            background: #f9f5f0;
            padding: 15px;
            border-radius: 12px;
            margin-bottom: 20px;
        }
        .info-row {
            display: flex;
            margin-bottom: 10px;
        }
        .info-label {
            width: 120px;
            font-weight: 600;
            color: #555;
        }
        .info-value {
            flex: 1;
            color: #333;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #333;
        }
        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 14px;
            transition: all 0.3s;
        }
        .form-control:focus {
            outline: none;
            border-color: #e8c547;
            box-shadow: 0 0 0 3px rgba(232,197,71,0.1);
        }
        textarea.form-control {
            resize: vertical;
            min-height: 100px;
        }
        .payment-header {
            margin-top: 30px;
        }
        .payment-options {
            display: flex;
            flex-direction: column;
            gap: 12px;
            margin: 15px 0 25px 0;
        }
        .payment-option {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px 15px;
            border: 2px solid #eee;
            border-radius: 12px;
            cursor: pointer;
            transition: all 0.3s;
        }
        .payment-option:hover {
            border-color: #e8c547;
            background: #fef9e7;
        }
        .payment-option.selected {
            border-color: #e8c547;
            background: #fef9e7;
        }
        .payment-option input {
            margin: 0;
            width: 18px;
            height: 18px;
            cursor: pointer;
        }
        .place-order-btn {
            width: 100%;
            background: #c0392b;
            color: white;
            padding: 14px;
            border: none;
            border-radius: 40px;
            font-size: 1rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s;
            margin-top: 10px;
        }
        .place-order-btn:hover {
            background: #a93226;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        .summary-item {
            margin-bottom: 15px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
        }
        .summary-item strong {
            display: block;
            margin-bottom: 5px;
            color: #1a1a2e;
        }
        .summary-item p {
            margin: 3px 0;
            color: #666;
            font-size: 0.85rem;
        }
        .summary-price {
            font-weight: 700;
            color: #c0392b;
            margin-top: 5px;
        }
        .summary-divider {
            margin: 15px 0;
            border: none;
            border-top: 1px solid #eee;
        }
        .summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            color: #555;
        }
        .summary-total {
            display: flex;
            justify-content: space-between;
            margin-top: 15px;
            padding-top: 15px;
            font-weight: 800;
            font-size: 1.2rem;
            border-top: 2px solid #eee;
        }
        .total-value {
            color: #c0392b;
        }
        @media (max-width: 768px) {
            .checkout-layout {
                flex-direction: column;
            }
            .order-summary-section {
                position: static;
            }
            .checkout-form-section, .order-summary-section {
                padding: 20px;
            }
        }
    </style>
</head>
<body>
<%@ include file="../../../includes/header.jsp" %>
<%@ include file="../../../includes/flash-message.jsp" %>

<div class="checkout-container">
    <div class="page-header">
        <a href="${pageContext.request.contextPath}/cart" class="back-link">← Back to Cart</a>
        <h1>Checkout</h1>
    </div>

    <c:if test="${not empty error}">
        <div class="alert alert-error">${error}</div>
    </c:if>

    <div class="checkout-layout">
        <!-- Checkout Form -->
        <div class="checkout-form-section">
            <form method="post" action="${pageContext.request.contextPath}/place-order" id="checkoutForm">
                <h3 class="section-title">Shipping Information</h3>

                <!-- User Info Box -->
                <div class="info-box">
                    <div class="info-row">
                        <div class="info-label">Full Name:</div>
                        <div class="info-value">${user.fullName}</div>
                    </div>
                    <div class="info-row">
                        <div class="info-label">Email:</div>
                        <div class="info-value">${user.email}</div>
                    </div>
                    <div class="info-row">
                        <div class="info-label">Phone:</div>
                        <div class="info-value">${user.phone}</div>
                    </div>
                </div>

                <div class="form-group">
                    <label for="shippingAddress">Delivery Address *</label>
                    <textarea id="shippingAddress" name="shippingAddress" class="form-control"
                              rows="3" placeholder="Enter your complete delivery address" required>${user.address}</textarea>
                </div>

                <h3 class="section-title payment-header">Payment Method</h3>
                <div class="payment-options">
                    <label class="payment-option">
                        <input type="radio" name="paymentMethod" value="Cash on Delivery" checked> Cash on Delivery
                    </label>
                    <label class="payment-option">
                        <input type="radio" name="paymentMethod" value="eSewa"> eSewa
                    </label>
                    <label class="payment-option">
                        <input type="radio" name="paymentMethod" value="Khalti"> Khalti
                    </label>
                    <label class="payment-option">
                        <input type="radio" name="paymentMethod" value="Bank Transfer"> Bank Transfer
                    </label>
                </div>

                <button type="submit" class="place-order-btn" onclick="return confirm('Confirm your order?')">Place Order</button>
            </form>
        </div>

        <!-- Order Summary -->
        <div class="order-summary-section">
            <h3 class="section-title">Order Summary</h3>

            <c:if test="${not empty cart}">
                <c:forEach var="item" items="${cart}">
                    <div class="summary-item">
                        <strong>${item.productName}</strong>
                        <p>Size: ${item.size} x ${item.quantity}</p>
                        <p class="summary-price">Rs. <fmt:formatNumber value="${item.price * item.quantity}" pattern="#,##0.00"/></p>
                    </div>
                </c:forEach>
            </c:if>

            <hr class="summary-divider">

            <div class="summary-row">
                <span>Subtotal:</span>
                <span>Rs. <fmt:formatNumber value="${cartTotal}" pattern="#,##0.00"/></span>
            </div>
            <div class="summary-row">
                <span>Shipping:</span>
                <span>
                    <c:choose>
                        <c:when test="${cartTotal >= 5000}">FREE</c:when>
                        <c:otherwise>Rs. 150</c:otherwise>
                    </c:choose>
                </span>
            </div>
            <div class="summary-total">
                <span>Total:</span>
                <span class="total-value">
                    Rs. <fmt:formatNumber value="${cartTotal >= 5000 ? cartTotal : cartTotal + 150}" pattern="#,##0.00"/>
                </span>
            </div>
        </div>
    </div>
</div>

<script>
    // Payment option selection styling
    document.querySelectorAll('.payment-option').forEach(option => {
        option.addEventListener('click', function() {
            document.querySelectorAll('.payment-option').forEach(opt => opt.classList.remove('selected'));
            this.classList.add('selected');
            this.querySelector('input[type="radio"]').checked = true;
        });
    });
</script>

<%@ include file="../../../includes/footer.jsp" %>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Details - Unique Fancy</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/responsive.css">
</head>
<body>
<%@ include file="../../../includes/header.jsp" %>
<%@ include file="../../../includes/flash-message.jsp" %>


<div class="container" style="padding: 40px 20px;">
    <h1>Order ${order.orderId}</h1>
    <a href="${pageContext.request.contextPath}/order-history" class="btn btn-outline">Back to Orders</a>

    <div style="display: flex; gap: 30px; flex-wrap: wrap; margin-top: 20px;">
        <!-- Order Items Table -->
        <div style="flex: 2; background: white; border-radius: 10px; padding: 20px;">
            <h3>Items</h3>
            <table style="width: 100%; border-collapse: collapse;">
                <thead>
                <tr style="background: #f0f0f0;">
                    <th style="padding: 10px;">Product</th>
                    <th style="padding: 10px;">Size</th>
                    <th style="padding: 10px;">Quantity</th>
                    <th style="padding: 10px;">Price</th>
                    <th style="padding: 10px;">Subtotal</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="item" items="${order.items}">
                    <tr style="border-bottom: 1px solid #ddd;">
                        <td style="padding: 10px;">${item.productName}</td>
                        <td style="padding: 10px;">${item.size}</td>
                        <td style="padding: 10px;">${item.quantity}</td>
                        <td style="padding: 10px;">Rs. ${item.price}</td>
                        <td style="padding: 10px; font-weight: bold;">Rs. ${item.subtotal}</td>
                    </tr>
                </c:forEach>
                </tbody>
                <tfoot>
                <tr style="background: #f9f9f9;">
                    <td colspan="4" style="text-align: right; padding: 10px; font-weight: bold;">Total:</td>
                    <td style="padding: 10px; font-weight: bold; color: #c0392b;">Rs. ${order.totalAmount}</td>
                </tr>
                </tfoot>
            </table>
        </div>

        <!-- Order Information -->
        <div style="flex: 1; background: white; border-radius: 10px; padding: 20px;">
            <h3>Order Information</h3>
            <p><strong>Order ID:</strong> ${order.orderId}</p>
            <p><strong>Date:</strong> <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/></p>
            <p><strong>Payment:</strong> ${order.paymentMethod}</p>
            <p><strong>Status:</strong> ${order.status}</p>
            <p><strong>Shipping Address:</strong><br>${order.shippingAddress}</p>

            <c:if test="${order.status == 'pending'}">
                <form method="post" action="${pageContext.request.contextPath}/cancel-order">
                    <input type="hidden" name="orderId" value="${order.orderId}">
                    <button type="submit" class="btn btn-danger" onclick="return confirm('Cancel this order?')">Cancel Order</button>
                </form>
            </c:if>
        </div>
    </div>
</div>

<%@ include file="../../../includes/footer.jsp" %>
</body>
</html>
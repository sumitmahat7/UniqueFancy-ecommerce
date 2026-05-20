<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Details - Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
</head>
<body>
<div class="admin-wrapper">
    <%@ include file="sidebar.jsp" %>
    <main class="admin-content">
        <%@ include file="../../../includes/flash-message.jsp" %>

        <div class="page-header">
            <h1>Order Details</h1>
            <p>Order ID: ${order.orderId}</p>
        </div>

        <a href="${pageContext.request.contextPath}/admin/manage-orders" class="btn btn-outline">← Back to Orders</a>

        <div style="display: flex; gap: 30px; flex-wrap: wrap; margin-top: 20px;">
            <!-- Order Items Table -->
            <div style="flex: 2; background: white; border-radius: 12px; padding: 20px;">
                <h3>Order Items</h3>
                <div class="table-responsive" style="overflow-x: auto;">
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
                                <td style="padding: 10px;">Rs. ${item.quantity * item.price}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                        <tfoot>
                        <tr style="background: #f9f9f9;">
                            <td colspan="4" style="text-align: right; padding: 10px;"><strong>Total:</strong></td>
                            <td style="padding: 10px;"><strong>Rs. ${order.totalAmount}</strong></td>
                        </tr>
                        </tfoot>
                    </table>
                </div>
            </div>

            <!-- Order Information -->
            <div style="flex: 1; background: white; border-radius: 12px; padding: 20px;">
                <h3>Order Information</h3>

                <div class="info-group" style="margin-bottom: 15px;">
                    <label style="font-weight: bold; display: block; margin-bottom: 5px;">Customer Name:</label>
                    <p style="margin: 0;">${order.userName}</p>
                </div>

                <div class="info-group" style="margin-bottom: 15px;">
                    <label style="font-weight: bold; display: block; margin-bottom: 5px;">Email:</label>
                    <p style="margin: 0;">${order.userEmail}</p>
                </div>

                <div class="info-group" style="margin-bottom: 15px;">
                    <label style="font-weight: bold; display: block; margin-bottom: 5px;">Order Date:</label>
                    <p style="margin: 0;"><fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/></p>
                </div>

                <div class="info-group" style="margin-bottom: 15px;">
                    <label style="font-weight: bold; display: block; margin-bottom: 5px;">Payment Method:</label>
                    <p style="margin: 0;">${order.paymentMethod}</p>
                </div>

                <div class="info-group" style="margin-bottom: 15px;">
                    <label style="font-weight: bold; display: block; margin-bottom: 5px;">Order Status:</label>
                    <p style="margin: 0;"><span class="status-badge status-${order.status}">${order.status}</span></p>
                </div>

                <div class="info-group" style="margin-bottom: 15px;">
                    <label style="font-weight: bold; display: block; margin-bottom: 5px;">Shipping Address:</label>
                    <p style="margin: 0;">${order.shippingAddress}</p>
                </div>

                <hr style="margin: 20px 0; border: none; border-top: 1px solid #eee;">

                <h3>Update Status</h3>
                <form method="post" action="${pageContext.request.contextPath}/admin/update-order">
                    <input type="hidden" name="orderId" value="${order.orderId}">
                    <select name="status" style="width: 100%; padding: 8px; margin-bottom: 10px; border: 1px solid #ddd; border-radius: 4px;">
                        <option value="pending" ${order.status == 'pending' ? 'selected' : ''}>Pending</option>
                        <option value="processing" ${order.status == 'processing' ? 'selected' : ''}>Processing</option>
                        <option value="shipped" ${order.status == 'shipped' ? 'selected' : ''}>Shipped</option>
                        <option value="cancelled" ${order.status == 'cancelled' ? 'selected' : ''}>Cancelled</option>
                    </select>
                    <button type="submit" class="btn btn-primary" style="width: 100%; padding: 8px;">Update Status</button>
                </form>
            </div>
        </div>
    </main>
</div>
</body>
</html>
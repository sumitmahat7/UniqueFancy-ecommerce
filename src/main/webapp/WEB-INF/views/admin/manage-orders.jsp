<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Orders - Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/responsive.css">
</head>
<body>
<div class="admin-wrapper">
    <%@ include file="sidebar.jsp" %>
    <main class="admin-content">
        <%@ include file="../../../includes/flash-message.jsp" %>

        <h1>Manage Orders</h1>
        <p>Total Orders: ${orders.size()}</p>

        <!-- Status Filter Buttons -->
        <div style="margin: 20px 0; display: flex; gap: 10px; flex-wrap: wrap;">
            <a href="${pageContext.request.contextPath}/admin/manage-orders" class="btn btn-sm btn-primary">All</a>
            <a href="${pageContext.request.contextPath}/admin/manage-orders?status=pending" class="btn btn-sm btn-outline">Pending</a>
            <a href="${pageContext.request.contextPath}/admin/manage-orders?status=processing" class="btn btn-sm btn-outline">Processing</a>
            <a href="${pageContext.request.contextPath}/admin/manage-orders?status=shipped" class="btn btn-sm btn-outline">Shipped</a>
            <a href="${pageContext.request.contextPath}/admin/manage-orders?status=cancelled" class="btn btn-sm btn-outline">Cancelled</a>
        </div>

        <!-- Orders Table -->
        <div style="background: white; border-radius: 10px; overflow-x: auto;">
            <table style="width: 100%; border-collapse: collapse;">
                <thead>
                <tr style="background: #1a1a2e; color: white;">
                    <th style="padding: 12px;">Order ID</th>
                    <th style="padding: 12px;">Customer</th>
                    <th style="padding: 12px;">Date</th>
                    <th style="padding: 12px;">Amount</th>
                    <th style="padding: 12px;">Status</th>
                    <th style="padding: 12px;">Update</th>
                    <th style="padding: 12px;">Action</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="order" items="${orders}">
                    <tr style="border-bottom: 1px solid #ddd;">
                        <td style="padding: 12px;">${order.orderId}</td>
                        <td style="padding: 12px;">
                            <strong>${order.userName}</strong><br>
                            <small>${order.userEmail}</small>
                        </td>
                        <td style="padding: 12px;">
                            <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/>
                        </td>
                        <td style="padding: 12px; color: #c0392b; font-weight: bold;">
                            Rs. ${order.totalAmount}
                        </td>
                        <td style="padding: 12px;">
                            <span class="badge-${order.status}">${order.status}</span>
                        </td>
                        <td style="padding: 12px;">
                            <form method="post" action="${pageContext.request.contextPath}/admin/update-order">
                                <input type="hidden" name="orderId" value="${order.orderId}">
                                <select name="status" style="padding: 5px;">
                                    <option value="pending" ${order.status == 'pending' ? 'selected' : ''}>Pending</option>
                                    <option value="processing" ${order.status == 'processing' ? 'selected' : ''}>Processing</option>
                                    <option value="shipped" ${order.status == 'shipped' ? 'selected' : ''}>Shipped</option>
                                    <option value="cancelled" ${order.status == 'cancelled' ? 'selected' : ''}>Cancelled</option>
                                </select>
                                <button type="submit" class="btn btn-sm btn-gold">Update</button>
                            </form>
                        </td>
                        <td style="padding: 12px;">
                            <a href="${pageContext.request.contextPath}/admin/order-detail?id=${order.orderId}" class="btn btn-sm btn-outline">View</a>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty orders}">
                    <tr>
                        <td colspan="7" style="text-align: center; padding: 40px;">No orders found</td>
                    </tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </main>
</div>
</body>
</html>
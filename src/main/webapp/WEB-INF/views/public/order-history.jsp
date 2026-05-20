<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Orders - Unique Fancy</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/responsive.css">
    <style>
        .orders-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 40px 20px;
        }
        .page-title {
            font-size: 2rem;
            margin-bottom: 30px;
            text-align: center;
        }
        .empty-orders {
            text-align: center;
            padding: 80px 20px;
            background: white;
            border-radius: 16px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        .empty-icon {
            font-size: 4rem;
            margin-bottom: 20px;
            opacity: 0.5;
        }
        .orders-table {
            width: 100%;
            background: white;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        .orders-table th {
            background: #1a1a2e;
            color: white;
            padding: 15px;
            text-align: left;
        }
        .orders-table td {
            padding: 15px;
            border-bottom: 1px solid #eee;
        }
        .orders-table tr:hover {
            background: #f9f5f0;
        }
        .status-badge {
            display: inline-block;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
        }
        .status-pending {
            background: #fff3cd;
            color: #856404;
        }
        .status-processing {
            background: #d1ecf1;
            color: #0c5460;
        }
        .status-shipped {
            background: #cce5ff;
            color: #004085;
        }
        .status-delivered {
            background: #d4edda;
            color: #155724;
        }
        .status-cancelled {
            background: #f8d7da;
            color: #721c24;
        }
        .btn-view {
            background: #e8c547;
            color: #1a1a2e;
            padding: 6px 15px;
            border-radius: 20px;
            text-decoration: none;
            font-size: 0.8rem;
            font-weight: 600;
            transition: all 0.3s;
            display: inline-block;
        }
        .btn-view:hover {
            background: #d4b13e;
            transform: translateY(-2px);
        }
        .btn-cancel {
            background: transparent;
            border: 1px solid #e74c3c;
            color: #e74c3c;
            padding: 5px 12px;
            border-radius: 20px;
            text-decoration: none;
            font-size: 0.75rem;
            font-weight: 600;
            margin-left: 8px;
            cursor: pointer;
            transition: all 0.3s;
        }
        .btn-cancel:hover {
            background: #e74c3c;
            color: white;
        }
        @media (max-width: 768px) {
            .orders-table {
                display: block;
                overflow-x: auto;
            }
        }
    </style>
</head>
<body>
<%@ include file="../../../includes/header.jsp" %>
<%@ include file="../../../includes/flash-message.jsp" %>

<div class="orders-container">
    <h1 class="page-title">My Orders</h1>

    <c:choose>
        <c:when test="${empty orders}">
            <div class="empty-orders">
                <div class="empty-icon">S</div>
                <h2>No orders yet</h2>
                <p>Start shopping to see your orders here.</p>
                <a href="${pageContext.request.contextPath}/products" class="btn btn-primary">Start Shopping</a>
            </div>
        </c:when>

        <c:otherwise>
            <table class="orders-table">
                <thead>
                <tr>
                    <th>Order ID</th>
                    <th>Date</th>
                    <th>Total Amount</th>
                    <th>Payment Method</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="order" items="${orders}">
                    <tr>
                        <td>#${order.orderId}</td>
                        <td><fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy"/></td>
                        <td>Rs. <fmt:formatNumber value="${order.totalAmount}" pattern="#,##0.00"/></td>
                        <td>${order.paymentMethod}</td>
                        <td>
                            <span class="status-badge status-${order.status}">${order.status}</span>
                        </td>
                        <td>
                            <a href="${pageContext.request.contextPath}/order-details?id=${order.orderId}" class="btn-view">View Details</a>
                            <c:if test="${order.status == 'pending'}">
                                <form method="post" action="${pageContext.request.contextPath}/cancel-order" style="display: inline;">
                                    <input type="hidden" name="orderId" value="${order.orderId}">
                                    <button type="submit" class="btn-cancel" onclick="return confirm('Cancel this order?')">Cancel</button>
                                </form>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>
</div>

<%@ include file="../../../includes/footer.jsp" %>
</body>
</html>
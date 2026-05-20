<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reports - Admin Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/responsive.css">
    <style>
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            margin-bottom: 30px;
        }
        .stat-card {
            background: white;
            padding: 20px;
            border-radius: 12px;
            text-align: center;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        .stat-card h3 {
            font-size: 0.9rem;
            color: #666;
            margin-bottom: 10px;
        }
        .stat-value {
            font-size: 1.8rem;
            font-weight: bold;
            color: #c0392b;
        }
        .reports-two-column {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 25px;
            margin-bottom: 30px;
        }
        .reports-card {
            background: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        .reports-card h3 {
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 2px solid #f0f0f0;
        }
        .product-rank {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            border-bottom: 1px solid #eee;
        }
        .product-price {
            font-weight: bold;
            color: #c0392b;
        }
        .stock-warning {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            border-bottom: 1px solid #eee;
            color: #e74c3c;
        }
        .stock-count {
            font-weight: bold;
        }
        .stock-success {
            color: #27ae60;
            padding: 10px 0;
        }
        .recent-orders-section {
            background: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        .recent-orders-section h3 {
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 2px solid #f0f0f0;
        }
        .table-responsive {
            overflow-x: auto;
        }
        .data-table {
            width: 100%;
            border-collapse: collapse;
        }
        .data-table th {
            background: #1a1a2e;
            color: white;
            padding: 12px;
            text-align: left;
        }
        .data-table td {
            padding: 10px;
            border-bottom: 1px solid #eee;
        }
        .amount-cell {
            font-weight: bold;
            color: #c0392b;
        }
        .status-badge {
            padding: 4px 10px;
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
        .empty-row {
            text-align: center;
            padding: 30px;
            color: #999;
        }
        @media (max-width: 768px) {
            .stats-grid, .reports-two-column {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<div class="admin-wrapper">
    <%@ include file="sidebar.jsp" %>
    <main class="admin-content">
        <%@ include file="../../../includes/flash-message.jsp" %>

        <div class="page-header">
            <h1>Reports and Analytics</h1>
            <p>Sales overview and product performance</p>
        </div>

        <!-- Revenue Summary Cards -->
        <div class="stats-grid">
            <div class="stat-card">
                <h3>Total Revenue</h3>
                <p class="stat-value">Rs. <fmt:formatNumber value="${totalSales}" pattern="#,##0.00"/></p>
            </div>
            <div class="stat-card">
                <h3>Today's Sales</h3>
                <p class="stat-value">Rs. <fmt:formatNumber value="${todaySales}" pattern="#,##0.00"/></p>
            </div>
            <div class="stat-card">
                <h3>Monthly Sales</h3>
                <p class="stat-value">Rs. <fmt:formatNumber value="${monthlySales}" pattern="#,##0.00"/></p>
            </div>
            <div class="stat-card">
                <h3>Total Orders</h3>
                <p class="stat-value">${totalOrders}</p>
            </div>
        </div>

        <div class="reports-two-column">
            <!-- Top Selling Products -->
            <div class="reports-card">
                <h3>Top 5 Best Selling Products</h3>
                <c:if test="${empty topProducts}">
                    <p class="stock-success">No sales data available</p>
                </c:if>
                <c:forEach var="product" items="${topProducts}" varStatus="status">
                    <div class="product-rank">
                        <span>${status.index + 1}. ${product.productName}</span>
                        <span class="product-price">Rs. <fmt:formatNumber value="${product.price}" pattern="#,##0.00"/></span>
                    </div>
                </c:forEach>
            </div>

            <!-- Low Stock Alert -->
            <div class="reports-card">
                <h3>Low Stock Products (Below 10)</h3>
                <c:if test="${empty lowStock}">
                    <p class="stock-success">All products have sufficient stock</p>
                </c:if>
                <c:forEach var="product" items="${lowStock}">
                    <div class="stock-warning">
                        <span>${product.productName}</span>
                        <span class="stock-count">Stock: ${product.stock}</span>
                    </div>
                </c:forEach>
            </div>
        </div>

        <!-- Recent Orders -->
        <div class="recent-orders-section">
            <h3>Recent Orders</h3>
            <div class="table-responsive">
                <table class="data-table">
                    <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Customer</th>
                        <th>Amount</th>
                        <th>Status</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="order" items="${recentOrders}" end="9">
                        <tr>
                            <td>${order.orderId}</td>
                            <td>${order.userName}</td>
                            <td class="amount-cell">Rs. <fmt:formatNumber value="${order.totalAmount}" pattern="#,##0.00"/></td>
                            <td>
                                <span class="status-badge status-${order.status}">${order.status}</span>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty recentOrders}">
                        <tr>
                            <td colspan="4" class="empty-row">No orders found</td>
                        </tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </main>
</div>
</body>
</html>
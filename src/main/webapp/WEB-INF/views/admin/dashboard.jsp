<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard - Unique Fancy</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/responsive.css">
    <style>
        .dashboard-stats {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            margin: 30px 0;
        }
        .stat-card {
            background: white;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            transition: transform 0.3s;
        }
        .stat-card:hover {
            transform: translateY(-5px);
        }
        .stat-title {
            font-size: 0.85rem;
            color: #666;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 10px;
        }
        .stat-value {
            font-size: 2rem;
            font-weight: bold;
            color: #1a1a2e;
        }
        .stat-unit {
            font-size: 0.9rem;
            color: #c0392b;
            margin-left: 5px;
        }
        .welcome-section {
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%);
            color: white;
            padding: 30px;
            border-radius: 16px;
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
        }
        .welcome-section h2 {
            margin-bottom: 10px;
        }
        .welcome-section p {
            opacity: 0.8;
        }
        .back-button {
            background: rgba(255,255,255,0.2);
            color: white;
            padding: 10px 20px;
            border-radius: 40px;
            text-decoration: none;
            font-size: 0.9rem;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        .back-button:hover {
            background: rgba(255,255,255,0.3);
            transform: translateX(-3px);
        }
        .quick-actions {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            margin: 30px 0;
        }
        .action-btn {
            background: white;
            padding: 20px;
            text-align: center;
            border-radius: 12px;
            text-decoration: none;
            transition: all 0.3s;
            border: 1px solid #eee;
        }
        .action-btn:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
            border-color: #e8c547;
        }
        .action-icon {
            font-size: 2rem;
            font-weight: bold;
            color: #e8c547;
            margin-bottom: 10px;
        }
        .action-btn h4 {
            color: #1a1a2e;
            margin-bottom: 5px;
        }
        .action-btn p {
            font-size: 0.8rem;
            color: #666;
        }
        .recent-section {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 25px;
            margin-top: 30px;
        }
        .recent-card {
            background: white;
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        .recent-card h3 {
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 2px solid #f0f0f0;
        }
        .recent-item {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            border-bottom: 1px solid #f0f0f0;
        }
        .recent-item:last-child {
            border-bottom: none;
        }
        .recent-name {
            font-weight: 500;
        }
        .recent-price {
            color: #c0392b;
            font-weight: bold;
        }
        .recent-status {
            font-size: 0.75rem;
            padding: 2px 8px;
            border-radius: 20px;
        }
        .status-pending {
            background: #fff3cd;
            color: #856404;
        }
        .status-delivered {
            background: #d4edda;
            color: #155724;
        }
        .view-all {
            text-align: center;
            margin-top: 15px;
        }
        .view-all a {
            color: #e8c547;
            text-decoration: none;
        }
        @media (max-width: 1024px) {
            .dashboard-stats, .quick-actions {
                grid-template-columns: repeat(2, 1fr);
            }
            .recent-section {
                grid-template-columns: 1fr;
            }
        }
        @media (max-width: 640px) {
            .dashboard-stats, .quick-actions {
                grid-template-columns: 1fr;
            }
            .welcome-section {
                flex-direction: column;
                text-align: center;
                gap: 15px;
            }
        }
    </style>
</head>
<body>
<div class="admin-wrapper">
    <%@ include file="sidebar.jsp" %>
    <main class="admin-content">
        <%@ include file="../../../includes/flash-message.jsp" %>

        <!-- Welcome Section with Back Button -->
        <div class="welcome-section">
            <div>
                <h2>Welcome back, ${sessionScope.userName}!</h2>
                <p>Here's what's happening with your store today.</p>
            </div>
            <div>
                <a href="javascript:history.back()" class="back-button">
                    ← Back
                </a>
                <a href="${pageContext.request.contextPath}/" class="back-button" style="margin-left: 10px;">
                    View Store
                </a>
            </div>
        </div>

        <!-- Statistics Cards -->
        <div class="dashboard-stats">
            <div class="stat-card">
                <div class="stat-title">Total Products</div>
                <div class="stat-value">${totalProducts} <span class="stat-unit">items</span></div>
            </div>
            <div class="stat-card">
                <div class="stat-title">Total Orders</div>
                <div class="stat-value">${totalOrders} <span class="stat-unit">orders</span></div>
            </div>
            <div class="stat-card">
                <div class="stat-title">Total Users</div>
                <div class="stat-value">${totalUsers} <span class="stat-unit">customers</span></div>
            </div>
            <div class="stat-card">
                <div class="stat-title">Total Revenue</div>
                <div class="stat-value">Rs. ${totalRevenue} <span class="stat-unit"></span></div>
            </div>
        </div>

        <!-- Quick Actions -->
        <div class="quick-actions">
            <a href="${pageContext.request.contextPath}/admin/add-product" class="action-btn">
                <div class="action-icon">P</div>
                <h4>Add Product</h4>
                <p>Add new product to store</p>
            </a>
            <a href="${pageContext.request.contextPath}/admin/manage-orders" class="action-btn">
                <div class="action-icon">O</div>
                <h4>Manage Orders</h4>
                <p>View and update orders</p>
            </a>
            <a href="${pageContext.request.contextPath}/admin/manage-categories" class="action-btn">
                <div class="action-icon">C</div>
                <h4>Categories</h4>
                <p>Manage product categories</p>
            </a>
            <a href="${pageContext.request.contextPath}/admin/reports" class="action-btn">
                <div class="action-icon">R</div>
                <h4>Reports</h4>
                <p>View sales analytics</p>
            </a>
        </div>

        <!-- Recent Orders & Activity -->
        <div class="recent-section">
            <div class="recent-card">
                <h3>Recent Orders</h3>
                <c:forEach var="order" items="${recentOrders}" end="4">
                    <div class="recent-item">
                        <span class="recent-name">Order #${order.orderId}</span>
                        <span class="recent-price">Rs. ${order.totalAmount}</span>
                        <span class="recent-status status-${order.status}">${order.status}</span>
                    </div>
                </c:forEach>
                <c:if test="${empty recentOrders}">
                    <p style="color: #999; text-align: center;">No recent orders</p>
                </c:if>
                <div class="view-all">
                    <a href="${pageContext.request.contextPath}/admin/manage-orders">View All Orders →</a>
                </div>
            </div>

            <div class="recent-card">
                <h3>Recent Customers</h3>
                <c:forEach var="user" items="${recentUsers}" end="4">
                    <div class="recent-item">
                        <span class="recent-name">${user.fullName}</span>
                        <span>${user.email}</span>
                    </div>
                </c:forEach>
                <c:if test="${empty recentUsers}">
                    <p style="color: #999; text-align: center;">No recent users</p>
                </c:if>
                <div class="view-all">
                    <a href="${pageContext.request.contextPath}/admin/manage-users">View All Users →</a>
                </div>
            </div>
        </div>
    </main>
</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Details - Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/responsive.css">
    <style>
        .user-detail-layout {
            display: flex;
            gap: 30px;
            flex-wrap: wrap;
            margin-top: 20px;
        }
        .user-info-card {
            flex: 1;
            background: white;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        .user-orders-card {
            flex: 2;
            background: white;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        .user-info-card h3, .user-orders-card h3 {
            margin-top: 0;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #e8c547;
            display: inline-block;
        }
        .info-row {
            display: flex;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 1px solid #f0f0f0;
        }
        .info-row label {
            width: 130px;
            font-weight: 600;
            color: #555;
        }
        .info-row span {
            flex: 1;
            color: #333;
        }
        .role-badge {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
        }
        .role-badge.admin {
            background: #e8c547;
            color: #1a1a2e;
        }
        .role-badge.user {
            background: #f0f0f0;
            color: #333;
        }
        .amount-cell {
            font-weight: 600;
            color: #c0392b;
        }
        .btn-view {
            background: #3498db;
            color: white;
            padding: 5px 12px;
            border-radius: 4px;
            text-decoration: none;
            font-size: 12px;
        }
        .btn-view:hover {
            background: #2980b9;
        }
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            flex-wrap: wrap;
            gap: 15px;
        }
        .page-header h1 {
            margin: 0;
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
        .table-responsive {
            overflow-x: auto;
        }
        .status-badge {
            display: inline-block;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 600;
        }
        .status-pending { background: #fff3cd; color: #856404; }
        .status-processing { background: #d1ecf1; color: #0c5460; }
        .status-shipped { background: #cce5ff; color: #004085; }
        .status-delivered { background: #d4edda; color: #155724; }
        .status-cancelled { background: #f8d7da; color: #721c24; }
        .text-muted {
            color: #999;
            text-align: center;
            padding: 30px;
        }
        @media (max-width: 768px) {
            .user-detail-layout {
                flex-direction: column;
            }
            .info-row {
                flex-direction: column;
            }
            .info-row label {
                width: 100%;
                margin-bottom: 5px;
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
            <h1>User Details</h1>
            <a href="${pageContext.request.contextPath}/admin/manage-users" class="btn btn-outline">← Back to Users</a>
        </div>

        <div class="user-detail-layout">
            <!-- User Information -->
            <div class="user-info-card">
                <h3>Personal Information</h3>

                <div class="info-row">
                    <label>User ID</label>
                    <span>${user.userId}</span>
                </div>

                <div class="info-row">
                    <label>Full Name</label>
                    <span>${user.fullName}</span>
                </div>

                <div class="info-row">
                    <label>Email</label>
                    <span>${user.email}</span>
                </div>

                <div class="info-row">
                    <label>Phone</label>
                    <span>${user.phone}</span>
                </div>

                <div class="info-row">
                    <label>Role</label>
                    <span class="role-badge ${user.role}">${user.role}</span>
                </div>

                <div class="info-row">
                    <label>Address</label>
                    <span>${user.address != null ? user.address : 'Not provided'}</span>
                </div>

                <div class="info-row">
                    <label>Registered On</label>
                    <span><fmt:formatDate value="${user.createdAt}" pattern="dd/MM/yyyy HH:mm"/></span>
                </div>
            </div>

            <!-- Order History -->
            <div class="user-orders-card">
                <h3>Order History</h3>

                <c:if test="${empty orders}">
                    <p class="text-muted">This user has not placed any orders yet.</p>
                </c:if>

                <c:if test="${not empty orders}">
                    <div class="table-responsive">
                        <table class="data-table">
                            <thead>
                            <tr>
                                <th>Order ID</th>
                                <th>Date</th>
                                <th>Total</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="order" items="${orders}">
                                <tr>
                                    <td>${order.orderId}</td>
                                    <td><fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy"/></td>
                                    <td class="amount-cell">Rs. ${order.totalAmount}</td>
                                    <td><span class="status-badge status-${order.status}">${order.status}</span></td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/admin/order-detail?id=${order.orderId}" class="btn-view">View</a>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:if>
            </div>
        </div>
    </main>
</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Users - Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/responsive.css">
</head>
<body>
<div class="admin-wrapper">
    <%@ include file="sidebar.jsp" %>
    <main class="admin-content">
        <%@ include file="../../../includes/flash-message.jsp" %>

        <h1>Manage Users</h1>
        <p>Total Users: ${users.size()}</p>

        <!-- Users Table -->
        <div style="background: white; border-radius: 10px; overflow-x: auto;">
            <table style="width: 100%; border-collapse: collapse;">
                <thead>
                <tr style="background: #1a1a2e; color: white;">
                    <th style="padding: 12px;">ID</th>
                    <th style="padding: 12px;">Name</th>
                    <th style="padding: 12px;">Email</th>
                    <th style="padding: 12px;">Phone</th>
                    <th style="padding: 12px;">Role</th>
                    <th style="padding: 12px;">Registered Date</th>
                    <th style="padding: 12px;">Action</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="user" items="${users}">
                    <tr style="border-bottom: 1px solid #ddd;">
                        <td style="padding: 12px;">${user.userId}</td>
                        <td style="padding: 12px; font-weight: bold;">${user.fullName}</td>
                        <td style="padding: 12px;">${user.email}</td>
                        <td style="padding: 12px;">${user.phone}</td>
                        <td style="padding: 12px;">
                                <span style="background: ${user.role == 'admin' ? '#e8c547' : '#f0f0f0'};
                                        color: ${user.role == 'admin' ? '#1a1a2e' : '#333'};
                                        padding: 4px 10px; border-radius: 15px; font-size: 0.8rem;">
                                        ${user.role}
                                </span>
                        </td>
                        <td style="padding: 12px;">
                            <fmt:formatDate value="${user.createdAt}" pattern="dd/MM/yyyy"/>
                        </td>
                        <td style="padding: 12px;">
                            <a href="${pageContext.request.contextPath}/admin/user-detail?id=${user.userId}" class="btn btn-sm btn-outline">View</a>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty users}">
                    <tr>
                        <td colspan="7" style="text-align: center; padding: 40px;">No users found</td>
                    </tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </main>
</div>
</body>
</html>
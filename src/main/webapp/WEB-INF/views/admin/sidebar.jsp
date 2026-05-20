<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<aside class="admin-sidebar">
    <div class="sidebar-logo">
        Unique Fancy
        <small>Admin Panel</small>
    </div>
    <nav class="sidebar-nav">
        <div class="sidebar-section-title">MAIN</div>
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="sidebar-link">Dashboard</a>

        <div class="sidebar-section-title">CATALOGUE</div>
        <a href="${pageContext.request.contextPath}/admin/manage-products" class="sidebar-link">Products</a>
        <a href="${pageContext.request.contextPath}/admin/manage-categories" class="sidebar-link">Categories</a>

        <div class="sidebar-section-title">COMMERCE</div>
        <a href="${pageContext.request.contextPath}/admin/manage-orders" class="sidebar-link">Orders</a>
        <a href="${pageContext.request.contextPath}/admin/manage-users" class="sidebar-link">Users</a>

        <div class="sidebar-section-title">ANALYTICS</div>
        <a href="${pageContext.request.contextPath}/admin/reports" class="sidebar-link">Reports</a>

        <div class="sidebar-section-title">ACCOUNT</div>
        <a href="${pageContext.request.contextPath}/" class="sidebar-link">View Store</a>
        <a href="${pageContext.request.contextPath}/logout" class="sidebar-link">Logout</a>
    </nav>
</aside>
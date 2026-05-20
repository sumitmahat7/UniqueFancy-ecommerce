<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    java.util.List<?> cartItems = (java.util.List<?>) session.getAttribute("cart");
    int cartCount = (cartItems != null) ? cartItems.size() : 0;
    pageContext.setAttribute("cartCount", cartCount);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${not empty pageTitle ? pageTitle : 'Unique Fancy'} - Sustainable Fashion</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/responsive.css">
</head>
<body>

<header class="site-header">
    <div class="header-inner">
        <a href="${pageContext.request.contextPath}/" class="logo">Unique<span>Fancy</span></a>

        <!-- Mobile Menu Button -->
        <button class="mobile-menu-btn" onclick="toggleMobileMenu()">☰</button>

        <nav class="nav-links" id="mobileNav">
            <a href="${pageContext.request.contextPath}/">Home</a>
            <a href="${pageContext.request.contextPath}/products">Shop</a>
            <a href="${pageContext.request.contextPath}/about.jsp">About</a>
            <a href="${pageContext.request.contextPath}/contact.jsp">Contact</a>
            <c:if test="${not empty sessionScope.loggedInUser}">
                <c:if test="${sessionScope.loggedInUser.role != 'admin'}">
                    <a href="${pageContext.request.contextPath}/order-history">My Orders</a>
                    <a href="${pageContext.request.contextPath}/profile">Profile</a>
                    <a href="${pageContext.request.contextPath}/wishlist">Wishlist</a>
                </c:if>
                <c:if test="${sessionScope.loggedInUser.role == 'admin'}">
                    <a href="${pageContext.request.contextPath}/admin/dashboard" style="color:var(--gold);">Admin Panel</a>
                    <a href="${pageContext.request.contextPath}/profile">Profile</a>
                </c:if>
            </c:if>
        </nav>

        <div class="nav-actions">
            <c:if test="${not empty sessionScope.loggedInUser and sessionScope.loggedInUser.role != 'admin'}">
                <a href="${pageContext.request.contextPath}/cart" class="cart-icon" title="Cart">
                    Cart
                    <c:if test="${cartCount > 0}">
                        <span class="cart-badge">${cartCount}</span>
                    </c:if>
                </a>
            </c:if>
            <c:choose>
                <c:when test="${not empty sessionScope.loggedInUser}">
                    <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-white btn-sm">Logout</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-white btn-sm">Login</a>
                    <a href="${pageContext.request.contextPath}/register" class="btn btn-gold btn-sm">Register</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</header>

<script>
    function toggleMobileMenu() {
        var nav = document.getElementById('mobileNav');
        nav.classList.toggle('show');
    }
</script>
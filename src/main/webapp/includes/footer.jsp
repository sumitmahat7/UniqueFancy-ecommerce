<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<footer>
    <div class="container">
        <div class="footer-grid">
            <!-- Brand -->
            <div class="footer-brand">
                <div class="logo">Unique<span>Fancy</span></div>
                <p>Celebrating size-inclusive, sustainable fashion. Every garment tells a story of ethical craftsmanship and body positivity.</p>
                <div class="social-icons">
                    <a href="#" class="social-icon">F</a>
                    <a href="#" class="social-icon">I</a>
                    <a href="#" class="social-icon">T</a>
                    <a href="#" class="social-icon">P</a>
                </div>
            </div>

            <!-- Quick Links -->
            <div>
                <div class="footer-heading">Quick Links</div>
                <div class="footer-links">
                    <a href="${pageContext.request.contextPath}/">Home</a>
                    <a href="${pageContext.request.contextPath}/products">Shop All</a>
                    <a href="${pageContext.request.contextPath}/about.jsp">About Us</a>
                    <a href="${pageContext.request.contextPath}/contact.jsp">Contact</a>
                </div>
            </div>

            <!-- Categories -->
            <div>
                <div class="footer-heading">Categories</div>
                <div class="footer-links">
                    <a href="${pageContext.request.contextPath}/products?category=1">Men's Wear</a>
                    <a href="${pageContext.request.contextPath}/products?category=2">Women's Wear</a>
                    <a href="${pageContext.request.contextPath}/products?category=3">Kids Wear</a>
                    <a href="${pageContext.request.contextPath}/products?category=5">Accessories</a>
                    <a href="${pageContext.request.contextPath}/products?category=4">Footwear</a>
                </div>
            </div>

            <!-- Newsletter -->
            <div>
                <div class="footer-heading">Stay Updated</div>
                <p>Subscribe for sustainable fashion tips and exclusive offers.</p>
                <form class="newsletter-form" action="#" method="post">
                    <input type="email" name="email" class="newsletter-input" placeholder="Your email address" required>
                    <button type="button" class="btn btn-gold btn-sm" onclick="alert('Newsletter feature coming soon!')">Subscribe</button>
                </form>
                <p>We never spam. Unsubscribe anytime.</p>
            </div>
        </div>

        <div class="footer-bottom">
            <span>© 2025 Unique Fancy. All rights reserved.</span>
            <span>Made for sustainable, size-inclusive fashion</span>
        </div>
    </div>
</footer>
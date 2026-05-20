<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Unique Fancy</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/responsive.css">
    <style>
        .auth-page { min-height: 80vh; display: flex; align-items: center; background: linear-gradient(135deg, var(--cream) 0%, white 100%); padding: 40px 0; }
        .auth-card { background: white; border-radius: 16px; box-shadow: 0 8px 40px rgba(0,0,0,0.1); padding: 48px 40px; width: 100%; max-width: 520px; margin: 0 auto; }
        .auth-title { font-size: 1.8rem; text-align: center; margin-bottom: 6px; }
        .auth-sub { text-align: center; color: var(--grey); margin-bottom: 32px; font-size: 0.95rem; }
    </style>
</head>
<body>
<%@ include file="../../../includes/header.jsp" %>
<%@ include file="../../../includes/flash-message.jsp" %>

<div class="auth-page">
    <div class="container">
        <div class="auth-card">
            <div style="text-align:center;margin-bottom:24px;">
                <a href="${pageContext.request.contextPath}/" class="logo" style="font-size:1.8rem;display:inline-block;">Unique Fancy</a>
            </div>
            <h1 class="auth-title">Create Account</h1>
            <p class="auth-sub">Join the sustainable fashion movement</p>

            <form method="post" action="${pageContext.request.contextPath}/register" novalidate>
                <div class="grid-2" style="display: grid; grid-template-columns: 1fr 1fr; gap: 16px;">
                    <div class="form-group">
                        <label class="form-label" for="fullName">Full Name *</label>
                        <input type="text" id="fullName" name="fullName" class="form-control"
                               placeholder="fullname" value="${param.fullName}" required>
                        <div class="form-hint">Letters and spaces only, min 2 chars</div>
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="phone">Phone Number *</label>
                        <input type="tel" id="phone" name="phone" class="form-control"
                               placeholder="9800000000" value="${param.phone}" required>
                        <div class="form-hint">10-15 digits only</div>
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label" for="email">Email Address *</label>
                    <input type="email" id="email" name="email" class="form-control"
                           placeholder="you@example.com" value="${param.email}" required>
                </div>

                <div class="form-group">
                    <label class="form-label" for="address">Address</label>
                    <input type="text" id="address" name="address" class="form-control"
                           placeholder="Street, City, Province" value="${param.address}">
                </div>

                <div class="grid-2" style="display: grid; grid-template-columns: 1fr 1fr; gap: 16px;">
                    <div class="form-group">
                        <label class="form-label" for="password">Password *</label>
                        <input type="password" id="password" name="password" class="form-control"
                               placeholder="Minimum 6 characters" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="confirmPassword">Confirm Password *</label>
                        <input type="password" id="confirmPassword" name="confirmPassword" class="form-control"
                               placeholder="Repeat password" required>
                    </div>
                </div>

                <div style="margin-bottom:24px;font-size:0.88rem;color:var(--grey);">
                    By registering you agree to our <a href="#" style="color:var(--red);">Terms of Service</a> and
                    <a href="#" style="color:var(--red);">Privacy Policy</a>.
                </div>

                <button type="submit" class="btn btn-primary btn-block btn-lg" style="width: 100%;">Create My Account</button>
            </form>

            <p style="text-align:center;margin-top:20px;font-size:0.92rem;color:var(--grey);">
                Already have an account?
                <a href="${pageContext.request.contextPath}/login" style="color:var(--red);font-weight:600;">Sign In</a>
            </p>
        </div>
    </div>
</div>
<%@ include file="../../../includes/footer.jsp" %>


</body>
</html>
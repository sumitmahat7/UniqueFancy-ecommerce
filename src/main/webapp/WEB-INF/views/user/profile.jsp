<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile - Unique Fancy</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/responsive.css">
</head>
<body>
<%@ include file="../../../includes/header.jsp" %>
<%@ include file="../../../includes/flash-message.jsp" %>

<div class="container" style="padding: 40px 20px;">
    <h1>My Profile</h1>

    <div class="profile-layout" style="max-width: 600px; margin: 0 auto;">
        <!-- Edit Profile Form -->
        <div class="profile-card" style="background: white; border-radius: 16px; padding: 30px; box-shadow: 0 2px 10px rgba(0,0,0,0.05);">
            <h3 style="margin-bottom: 20px; padding-bottom: 10px; border-bottom: 2px solid #e8c547; display: inline-block;">Edit Profile</h3>

            <form method="post" action="${pageContext.request.contextPath}/profile">
                <div class="form-group">
                    <label>Full Name</label>
                    <input type="text" name="fullName" class="form-control" value="${user.fullName}" required>
                </div>
                <div class="form-group">
                    <label>Email</label>
                    <input type="email" class="form-control" value="${user.email}" readonly>
                    <small>Email cannot be changed</small>
                </div>
                <div class="form-group">
                    <label>Phone</label>
                    <input type="tel" name="phone" class="form-control" value="${user.phone}" required>
                </div>
                <div class="form-group">
                    <label>Address</label>
                    <textarea name="address" class="form-control" rows="3">${user.address}</textarea>
                </div>
                <button type="submit" class="btn btn-primary">Save Changes</button>
                <a href="${pageContext.request.contextPath}/" class="btn btn-outline" style="margin-left: 10px;">Cancel</a>
            </form>
        </div>
    </div>
</div>

<%@ include file="../../../includes/footer.jsp" %>
</body>
</html>
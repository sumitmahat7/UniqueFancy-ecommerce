<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Server Error - Unique Fancy</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'DM Sans', system-ui, -apple-system, sans-serif;
            background: #f5f0e8;
        }
        .error-container {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            padding: 40px;
        }
        .error-icon {
            font-size: 6rem;
            margin-bottom: 16px;
            opacity: 0.3;
        }
        h1 {
            font-size: 5rem;
            font-family: 'Playfair Display', serif;
            color: #1a1a2e;
            margin-bottom: 8px;
        }
        h2 {
            color: #6b7280;
            font-weight: 400;
            margin-bottom: 24px;
            font-size: 1.3rem;
        }
        p {
            color: #6b7280;
            max-width: 420px;
            margin: 0 auto 32px;
            line-height: 1.6;
        }
        .btn {
            display: inline-block;
            padding: 12px 28px;
            border-radius: 40px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        .btn-primary {
            background: #c0392b;
            color: white;
        }
        .btn-primary:hover {
            background: #a93226;
            transform: translateY(-2px);
        }
        .alert-error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
            padding: 12px;
            border-radius: 8px;
            text-align: left;
            max-width: 600px;
            margin: 0 auto 24px;
            font-size: 0.82rem;
            font-family: monospace;
            overflow-x: auto;
        }
    </style>
</head>
<body>
<div class="error-container">
    <div>
        <div class="error-icon">500</div>
        <h1>500</h1>
        <h2>Something went wrong backstage</h2>
        <p>Our team is working on it. Please try again in a moment.</p>

        <%-- Show error details only in development (remove for production) --%>
        <c:if test="${not empty pageContext.exception}">
            <div class="alert-error">
                <strong>Error Details:</strong><br>
                    ${pageContext.exception.message}
            </div>
        </c:if>

        <div>
            <a href="${pageContext.request.contextPath}/" class="btn btn-primary">Go Home</a>
        </div>
    </div>
</div>
</body>
</html>
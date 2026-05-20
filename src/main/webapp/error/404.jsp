<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Page Not Found - Unique Fancy</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            margin: 0;
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
        .error-content {
            max-width: 500px;
        }
        .error-icon {
            font-size: 5rem;
            margin-bottom: 16px;
            opacity: 0.5;
        }
        h1 {
            font-size: 6rem;
            color: #1a1a2e;
            font-family: 'Playfair Display', serif;
            margin-bottom: 8px;
        }
        h2 {
            color: #6b7280;
            font-weight: 400;
            margin-bottom: 24px;
            font-size: 1.5rem;
        }
        p {
            color: #6b7280;
            margin-bottom: 32px;
            line-height: 1.6;
        }
        .btn {
            display: inline-block;
            padding: 12px 28px;
            margin: 8px;
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
        .btn-outline {
            border: 2px solid #1a1a2e;
            color: #1a1a2e;
            background: transparent;
        }
        .btn-outline:hover {
            background: #1a1a2e;
            color: white;
            transform: translateY(-2px);
        }
    </style>
</head>
<body>
<div class="error-container">
    <div class="error-content">
        <div class="error-icon">404</div>
        <h1>404</h1>
        <h2>Page Not Found</h2>
        <p>Oops! The page you're looking for seems to have gone out of style. It might have been moved or doesn't exist.</p>
        <div>
            <a href="${pageContext.request.contextPath}/" class="btn btn-primary">Go Home</a>
            <a href="${pageContext.request.contextPath}/products" class="btn btn-outline">Browse Shop</a>
        </div>
    </div>
</div>
</body>
</html>
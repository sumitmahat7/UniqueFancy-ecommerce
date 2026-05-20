<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Unique Fancy</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/responsive.css">
    <style>
        /* Login Container */
        .login-container {
            min-height: 80vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, var(--cream) 0%, white 100%);
            padding: 40px 20px;
        }

        /* Two Column Layout */
        .login-wrapper {
            display: flex;
            gap: 30px;
            max-width: 1000px;
            width: 100%;
            margin: 0 auto;
            flex-wrap: wrap;
        }

        /* Login Card */
        .login-card {
            flex: 1.5;
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.1);
            padding: 40px;
            transition: transform 0.3s;
        }

        .login-card:hover {
            transform: translateY(-5px);
        }

        /* Demo Card */
        .demo-card {
            flex: 1;
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.1);
            padding: 40px;
            transition: transform 0.3s;
            align-self: center;
        }

        .demo-card:hover {
            transform: translateY(-5px);
        }

        .login-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .login-header h2 {
            font-size: 1.8rem;
            margin-bottom: 8px;
            color: #1a1a2e;
        }

        .login-header p {
            color: #666;
            font-size: 0.9rem;
        }

        .login-icon {
            font-size: 3rem;
            margin-bottom: 15px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-label {
            display: block;
            font-weight: 600;
            margin-bottom: 8px;
            color: #333;
        }

        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #eee;
            border-radius: 10px;
            font-size: 0.95rem;
            transition: all 0.3s;
        }

        .form-control:focus {
            outline: none;
            border-color: #e8c547;
            box-shadow: 0 0 0 3px rgba(232,197,71,0.1);
        }

        .checkbox-group {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }

        .checkbox-label {
            display: flex;
            align-items: center;
            gap: 8px;
            cursor: pointer;
        }

        .checkbox-label input {
            width: 16px;
            height: 16px;
            cursor: pointer;
        }

        .forgot-link {
            color: #c0392b;
            text-decoration: none;
            font-size: 0.85rem;
            transition: color 0.3s;
            cursor: pointer;
        }

        .forgot-link:hover {
            color: #a93226;
            text-decoration: underline;
        }

        .btn-login {
            width: 100%;
            background: #e8c547;
            color: #1a1a2e;
            padding: 12px;
            border: none;
            border-radius: 40px;
            font-size: 1rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s;
        }

        .btn-login:hover {
            background: #d4b13e;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        .register-link {
            text-align: center;
            margin-top: 25px;
            padding-top: 20px;
            border-top: 1px solid #eee;
        }

        .register-link p {
            color: #666;
            font-size: 0.9rem;
        }

        .register-link a {
            color: #c0392b;
            text-decoration: none;
            font-weight: 600;
        }

        .register-link a:hover {
            text-decoration: underline;
        }

        .demo-title {
            text-align: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 2px solid #e8c547;
            display: inline-block;
            width: 100%;
        }

        .demo-title h3 {
            color: #1a1a2e;
            font-size: 1.3rem;
        }

        .demo-account {
            background: #f8f9fa;
            border-radius: 12px;
            padding: 15px;
            margin-bottom: 15px;
            border-left: 4px solid #e8c547;
        }

        .demo-account strong {
            color: #1a1a2e;
            display: block;
            margin-bottom: 8px;
            font-size: 1rem;
        }

        .demo-account p {
            margin: 5px 0;
            color: #666;
            font-size: 0.85rem;
            word-break: break-all;
        }

        .demo-account .role-badge {
            display: inline-block;
            background: #e8c547;
            color: #1a1a2e;
            padding: 2px 10px;
            border-radius: 20px;
            font-size: 0.7rem;
            font-weight: 600;
            margin-top: 5px;
        }

        .demo-note {
            text-align: center;
            font-size: 0.75rem;
            color: #999;
            margin-top: 15px;
            padding-top: 10px;
            border-top: 1px solid #eee;
        }

        @media (max-width: 768px) {
            .login-wrapper {
                flex-direction: column;
            }
            .login-card, .demo-card {
                padding: 25px;
            }
        }
    </style>
</head>
<body>
<%@ include file="../../../includes/header.jsp" %>
<%@ include file="../../../includes/flash-message.jsp" %>


<div class="login-container">
    <div class="login-wrapper">

        <!-- LOGIN SECTION -->
        <div class="login-card">
            <div class="login-header">
                <div class="login-icon">Unique Fancy</div>
                <h2>Welcome Back</h2>
                <p>Sign in to continue shopping</p>
            </div>

            <form action="${pageContext.request.contextPath}/login" method="post">
                <div class="form-group">
                    <label class="form-label">Email Address</label>
                    <input type="email" name="email" value="${cookie.rememberedEmail.value}" class="form-control" placeholder="you@example.com" required>
                </div>

                <div class="form-group">
                    <label class="form-label">Password</label>
                    <input type="password" name="password" class="form-control" placeholder="Enter your password" required>
                </div>

                <div class="checkbox-group">
                    <label class="checkbox-label">
                        <input type="checkbox" name="rememberMe"> Remember me
                    </label>
                    <a href="javascript:void(0)" onclick="alert('Please contact admin to reset your password. Contact: admin@uniquefancy.com')" class="forgot-link">Forgot Password?</a>
                </div>

                <button type="submit" class="btn-login">Sign In</button>
            </form>

            <div class="register-link">
                <p>Don't have an account? <a href="${pageContext.request.contextPath}/register">Create Account</a></p>
            </div>
        </div>

        <!-- DEMO ACCOUNTS SECTION -->
        <div class="demo-card">
            <div class="demo-title">
                <h3>Demo Accounts</h3>
            </div>

            <div class="demo-account">
                <strong>Admin Account</strong>
                <p><strong>Email:</strong> admin@uniquefancy.com</p>
                <p><strong>Password:</strong> admin123</p>
                <span class="role-badge">Administrator</span>
            </div>

            <div class="demo-account">
                <strong>User Account</strong>
                <p><strong>Email:</strong> gc@gmail.com</p>
                <p><strong>Password:</strong> Sumit123</p>
                <span class="role-badge">Customer</span>
            </div>

            <div class="demo-note">
                <p>Use these credentials to test the application</p>
            </div>
        </div>

    </div>
</div>

<%@ include file="../../../includes/footer.jsp" %>
</body>
</html>
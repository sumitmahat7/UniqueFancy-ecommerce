<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    com.uniquefancy.util.FlashMessageUtil.getFlashMessages(request);
%>

<style>
    .flash-message-container {
        position: fixed;
        top: 80px;
        left: 50%;
        transform: translateX(-50%);
        z-index: 9999;
        min-width: 300px;
        max-width: 500px;
        text-align: center;
        box-shadow: 0 4px 15px rgba(0,0,0,0.15);
        border-radius: 8px;
        padding: 12px 24px;
        font-size: 0.95rem;
        font-weight: 500;
        animation: slideDown 0.3s ease-out;
    }

    @keyframes slideDown {
        from {
            transform: translateX(-50%) translateY(-20px);
            opacity: 0;
        }
        to {
            transform: translateX(-50%) translateY(0);
            opacity: 1;
        }
    }

    .alert-success {
        background: #d4edda;
        color: #155724;
        border: 1px solid #c3e6cb;
    }

    .alert-error {
        background: #f8d7da;
        color: #721c24;
        border: 1px solid #f5c6cb;
    }

    .alert-info {
        background: #d1ecf1;
        color: #0c5460;
        border: 1px solid #bee5eb;
    }
</style>

<c:if test="${not empty successMsg}">
    <div class="flash-message-container alert-success" id="flashMessage">${successMsg}</div>
</c:if>

<c:if test="${not empty errorMsg}">
    <div class="flash-message-container alert-error" id="flashMessage">${errorMsg}</div>
</c:if>

<c:if test="${not empty infoMsg}">
    <div class="flash-message-container alert-info" id="flashMessage">${infoMsg}</div>
</c:if>

<script>
    // Remove flash message after 15 seconds
    var flashMessage = document.getElementById('flashMessage');
    if (flashMessage) {
        setTimeout(function() {
            flashMessage.style.transition = 'opacity 0.5s';
            flashMessage.style.opacity = '0';
            setTimeout(function() {
                flashMessage.remove();
            }, 500);
        }, 15000);
    }
</script>
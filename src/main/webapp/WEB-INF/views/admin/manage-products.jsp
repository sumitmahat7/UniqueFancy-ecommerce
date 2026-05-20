<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Products - Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/responsive.css">
    <style>
        .action-buttons {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
        }
        .btn-view {
            background: #3498db;
            color: white;
            padding: 6px 12px;
            border-radius: 6px;
            text-decoration: none;
            font-size: 12px;
            transition: all 0.3s;
            display: inline-block;
        }
        .btn-view:hover {
            background: #2980b9;
            transform: translateY(-2px);
        }
        .btn-edit {
            background: #f39c12;
            color: white;
            padding: 6px 12px;
            border-radius: 6px;
            text-decoration: none;
            font-size: 12px;
            transition: all 0.3s;
            display: inline-block;
        }
        .btn-edit:hover {
            background: #e67e22;
            transform: translateY(-2px);
        }
        .btn-delete {
            background: #e74c3c;
            color: white;
            padding: 6px 12px;
            border-radius: 6px;
            border: none;
            cursor: pointer;
            font-size: 12px;
            transition: all 0.3s;
        }
        .btn-delete:hover {
            background: #c0392b;
            transform: translateY(-2px);
        }
        .product-image-thumb {
            width: 60px;
            height: 60px;
            background: #f5f5f5;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }
        .thumb-img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .no-image {
            font-size: 10px;
            color: #999;
            text-align: center;
        }
        .product-name {
            font-weight: 600;
            margin-bottom: 4px;
        }
        .product-desc {
            font-size: 12px;
            color: #666;
            max-width: 200px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
        .price-amount {
            font-weight: 700;
            color: #c0392b;
        }
        .stock-out {
            color: #e74c3c;
            font-weight: 700;
        }
        .stock-low {
            color: #f39c12;
            font-weight: 700;
        }
        .stock-ok {
            color: #27ae60;
            font-weight: 700;
        }
        .admin-topbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .admin-page-title {
            font-size: 1.5rem;
            font-weight: 700;
        }
        .btn-primary {
            background: #e8c547;
            color: #1a1a2e;
            padding: 10px 20px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s;
            display: inline-block;
        }
        .btn-primary:hover {
            background: #d4b13e;
            transform: translateY(-2px);
        }
        .table-wrapper {
            overflow-x: auto;
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        .data-table {
            width: 100%;
            border-collapse: collapse;
            min-width: 800px;
        }
        .data-table th {
            background: #1a1a2e;
            color: white;
            padding: 12px;
            text-align: left;
        }
        .data-table td {
            padding: 12px;
            border-bottom: 1px solid #eee;
            vertical-align: middle;
        }
        .data-table tr:hover {
            background: #f9f5f0;
        }
        .empty-row {
            text-align: center;
            padding: 40px;
            color: #999;
        }
    </style>
</head>
<body>
<div class="admin-wrapper">
    <%@ include file="sidebar.jsp" %>
    <main class="admin-content">
        <%@ include file="../../../includes/flash-message.jsp" %>

        <div class="admin-topbar">
            <div class="admin-page-title">Manage Products</div>
            <a href="${pageContext.request.contextPath}/admin/add-product" class="btn-primary">Add New Product</a>
        </div>

        <div class="table-wrapper">
            <table class="data-table">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Image</th>
                    <th>Product Name</th>
                    <th>Category</th>
                    <th>Price</th>
                    <th>Stock</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="product" items="${products}">
                    <tr>
                        <td>${product.productId}</td>
                        <td>
                            <div class="product-image-thumb">
                                <c:set var="category" value="${fn:toLowerCase(product.categoryName)}" />
                                <c:set var="imageNum" value="${(product.productId - 1) % 6 + 1}" />
                                <img src="${pageContext.request.contextPath}/images/products/${category}${imageNum}.jpg"
                                     alt="${product.productName}"
                                     class="thumb-img"
                                     onerror="this.src='${pageContext.request.contextPath}/images/placeholder.jpg'">
                            </div>
                        </td>
                        <td>
                            <div class="product-name">${product.productName}</div>
                            <div class="product-desc">${product.description}</div>
                        </td>
                        <td>${product.categoryName}</td>
                        <td class="price-amount">Rs. <fmt:formatNumber value="${product.price}" pattern="#,##0.00"/></td>
                        <td>
                            <c:choose>
                                <c:when test="${product.stock == 0}">
                                    <span class="stock-out">Out of Stock</span>
                                </c:when>
                                <c:when test="${product.stock < 10}">
                                    <span class="stock-low">Low Stock (${product.stock})</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="stock-ok">${product.stock}</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <div class="action-buttons">
                                <a href="${pageContext.request.contextPath}/product-details?id=${product.productId}"
                                   class="btn-view" target="_blank">View</a>
                                <a href="${pageContext.request.contextPath}/admin/edit-product?id=${product.productId}"
                                   class="btn-edit">Edit</a>
                                <form method="post" action="${pageContext.request.contextPath}/admin/delete-product"
                                      style="display:inline;">
                                    <input type="hidden" name="productId" value="${product.productId}">
                                    <button type="submit" class="btn-delete"
                                            onclick="return confirm('Delete this product? This action cannot be undone.')">
                                        Delete
                                    </button>
                                </form>
                            </div>
                        </td>
                    </tr>
                </c:forEach>

                <c:if test="${empty products}">
                    <tr>
                        <td colspan="7" class="empty-row">No products found. Click Add New Product to create one.</td>
                    </tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </main>
</div>
</body>
</html>
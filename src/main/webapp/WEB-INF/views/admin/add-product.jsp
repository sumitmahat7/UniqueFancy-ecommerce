<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Product - Unique Fancy Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/responsive.css">
</head>
<body>
<div class="admin-wrapper">
    <%@ include file="sidebar.jsp" %>
    <main class="admin-content">
        <!-- Flash messages -->
        <%@ include file="../../../includes/flash-message.jsp" %>

        <div class="admin-topbar">
            <div class="admin-page-title">Add New Product</div>
            <a href="${pageContext.request.contextPath}/admin/manage-products" class="btn btn-outline">Back to Products</a>
        </div>

        <div style="background:white; border-radius:12px; box-shadow:var(--shadow); padding:32px;">
            <form method="post" action="${pageContext.request.contextPath}/admin/add-product">
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
                    <div class="form-group">
                        <label class="form-label">Product Name *</label>
                        <input type="text" name="productName" class="form-control"
                               placeholder="e.g. Classic Linen Kurta" maxlength="100" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Category *</label>
                        <select name="categoryId" class="form-control" required>
                            <option value="">-- Select Category --</option>
                            <c:forEach var="cat" items="${categories}">
                                <option value="${cat.categoryId}">${cat.categoryName}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label">Description</label>
                    <textarea name="description" class="form-control" rows="4"
                              placeholder="Describe the product including materials, fit, sustainability info"></textarea>
                </div>

                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
                    <div class="form-group">
                        <label class="form-label">Price (Rupees) *</label>
                        <input type="number" name="price" class="form-control"
                               placeholder="e.g. 1299.00" step="0.01" min="0.01" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Total Stock *</label>
                        <input type="number" name="stock" class="form-control"
                               placeholder="e.g. 100" min="0" required>
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label">Image Filename</label>
                    <input type="text" name="image" class="form-control"
                           placeholder="e.g. kurta.jpg">
                    <div class="form-hint">Upload image to images/products/ folder, then enter filename here.</div>
                </div>

                <!-- Size-wise Stock -->
                <div style="margin-bottom:24px;">
                    <div style="font-weight:700; margin-bottom:12px;">Size-wise Stock</div>
                    <div style="display:grid; grid-template-columns:repeat(auto-fill,minmax(100px,1fr)); gap:12px;">
                        <c:forEach var="sz" items="${allSizes}">
                            <div style="background:var(--cream); border-radius:8px; padding:12px; text-align:center;">
                                <div style="font-weight:700; margin-bottom:6px;">${sz}</div>
                                <input type="number" name="size_${sz}" class="form-control"
                                       placeholder="0" min="0" value="0"
                                       style="text-align:center; padding:6px;">
                            </div>
                        </c:forEach>
                    </div>
                    <div class="form-hint">Enter stock for each size. Leave 0 if size not available.</div>
                </div>

                <div style="display:flex; gap:12px;">
                    <button type="submit" class="btn btn-primary btn-lg">Add Product</button>
                    <a href="${pageContext.request.contextPath}/admin/manage-products" class="btn btn-outline btn-lg">Cancel</a>
                </div>
            </form>
        </div>
    </main>
</div>
</body>
</html>
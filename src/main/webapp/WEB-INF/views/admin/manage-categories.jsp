<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Categories - Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/responsive.css">
</head>
<body>
<div class="admin-wrapper">
    <%@ include file="sidebar.jsp" %>
    <main class="admin-content">
        <%@ include file="../../../includes/flash-message.jsp" %>

        <h1>Manage Categories</h1>

        <div style="display: flex; gap: 30px; flex-wrap: wrap;">
            <!-- Category List Table -->
            <div style="flex: 2; background: white; border-radius: 10px; padding: 20px;">
                <table style="width: 100%; border-collapse: collapse;">
                    <thead>
                    <tr style="background: #1a1a2e; color: white;">
                        <th style="padding: 10px;">ID</th>
                        <th style="padding: 10px;">Category Name</th>
                        <th style="padding: 10px;">Description</th>
                        <th style="padding: 10px;">Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="cat" items="${categories}">
                        <tr style="border-bottom: 1px solid #ddd;">
                            <td style="padding: 10px;">${cat.categoryId}</td>
                            <td style="padding: 10px; font-weight: bold;">${cat.categoryName}</td>
                            <td style="padding: 10px;">${cat.description}</td>
                            <td style="padding: 10px;">
                                <button onclick="editCategory(${cat.categoryId}, '${cat.categoryName}', '${cat.description}')"
                                        class="btn btn-sm btn-gold">Edit</button>
                                <form method="post" action="${pageContext.request.contextPath}/admin/delete-category" style="display: inline;">
                                    <input type="hidden" name="categoryId" value="${cat.categoryId}">
                                    <button type="submit" class="btn btn-sm btn-danger" onclick="return confirm('Delete this category?')">Delete</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty categories}">
                        <tr><td colspan="4" style="text-align: center; padding: 20px;">No categories found.}</td></tr>
                    </c:if>
                    </tbody>
                </table>
            </div>

            <!-- Add/Edit Category Form -->
            <div style="flex: 1; background: white; border-radius: 10px; padding: 20px;">
                <h3 id="formTitle">Add New Category</h3>

                <form method="post" id="categoryForm" action="${pageContext.request.contextPath}/admin/add-category">
                    <input type="hidden" name="categoryId" id="categoryId">

                    <div class="form-group">
                        <label>Category Name *</label>
                        <input type="text" name="categoryName" id="categoryName" class="form-control" required>
                    </div>

                    <div class="form-group">
                        <label>Description</label>
                        <textarea name="description" id="categoryDesc" class="form-control" rows="3"></textarea>
                    </div>

                    <button type="submit" class="btn btn-primary" id="submitBtn">Add Category</button>
                    <button type="button" onclick="resetForm()" class="btn btn-outline">Reset</button>
                </form>
            </div>
        </div>
    </main>
</div>

<%--<script>--%>
<%--    function editCategory(id, name, desc) {--%>
<%--        document.getElementById('formTitle').innerHTML = 'Edit Category';--%>
<%--        document.getElementById('categoryId').value = id;--%>
<%--        document.getElementById('categoryName').value = name;--%>
<%--        document.getElementById('categoryDesc').value = desc;--%>
<%--        document.getElementById('submitBtn').innerHTML = 'Update Category';--%>
<%--        document.getElementById('categoryForm').action = '${pageContext.request.contextPath}/admin/update-category';--%>
<%--    }--%>

<%--    function resetForm() {--%>
<%--        document.getElementById('formTitle').innerHTML = 'Add New Category';--%>
<%--        document.getElementById('categoryId').value = '';--%>
<%--        document.getElementById('categoryName').value = '';--%>
<%--        document.getElementById('categoryDesc').value = '';--%>
<%--        document.getElementById('submitBtn').innerHTML = 'Add Category';--%>
<%--        document.getElementById('categoryForm').action = '${pageContext.request.contextPath}/admin/add-category';--%>
<%--    }--%>
<%--</script>--%>
<script>
    function editCategory(id, name, desc) {
        document.getElementById('categoryId').value = id;
        document.getElementById('categoryName').value = name;
        document.getElementById('categoryDesc').value = desc;
        document.getElementById('categoryForm').action = '${pageContext.request.contextPath}/admin/update-category';
    }

    function resetForm() {
        document.getElementById('categoryId').value = '';
        document.getElementById('categoryName').value = '';
        document.getElementById('categoryDesc').value = '';
        document.getElementById('categoryForm').action = '${pageContext.request.contextPath}/admin/add-category';
    }
</script>
</body>
</html>
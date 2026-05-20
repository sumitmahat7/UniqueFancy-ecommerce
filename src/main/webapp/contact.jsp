<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact - Unique Fancy</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/responsive.css">
</head>
<body>
<%@ include file="includes/header.jsp" %>
<%@ include file="includes/flash-message.jsp" %>

<%
    // Check if form was submitted (demo mode)
    if ("true".equals(request.getParameter("demo"))) {
        String name = request.getParameter("name");
        com.uniquefancy.util.FlashMessageUtil.setInfo(request,
                "Thank you " + name + "! This is a demo. In production, your message would be sent to our team.");
        response.sendRedirect(request.getContextPath() + "/contact.jsp");
        return;
    }
%>

<div class="page-header">
    <div class="container">
        <div class="breadcrumb"><a href="${pageContext.request.contextPath}/index.jsp">Home</a> / Contact</div>
        <h1>Get in Touch</h1>
        <p class="lead">We would love to hear from you</p>
    </div>
</div>

<section class="section">
    <div class="container">
        <div class="contact-wrapper">
            <!-- Contact Form -->
            <div class="contact-form">
                <h3>Send Us a Message</h3>

                <form method="post" action="${pageContext.request.contextPath}/contact.jsp">
                    <div class="form-group">
                        <label>Your Name *</label>
                        <input type="text" name="name" class="form-control" required>
                    </div>

                    <div class="form-group">
                        <label>Email Address *</label>
                        <input type="email" name="email" class="form-control" required>
                    </div>

                    <div class="form-group">
                        <label>Subject *</label>
                        <select name="subject" class="form-control" required>
                            <option value="">Select a topic</option>
                            <option>Order inquiry</option>
                            <option>Product information</option>
                            <option>Returns and exchanges</option>
                            <option>Sustainability question</option>
                            <option>Other</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label>Message *</label>
                        <textarea name="message" class="form-control" rows="6" required></textarea>
                    </div>

                    <input type="hidden" name="demo" value="true">
                    <button type="submit" class="btn btn-primary">Send Message</button>
                </form>

            </div>

            <!-- Contact Information -->
            <div class="contact-info">
                <h3>Contact Information</h3>

                <div class="info-item">
                    <strong>ADDRESS</strong>
                    <p>Lakeside Road, Baidam</p>
                    <p>Pokhara-8, Gandaki Province</p>
                    <p>Nepal 33700</p>
                </div>

                <div class="info-item">
                    <strong>PHONE</strong>
                    <p>+977 61 000000</p>
                    <p>+977 9800000000 (WhatsApp)</p>
                </div>

                <div class="info-item">
                    <strong>EMAIL</strong>
                    <p>hello@uniquefancy.com</p>
                    <p>orders@uniquefancy.com</p>
                </div>

                <div class="info-item">
                    <strong>HOURS</strong>
                    <p>Sunday - Friday: 10:00 AM - 7:00 PM</p>
                    <p>Saturday: 10:00 AM - 5:00 PM</p>
                    <p>Public Holidays: Closed</p>
                </div>

                <div class="map-link">
                    <a href="https://maps.google.com/?q=Lakeside+Pokhara+Nepal" target="_blank">View on Google Maps </a>
                </div>
            </div>
        </div>
    </div>
</section>

<style>
    /* Your existing styles */
    .contact-wrapper {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 50px;
    }
    .contact-form, .contact-info {
        background: white;
        padding: 30px;
        border-radius: 12px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    }
    .contact-form h3, .contact-info h3 {
        margin-bottom: 25px;
        padding-bottom: 10px;
        border-bottom: 2px solid #e8c547;
        display: inline-block;
    }
    .form-group {
        margin-bottom: 20px;
    }
    .form-group label {
        display: block;
        margin-bottom: 8px;
        font-weight: 600;
    }
    .form-control {
        width: 100%;
        padding: 12px;
        border: 1px solid #ddd;
        border-radius: 8px;
        font-size: 14px;
    }
    .info-item {
        margin-bottom: 25px;
        padding-bottom: 20px;
        border-bottom: 1px solid #eee;
    }
    .info-item:last-child {
        border-bottom: none;
    }
    .info-item strong {
        display: block;
        color: #c0392b;
        margin-bottom: 10px;
        font-size: 0.85rem;
    }
    .info-item p {
        margin: 5px 0;
        color: #555;
    }
    .map-link {
        margin-top: 20px;
        text-align: center;
    }
    .map-link a {
        color: #c0392b;
        text-decoration: none;
    }
    @media (max-width: 768px) {
        .contact-wrapper {
            grid-template-columns: 1fr;
            gap: 30px;
        }
    }
</style>

<%@ include file="includes/footer.jsp" %>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - Unique Fancy</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/responsive.css">
</head>
<body>
<%@ include file="includes/header.jsp" %>
<%@ include file="includes/flash-message.jsp" %>

<div class="page-header">
    <div class="container">
        <div class="breadcrumb"><a href="${pageContext.request.contextPath}/">Home</a> / About</div>
        <h1>Our Story</h1>
        <p class="lead">Fashion that respects people and the planet</p>
    </div>
</div>

<!-- Mission -->
<section class="section">
    <div class="container">
        <div class="mission-grid">
            <div class="mission-text">
                <div class="section-tag">Our Mission</div>
                <h2>We Believe Fashion Should Be For Everyone</h2>
                <p>Unique Fancy was founded in Pokhara, Nepal in 2020 with a simple belief: that beautiful, well-made clothing should be accessible to every body type, every budget, and produced with respect for the people who make it.</p>
                <p>We work directly with artisan cooperatives across Nepal and India, paying fair wages and ensuring safe working conditions. Every fabric is chosen for its environmental impact - prioritising organic cotton, recycled fibres, and natural dyes.</p>
                <a href="${pageContext.request.contextPath}/products" class="btn btn-primary">Shop Our Collection</a>
            </div>
            <div class="stats-grid">
                <div class="stat-box">
                    <div class="stat-value">100%</div>
                    <div class="stat-label">Organic or Recycled Fabrics</div>
                </div>
                <div class="stat-box">
                    <div class="stat-value">200+</div>
                    <div class="stat-label">Artisan Partners</div>
                </div>
                <div class="stat-box">
                    <div class="stat-value">XXS-5XL</div>
                    <div class="stat-label">Full Size Range</div>
                </div>
                <div class="stat-box">
                    <div class="stat-value">0kg</div>
                    <div class="stat-label">Net Carbon Footprint</div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Values -->
<section class="section values-section">
    <div class="container">
        <div class="section-title">
            <h2>Our Core Values</h2>
            <div class="section-divider"></div>
        </div>
        <div class="values-grid">
            <div class="value-card">
                <div class="value-icon">S</div>
                <h4>Sustainability</h4>
                <p>Every garment is made from GOTS-certified organic or OEKO-TEX recycled materials. Our packaging is 100 percent compostable.</p>
            </div>
            <div class="value-card">
                <div class="value-icon">B</div>
                <h4>Body Positivity</h4>
                <p>We shoot our lookbooks on models of all sizes and do not retouch body shape. Beauty has no single form.</p>
            </div>
            <div class="value-card">
                <div class="value-icon">F</div>
                <h4>Fair Trade</h4>
                <p>We pay our artisan partners above minimum wage, provide health benefits, and publish our supply chain publicly.</p>
            </div>
            <div class="value-card">
                <div class="value-icon">T</div>
                <h4>Transparency</h4>
                <p>Full supply chain visibility - you can see the name of the artisan and co-op behind every garment we sell.</p>
            </div>
        </div>
    </div>
</section>

<!-- Size Inclusivity -->
<section class="section">
    <div class="container size-inclusivity">
        <h2>Our Size Inclusivity Commitment</h2>
        <p>We offer every product from XXS to 5XL at the same price. We will not charge more for larger sizes. Our designs are tested and modelled across the full size range before going to production. We believe the fashion industry's historic exclusion of larger bodies is harmful and we actively work against it.</p>
        <div class="size-badges">
            <span class="size-badge">XXS</span>
            <span class="size-badge">XS</span>
            <span class="size-badge">S</span>
            <span class="size-badge">M</span>
            <span class="size-badge">L</span>
            <span class="size-badge">XL</span>
            <span class="size-badge">XXL</span>
            <span class="size-badge">3XL</span>
            <span class="size-badge">4XL</span>
            <span class="size-badge">5XL</span>
        </div>
    </div>
</section>

<!-- Team -->
<section class="section team-section">
    <div class="container">
        <div class="section-title">
            <h2>Meet the Team</h2>
            <div class="section-divider"></div>
        </div>
        <div class="team-grid">
            <div class="team-card">
                <div class="team-avatar">S</div>
                <h4>Sumit Mahat</h4>
                <div class="team-role">Lead Developer</div>
                <p>Full-stack developer specializing in Java EE and e-commerce solutions.</p>
            </div>
            <div class="team-card">
                <div class="team-avatar">G</div>
                <h4>Gobin Chhantyal</h4>
                <div class="team-role">Backend Specialist</div>
                <p>Expert in database design, API development, and system architecture.</p>
            </div>
            <div class="team-card">
                <div class="team-avatar">S</div>
                <h4>Siddhartha Malla</h4>
                <div class="team-role">Frontend Developer</div>
                <p>Creates responsive, user-friendly interfaces with modern CSS and JavaScript.</p>
            </div>
            <div class="team-card">
                <div class="team-avatar">S</div>
                <h4>Saugat Poudel</h4>
                <div class="team-role">UI/UX Designer</div>
                <p>Designs intuitive and accessible interfaces for optimal user experience.</p>
            </div>
            <div class="team-card">
                <div class="team-avatar">S</div>
                <h4>Sakshyam Poudel</h4>
                <div class="team-role">QA Engineer</div>
                <p>Ensures quality, performance, and reliability through rigorous testing.</p>
            </div>
            <div class="team-card">
                <div class="team-avatar">P</div>
                <h4>Pratik Gurung</h4>
                <div class="team-role">DevOps Engineer</div>
                <p>Manages deployment, server configuration, and CI/CD pipelines.</p>
            </div>
        </div>
    </div>
</section>

<%@ include file="includes/footer.jsp" %>
</body>
</html>
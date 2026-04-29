<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.jobportal.model.Application" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Schedule Interview - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Public+Sans:wght@300;400;600;700&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --drdo-teal: #005a5a;
            --drdo-dark: #003d3d;
            --drdo-bg: #f8f9fa;
            --drdo-border: #dee2e6;
        }

        /* Prevent movement/shifting on cursor move */
        html, body {
            max-width: 100%;
            overflow-x: hidden;
            margin: 0;
            padding: 0;
            font-family: 'Public Sans', sans-serif;
            background-color: var(--drdo-bg);
            color: #333;
        }

        /* Navbar Styling */
        .navbar {
            background-color: #ffffff !important;
            border-bottom: 2px solid var(--drdo-teal);
            padding: 0.8rem 1rem;
            position: relative;
            z-index: 1000;
        }
        .navbar-brand {
            color: var(--drdo-teal) !important;
            font-weight: 700;
            text-transform: uppercase;
        }
        .nav-link {
            color: #555 !important;
            font-weight: 500;
            transition: color 0.2s ease;
        }
        .nav-link:hover {
            color: var(--drdo-teal) !important;
        }

        /* Card Styling - Fixed to prevent jitter */
        .card {
            border: 1px solid var(--drdo-border);
            border-radius: 4px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            background: #fff;
            transition: none; /* Keep layout static */
        }
        
        .info-bar {
            border-left: 5px solid var(--drdo-teal);
            background: #eef5f5;
        }

        /* Stable Buttons */
        .btn-primary { 
            background-color: var(--drdo-teal); 
            border: none; 
            transition: background-color 0.2s ease; 
        }
        .btn-primary:hover { 
            background-color: var(--drdo-dark);
            transform: none; /* Removed transform to keep static */
        }
        .btn-primary:active { 
            background-color: #002525;
        }

        /* Form Controls Stability */
        .form-control:focus, .form-select:focus {
            border-color: var(--drdo-teal);
            box-shadow: 0 0 0 0.25rem rgba(0, 90, 90, 0.1);
        }

        footer {
            background-color: #ffffff;
            border-top: 1px solid var(--drdo-border);
            padding: 25px 0;
            color: #666;
            margin-top: 50px;
        }

        /* Fade in for smooth loading without displacement */
        .animate-fade-in {
            animation: fadeIn 0.5s ease-in forwards;
        }
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg">
    <div class="container-fluid">
        <a class="navbar-brand" href="admin-dashboard">
            <i class="bi bi-shield-lock-fill"></i> VisionRecruit <span class="badge bg-danger ms-2">ADMIN</span>
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navMenu">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navMenu">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="admin-dashboard">Dashboard</a></li>
                <li class="nav-item"><a class="nav-link" href="applicant-list">Applicants</a></li>
            </ul>
            <ul class="navbar-nav">
                <li class="nav-item"><a class="nav-link text-danger fw-bold" href="logout">LOGOUT</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-5 animate-fade-in">

    <c:if test="${not empty sessionScope.successMsg}">
        <div class="alert alert-success alert-dismissible fade show border-0 shadow-sm" role="alert">
            <i class="bi bi-check-circle-fill me-2"></i> ${sessionScope.successMsg}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <c:remove var="successMsg" scope="session"/>
    </c:if>

    <c:if test="${not empty sessionScope.errorMsg}">
        <div class="alert alert-danger alert-dismissible fade show border-0 shadow-sm" role="alert">
            <i class="bi bi-exclamation-triangle-fill me-2"></i> ${sessionScope.errorMsg}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <c:remove var="errorMsg" scope="session"/>
    </c:if>

    <% Application app = (Application) request.getAttribute("application"); %>
    <% if (app != null) { %>
        <div class="card info-bar p-3 mb-4">
            <h5 class="mb-1">Scheduling for: <strong><%= app.getApplicantName() %></strong></h5>
            <p class="text-muted mb-0">Role: <%= app.getJobTitle() %> | Institution: <%= app.getCompany() %></p>
        </div>

        <div class="card p-4">
            <form action="schedule-interview" method="POST">
                <input type="hidden" name="applicationId" value="<%= app.getId() %>">
                <div class="row g-4">
                    <div class="col-md-6">
                        <label class="form-label fw-bold small text-uppercase">Interview Date</label>
                        <input type="date" name="interviewDate" id="iDate" class="form-control" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-bold small text-uppercase">Interview Time</label>
                        <input type="time" name="interviewTime" class="form-control" required>
                    </div>
                    <div class="col-md-12">
                        <label class="form-label fw-bold small text-uppercase">Interview Mode</label>
                        <select name="mode" class="form-select" id="mode" onchange="updateFields()">
                            <option value="Online">Online / Video Call</option>
                            <option value="Offline">In-Person / Office</option>
                        </select>
                    </div>
                    <div class="col-md-12" id="linkGroup">
                        <label class="form-label fw-bold small text-uppercase">Meeting Link</label>
                        <input type="url" name="meetingLink" class="form-control" placeholder="https://meet.google.com/...">
                    </div>
                    <div class="col-md-12" id="locGroup" style="display:none;">
                        <label class="form-label fw-bold small text-uppercase">Location Address</label>
                        <input type="text" name="location" class="form-control" placeholder="Office Floor/Room No...">
                    </div>
                </div>
                <button type="submit" class="btn btn-primary mt-4 w-100 py-3 fw-bold">
                    <i class="bi bi-calendar-check me-2"></i> CONFIRM INTERVIEW
                </button>
            </form>
        </div>
    <% } else { %>
        <div class="card p-5 text-center">
            <i class="bi bi-person-exclamation text-muted" style="font-size: 3rem;"></i>
            <h4 class="mt-3">No Application Selected</h4>
            <p class="text-muted">Please select an applicant from the registry to proceed with scheduling.</p>
            <div class="mt-3">
                <a href="applicant-list" class="btn btn-primary px-4">Go to Applicants</a>
            </div>
        </div>
    <% } %>
</div>

<footer class="footer text-center">
    <div class="container">
        <p class="mb-0">VisionRecruit Scheduling System &copy; 2026. Built for Efficiency.</p>
    </div>
</footer>

<script>
    function updateFields() {
        let mode = document.getElementById('mode').value;
        document.getElementById('linkGroup').style.display = mode === 'Online' ? 'block' : 'none';
        document.getElementById('locGroup').style.display = mode === 'Offline' ? 'block' : 'none';
    }
    document.addEventListener('DOMContentLoaded', () => {
        const today = new Date().toISOString().split('T')[0];
        document.getElementById('iDate').setAttribute('min', today);
    });
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
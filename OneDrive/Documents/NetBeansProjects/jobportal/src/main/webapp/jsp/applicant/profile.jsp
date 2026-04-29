<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.jobportal.model.Applicant" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile - VisionRecruit</title>
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

        /* Static Layout Lock: Prevents movement/shifting on cursor move */
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
        }
        .nav-link:hover, .nav-link.active {
            color: var(--drdo-teal) !important;
        }

        /* Static Header Area */
        .page-header {
            background: linear-gradient(135deg, var(--drdo-teal) 0%, var(--drdo-dark) 100%);
            color: white;
            padding: 40px 0;
            margin-bottom: 30px;
            text-align: left;
        }

        /* Card Styling - Fixed to prevent jitter */
        .card {
            border: 1px solid var(--drdo-border);
            border-top: 4px solid var(--drdo-teal);
            border-radius: 4px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            background: #fff;
            transition: none; /* Keep layout static */
        }

        .form-label {
            font-size: 0.82rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            color: #444;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--drdo-teal);
            box-shadow: 0 0 0 0.25rem rgba(0, 90, 90, 0.1);
        }

        /* Stable Buttons */
        .btn-primary {
            background-color: var(--drdo-teal);
            border-color: var(--drdo-teal);
            font-weight: 600;
            padding: 12px 30px;
            transition: background-color 0.2s ease;
        }
        .btn-primary:hover {
            background-color: var(--drdo-dark);
            border-color: var(--drdo-dark);
            transform: none; /* Removed movement jitter */
        }

        footer {
            background-color: #ffffff;
            border-top: 1px solid var(--drdo-border);
            padding: 25px 0;
            color: #666;
            margin-top: 50px;
        }

        /* Fade-in for smooth loading */
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
    <div class="container">
        <a class="navbar-brand" href="applicant-dashboard">
            <i class="bi bi-shield-check-fill"></i> VisionRecruit
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#profileNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="profileNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="applicant-dashboard">Dashboard</a></li>
                <li class="nav-item"><a class="nav-link active" href="profile">Profile</a></li>
                <li class="nav-item"><a class="nav-link" href="jobs">Find Jobs</a></li>
                <li class="nav-item"><a class="nav-link" href="upload-document">Documents</a></li>
            </ul>
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link text-danger fw-bold" href="logout">LOGOUT</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="page-header">
    <div class="container animate-fade-in">
        <h3 class="fw-bold mb-0"><i class="bi bi-person-badge-fill me-2"></i> Candidate Bio-Data</h3>
        <p class="opacity-75 mb-0">Ensure your profile information matches your official documents for automated verification.</p>
    </div>
</div>

<div class="container animate-fade-in">
    <% if(request.getAttribute("success") != null) { %>
        <div class="alert alert-success border-0 shadow-sm mb-4"><i class="bi bi-check-circle-fill me-2"></i> <%= request.getAttribute("success") %></div>
    <% } %>
    <% if(request.getAttribute("error") != null) { %>
        <div class="alert alert-danger border-0 shadow-sm mb-4"><i class="bi bi-exclamation-triangle-fill me-2"></i> <%= request.getAttribute("error") %></div>
    <% } %>

    <% Applicant applicant = (Applicant) request.getAttribute("applicant"); %>
    <div class="card p-4 mb-5">
        <form action="profile" method="POST">
            <div class="row g-4">
                <div class="col-md-6">
                    <label class="form-label">Full Name (As per Matriculation) *</label>
                    <input type="text" name="fullName" class="form-control" value="<%= applicant != null ? applicant.getFullName() : "" %>" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Father's Name</label>
                    <input type="text" name="fatherName" class="form-control" value="<%= applicant != null && applicant.getFatherName() != null ? applicant.getFatherName() : "" %>">
                </div>
                <div class="col-md-6">
                    <label class="form-label">Date of Birth</label>
                    <input type="date" name="dob" class="form-control" value="<%= applicant != null && applicant.getDob() != null ? applicant.getDob() : "" %>">
                </div>
                <div class="col-md-6">
                    <label class="form-label">Highest Qualification *</label>
                    <input type="text" name="qualification" class="form-control" placeholder="e.g. M.Tech in Electronics" value="<%= applicant != null && applicant.getQualification() != null ? applicant.getQualification() : "" %>" required>
                </div>

                <div class="col-md-4">
                    <label class="form-label">10th Percentage *</label>
                    <input type="text" name="tenthPercentage" class="form-control" placeholder="e.g. 90%" required>
                </div>
                <div class="col-md-4">
                    <label class="form-label">12th Percentage *</label>
                    <input type="text" name="twelfthPercentage" class="form-control" placeholder="e.g. 88%" required>
                </div>
                <div class="col-md-4">
                    <label class="form-label">Graduation CGPA *</label>
                    <input type="text" name="cgpa" class="form-control" placeholder="Out of 10.0" required>
                </div>

                <div class="col-md-12">
                    <label class="form-label">Key Skills / Technical Competencies *</label>
                    <input type="text" name="skills" class="form-control" placeholder="e.g. C++, Embedded Systems, Python" value="<%= applicant != null && applicant.getSkills() != null ? applicant.getSkills() : "" %>" required>
                </div>
                
                <div class="col-md-6">
                    <label class="form-label">Post-Qualification Experience (Years)</label>
                    <input type="number" name="experience" class="form-control" min="0" value="<%= applicant != null ? applicant.getExperience() : 0 %>">
                </div>
                <div class="col-md-6">
                    <label class="form-label">Social Category</label>
                    <select name="category" class="form-select">
                        <option value="General" <%= applicant != null && "General".equals(applicant.getCategory()) ? "selected" : "" %>>General / UR</option>
                        <option value="SC" <%= applicant != null && "SC".equals(applicant.getCategory()) ? "selected" : "" %>>Scheduled Caste (SC)</option>
                        <option value="ST" <%= applicant != null && "ST".equals(applicant.getCategory()) ? "selected" : "" %>>Scheduled Tribe (ST)</option>
                        <option value="OBC" <%= applicant != null && "OBC".equals(applicant.getCategory()) ? "selected" : "" %>>Other Backward Class (OBC)</option>
                        <option value="EWS" <%= applicant != null && "EWS".equals(applicant.getCategory()) ? "selected" : "" %>>Economically Weaker Section (EWS)</option>
                        <option value="PwD" <%= applicant != null && "PwD".equals(applicant.getCategory()) ? "selected" : "" %>>Person with Disability (PwD)</option>
                    </select>
                </div>
            </div>
            
            <div class="mt-4 pt-3 border-top">
                <button type="submit" class="btn btn-primary">
                    <i class="bi bi-save2-fill me-2"></i> UPDATE OFFICIAL PROFILE
                </button>
            </div>
        </form>
    </div>
</div>

<footer class="footer text-center">
    <div class="container">
        <p class="mb-0 small text-muted">VisionRecruit Recruitment Division &copy; 2026. Integrity First.</p>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
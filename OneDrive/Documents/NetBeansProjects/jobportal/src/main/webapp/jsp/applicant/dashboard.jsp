<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.jobportal.model.Applicant" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Applicant Dashboard - Smart Job Portal</title>
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

        /* Static Layout Lock: Prevents shifting and horizontal sway */
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

        /* Stat Card Styling - Removed translateY for stability */
        .stat-card {
            background: #fff;
            border: 1px solid var(--drdo-border);
            border-top: 4px solid var(--drdo-teal);
            border-radius: 4px;
            padding: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            position: relative;
            overflow: hidden;
            display: block;
            text-decoration: none;
            transition: box-shadow 0.2s ease;
        }
        .stat-card:hover { 
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        .stat-icon { 
            font-size: 2.5rem; 
            color: var(--drdo-teal); 
            opacity: 0.15; 
            position: absolute;
            right: 15px;
            bottom: 10px;
        }
        .stat-number { font-size: 2rem; font-weight: 700; color: var(--drdo-dark); }
        .stat-label { font-size: 0.85rem; color: #666; text-transform: uppercase; letter-spacing: 0.5px; font-weight: 600; }

        /* Card & Content Stability */
        .card {
            border: 1px solid var(--drdo-border);
            border-radius: 4px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            background: #fff;
            transition: none;
        }
        
        .btn-outline-primary { 
            color: var(--drdo-teal); 
            border-color: var(--drdo-teal); 
            transition: background-color 0.2s ease, color 0.2s ease;
        }
        .btn-outline-primary:hover { 
            background-color: var(--drdo-teal); 
            color: #fff;
            transform: none; 
        }

        footer {
            background-color: #ffffff;
            border-top: 1px solid var(--drdo-border);
            padding: 25px 0;
            color: #666;
            margin-top: 50px;
        }

        /* Fade-in for smooth loading without displacement */
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
        
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#applicantMainPageNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="applicantMainPageNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link active" href="applicant-dashboard"><i class="bi bi-speedometer2 me-1"></i> Dashboard</a></li>
                <li class="nav-item"><a class="nav-link" href="profile"><i class="bi bi-person me-1"></i> Profile</a></li>
                <li class="nav-item"><a class="nav-link" href="jobs"><i class="bi bi-search me-1"></i> Find Jobs</a></li>
                <li class="nav-item"><a class="nav-link" href="apply-job"><i class="bi bi-file-earmark-text me-1"></i> My Applications</a></li>
                <li class="nav-item"><a class="nav-link" href="upload-document"><i class="bi bi-cloud-upload me-1"></i> Documents</a></li>
                <li class="nav-item"><a class="nav-link" href="verification"><i class="bi bi-shield-check me-1"></i> Verification</a></li>
                <li class="nav-item"><a class="nav-link" href="interview-status"><i class="bi bi-calendar-check me-1"></i> Interviews</a></li>
            </ul>
            
            <ul class="navbar-nav align-items-center">
                <li class="nav-item">
                    <span class="nav-link text-dark fw-bold small">
                        <i class="bi bi-person-circle me-1"></i> <%= session.getAttribute("userName") %>
                    </span>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-danger fw-bold ms-lg-3" href="logout">
                        <i class="bi bi-box-arrow-right me-1"></i> LOGOUT
                    </a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="page-header">
    <div class="container animate-fade-in">
        <h3 class="fw-bold mb-0">Applicant Control Center</h3>
        <p class="opacity-75 mb-0">Welcome back, <%= session.getAttribute("userName") %>. Manage your career opportunities here.</p>
    </div>
</div>

<div class="container py-2 animate-fade-in">
    <% Boolean hasProfile = (Boolean) request.getAttribute("hasProfile"); %>
    <% if (hasProfile == null || !hasProfile) { %>
        <div class="alert alert-warning border-0 shadow-sm">
            <i class="bi bi-exclamation-triangle-fill me-2"></i> Action Required: Please <a href="profile" class="alert-link">complete your candidate profile</a> to unlock job application features.
        </div>
    <% } else { %>
        <div class="row g-4 mb-5">
            <div class="col-md-4">
                <a href="apply-job" class="stat-card">
                    <div class="stat-number"><%= request.getAttribute("applicationCount") %></div>
                    <div class="stat-label">Total Applications</div>
                    <i class="bi bi-file-earmark-text stat-icon"></i>
                </a>
            </div>
            
            <div class="col-md-4">
                <a href="verification" class="stat-card">
                    <div class="stat-number"><%= request.getAttribute("documentCount") %></div>
                    <div class="stat-label">Verified Documents</div>
                    <i class="bi bi-folder-check stat-icon"></i>
                </a>
            </div>
            
            <div class="col-md-4">
                <a href="interview-status" class="stat-card">
                    <div class="stat-number"><%= request.getAttribute("interviewCount") %></div>
                    <div class="stat-label">Scheduled Interviews</div>
                    <i class="bi bi-calendar-event stat-icon"></i>
                </a>
            </div>
        </div>

        <div class="row g-4">
            <div class="col-md-6">
                <div class="card p-4 h-100">
                    <h5 class="fw-bold mb-4" style="color: var(--drdo-teal)"><i class="bi bi-lightning-fill me-2"></i>Quick Access</h5>
                    <div class="d-grid gap-3">
                        <a href="jobs" class="btn btn-outline-primary text-start p-3"><i class="bi bi-search me-2"></i> Browse Current Openings</a>
                        <a href="upload-document" class="btn btn-outline-primary text-start p-3"><i class="bi bi-cloud-upload me-2"></i> Manage Document Vault</a>
                        <a href="verification" class="btn btn-outline-primary text-start p-3"><i class="bi bi-shield-check me-2"></i> System Verification Status</a>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card p-4 h-100">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h5 class="fw-bold mb-0" style="color: var(--drdo-teal)"><i class="bi bi-person-badge-fill me-2"></i>Profile Brief</h5>
                        <a href="profile" class="btn btn-sm btn-link text-decoration-none fw-bold p-0">Edit Details</a>
                    </div>
                    <% Applicant applicant = (Applicant) request.getAttribute("applicant"); %>
                    <div class="table-responsive">
                        <table class="table table-sm border-0 mb-0">
                            <tr><td class="text-muted small text-uppercase py-2 border-0">Full Name</td><td class="fw-bold py-2 border-0"><%= applicant.getFullName() %></td></tr>
                            <tr><td class="text-muted small text-uppercase py-2 border-0">Qualification</td><td class="fw-bold py-2 border-0"><%= applicant.getQualification() %></td></tr>
                            <tr><td class="text-muted small text-uppercase py-2 border-0">Experience</td><td class="fw-bold py-2 border-0"><%= applicant.getExperience() %> Years</td></tr>
                            <tr><td class="text-muted small text-uppercase py-2 border-0">Category</td><td class="fw-bold py-2 border-0"><span class="badge bg-light text-dark border"><%= applicant.getCategory() %></span></td></tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    <% } %>
</div>

<footer class="footer text-center">
    <div class="container">
        <p class="mb-0 small">VisionRecruit Recruitment Division &copy; 2026. Built for Career Growth.</p>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.jobportal.model.Application" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Applications - VisionRecruit</title>
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
            padding: 0.8rem 0;
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

        /* Static Page Header */
        .page-header {
            background: linear-gradient(135deg, var(--drdo-teal) 0%, var(--drdo-dark) 100%);
            color: white;
            padding: 40px 0;
            margin-bottom: 30px;
            text-align: left;
        }

        /* Card & Table Stability */
        .card {
            border: 1px solid var(--drdo-border);
            border-radius: 4px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            background: #fff;
            transition: none; /* Keep layout static */
        }
        
        .table thead {
            background-color: #f1f5f5;
            color: var(--drdo-dark);
            border-bottom: 2px solid var(--drdo-border);
        }
        
        .table th {
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-weight: 700;
        }

        /* Status Badge Styling */
        .badge {
            font-weight: 600;
            border-radius: 2px;
            padding: 0.5em 0.8em;
            text-transform: uppercase;
        }

        .border-dashed {
            border: 2px dashed var(--drdo-border);
            background: transparent;
            box-shadow: none;
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
    <div class="container">
        <a class="navbar-brand" href="applicant-dashboard">
            <i class="bi bi-briefcase-fill"></i> VisionRecruit
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#applicantAppNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="applicantAppNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link" href="applicant-dashboard">Dashboard</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="jobs">Find Jobs</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="apply-job">My Applications</a>
                </li>
            </ul>
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link text-danger fw-bold" href="logout">Logout</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="page-header">
    <div class="container animate-fade-in">
        <h3 class="fw-bold mb-0"><i class="bi bi-file-earmark-text-fill me-2"></i> My Applications</h3>
        <p class="opacity-75 mb-0">Track the status of your submitted job applications.</p>
    </div>
</div>

<div class="container py-2 animate-fade-in">
    <% if(request.getAttribute("success") != null) { %>
        <div class="alert alert-success border-0 shadow-sm mb-4"><i class="bi bi-check-circle-fill me-2"></i><%= request.getAttribute("success") %></div>
    <% } %>
    <% if(request.getAttribute("error") != null) { %>
        <div class="alert alert-danger border-0 shadow-sm mb-4"><i class="bi bi-exclamation-triangle-fill me-2"></i><%= request.getAttribute("error") %></div>
    <% } %>

    <% List<Application> apps = (List<Application>) request.getAttribute("applications"); %>
    <% if(apps != null && !apps.isEmpty()) { %>
    <div class="card">
        <div class="table-responsive">
            <table class="table align-middle mb-0">
                <thead>
                    <tr>
                        <th class="ps-3">#</th>
                        <th>Job Title</th>
                        <th>Company</th>
                        <th>Applied Date</th>
                        <th class="text-center">Status</th>
                    </tr>
                </thead>
                <tbody>
                <% int count = 1; for(Application app : apps) { %>
                <tr>
                    <td class="ps-3 text-muted"><%= count++ %></td>
                    <td class="fw-bold text-dark"><%= app.getJobTitle() %></td>
                    <td><%= app.getCompany() %></td>
                    <td class="text-muted"><%= app.getApplyDate() %></td>
                    <td class="text-center">
                        <% String status = app.getStatus(); %>
                        <span class="badge bg-<%= "applied".equals(status) ? "primary" : "shortlisted".equals(status) ? "success" : "rejected".equals(status) ? "danger" : "info" %>">
                            <%= status.toUpperCase().replace("_", " ") %>
                        </span>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>
    <% } else { %>
    <div class="text-center py-5 card border-dashed animate-fade-in">
        <i class="bi bi-inbox text-muted" style="font-size:3.5rem;"></i>
        <p class="text-muted mt-3">No applications found. <a href="jobs" style="color: var(--drdo-teal); font-weight: 700; text-decoration: none;">Browse active jobs</a></p>
    </div>
    <% } %>
</div>

<footer class="footer text-center">
    <div class="container">
        <p class="mb-0 small">VisionRecruit Recruitment Division &copy; 2026. Built for Precision.</p>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
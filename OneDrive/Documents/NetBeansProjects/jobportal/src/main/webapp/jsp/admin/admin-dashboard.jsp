<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.jobportal.model.Application" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Smart Job Portal</title>
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
            padding: 1rem;
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
            margin-right: 15px;
        }
        .nav-link:hover, .nav-link.active {
            color: var(--drdo-teal) !important;
        }

        /* Hero Header Area */
        .dashboard-header {
            background: linear-gradient(135deg, var(--drdo-teal) 0%, var(--drdo-dark) 100%);
            color: white;
            padding: 40px 0;
            margin-bottom: 30px;
            text-align: left;
        }

        /* Stat Cards - Stable Hover */
        .stat-card {
            background: #fff;
            border: 1px solid var(--drdo-border);
            border-top: 4px solid var(--drdo-teal);
            border-radius: 4px;
            padding: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            transition: transform 0.2s ease-out, box-shadow 0.2s ease-out;
            text-decoration: none;
            display: block;
        }
        .stat-card:hover { 
            transform: translateY(-3px); 
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        .stat-icon { font-size: 2rem; color: var(--drdo-teal); opacity: 0.8; }
        .stat-number { font-size: 1.8rem; font-weight: 700; color: #222; }
        .stat-label { font-size: 0.85rem; color: #666; text-transform: uppercase; letter-spacing: 0.5px; font-weight: 600; }

        /* Content Cards */
        .card {
            border: 1px solid var(--drdo-border);
            border-radius: 4px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            background: #fff;
        }
        .table thead {
            background-color: #f1f5f5;
            color: var(--drdo-dark);
        }
        .badge { font-weight: 500; border-radius: 2px; }
        .bg-primary { background-color: var(--drdo-teal) !important; }

        /* Quick Actions */
        .btn-outline-primary { 
            color: var(--drdo-teal); 
            border-color: var(--drdo-teal); 
            transition: all 0.2s ease-in-out;
        }
        .btn-outline-primary:hover { 
            background-color: var(--drdo-teal); 
            color: white;
            transform: scale(1.01);
        }

        footer {
            background-color: #f1f5f5;
            border-top: 1px solid var(--drdo-border);
            padding: 25px 0;
            color: #666;
            margin-top: 40px;
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

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#adminDashNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="adminDashNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link active" href="admin-dashboard"><i class="bi bi-speedometer2 me-1"></i> Dashboard</a></li>
                <li class="nav-item"><a class="nav-link" href="manage-jobs"><i class="bi bi-briefcase me-1"></i> Manage Jobs</a></li>
                <li class="nav-item"><a class="nav-link" href="applicant-list"><i class="bi bi-people me-1"></i> Applicants</a></li>
                <li class="nav-item"><a class="nav-link" href="reports"><i class="bi bi-bar-chart me-1"></i> Reports</a></li>
            </ul>
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link text-danger fw-bold" href="logout">
                        <i class="bi bi-box-arrow-right me-1"></i> LOGOUT
                    </a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="dashboard-header">
    <div class="container-fluid px-4 animate-fade-in">
        <h3 class="fw-bold mb-0"><i class="bi bi-grid-1x2-fill me-2"></i> System Administration Dashboard</h3>
        <p class="opacity-75 mb-0">Overview of job listings, applications, and scheduling status.</p>
    </div>
</div>

<div class="container-fluid px-4 animate-fade-in">
    <div class="row g-4 mb-4">
        <div class="col-md-3">
            <a href="manage-jobs" class="stat-card">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <div class="stat-number"><%= request.getAttribute("totalJobs") != null ? request.getAttribute("totalJobs") : "0" %></div>
                        <div class="stat-label">Active Jobs</div>
                    </div>
                    <i class="bi bi-briefcase stat-icon"></i>
                </div>
            </a>
        </div>
        <div class="col-md-3">
            <a href="applicant-list" class="stat-card">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <div class="stat-number"><%= request.getAttribute("totalApplicants") != null ? request.getAttribute("totalApplicants") : "0" %></div>
                        <div class="stat-label">Total Applicants</div>
                    </div>
                    <i class="bi bi-people stat-icon"></i>
                </div>
            </a>
        </div>
        <div class="col-md-3">
            <a href="applicant-list" class="stat-card">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <div class="stat-number"><%= request.getAttribute("totalApplications") != null ? request.getAttribute("totalApplications") : "0" %></div>
                        <div class="stat-label">Applications</div>
                    </div>
                    <i class="bi bi-file-earmark-text stat-icon"></i>
                </div>
            </a>
        </div>
        <div class="col-md-3">
            <a href="schedule-interview" class="stat-card">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <div class="stat-number"><%= request.getAttribute("totalInterviews") != null ? request.getAttribute("totalInterviews") : "0" %></div>
                        <div class="stat-label">Interviews</div>
                    </div>
                    <i class="bi bi-calendar-check stat-icon"></i>
                </div>
            </a>
        </div>
    </div>

    <div class="row g-4">
        <div class="col-md-8">
            <div class="card p-4">
                <h5 class="fw-bold mb-4" style="color: var(--drdo-teal)"><i class="bi bi-clock-history"></i> Recent Application Activity</h5>
                <% List<Application> recentApps = (List<Application>) request.getAttribute("recentApplications"); %>
                <% if(recentApps != null && !recentApps.isEmpty()) { %>
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead>
                            <tr>
                                <th>Applicant Name</th>
                                <th>Position</th>
                                <th>Applied Date</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                        <% for(Application a : recentApps) { %>
                        <tr>
                            <td class="fw-bold"><%= a.getApplicantName() %></td>
                            <td><%= a.getJobTitle() %></td>
                            <td class="text-muted"><%= a.getApplyDate() %></td>
                            <td>
                                <span class="badge bg-<%= "applied".equals(a.getStatus()) ? "primary" : "shortlisted".equals(a.getStatus()) ? "success" : "info" %>">
                                    <%= a.getStatus().toUpperCase() %>
                                </span>
                            </td>
                        </tr>
                        <% } %>
                        </tbody>
                    </table>
                </div>
                <% } else { %>
                    <div class="text-center py-4 text-muted">No recent applications found.</div>
                <% } %>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card p-4">
                <h5 class="fw-bold mb-4" style="color: var(--drdo-teal)"><i class="bi bi-lightning-fill"></i> Quick Management</h5>
                <div class="d-grid gap-3">
                    <a href="manage-jobs" class="btn btn-outline-primary text-start p-3"><i class="bi bi-plus-circle me-2"></i> Post New Vacancy</a>
                    <a href="applicant-list" class="btn btn-outline-primary text-start p-3"><i class="bi bi-people me-2"></i> Review All Applicants</a>
                    <a href="reports" class="btn btn-outline-primary text-start p-3"><i class="bi bi-bar-chart me-2"></i> Generate System Reports</a>
                </div>
            </div>
        </div>
    </div>
</div>

<footer class="footer text-center">
    <div class="container">
        <p class="mb-0"> &copy; 2026 VisionRecruit Management System. Built for Precision.</p>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.jobportal.model.*, com.jobportal.model.Job" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Applicant List - Admin</title>
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

        /* Card & Table Styling - Fixed to prevent jitter */
        .card {
            border: 1px solid var(--drdo-border);
            border-radius: 4px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            background: #fff;
            transition: none; /* Removed transition to keep it perfectly static */
        }
        
        .filter-card {
            border-top: 3px solid var(--drdo-teal);
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

        .badge {
            font-weight: 500;
            border-radius: 2px;
            padding: 0.5em 0.8em;
        }
        .bg-primary { background-color: var(--drdo-teal) !important; }

        /* Stable Buttons */
        .btn {
            transition: background-color 0.2s ease, color 0.2s ease;
        }
        .btn-primary { background-color: var(--drdo-teal); border-color: var(--drdo-teal); }
        .btn-primary:hover { background-color: var(--drdo-dark); border-color: var(--drdo-dark); }
        
        .btn-outline-success { color: #198754; border-color: #198754; }
        .btn-outline-danger { color: #dc3545; border-color: #dc3545; }
        .btn-outline-warning { color: #856404; border-color: #ffc107; }

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

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#adminNavbarMain">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="adminNavbarMain">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="admin-dashboard"><i class="bi bi-speedometer2 me-1"></i> Dashboard</a></li>
                <li class="nav-item"><a class="nav-link" href="manage-jobs"><i class="bi bi-briefcase me-1"></i> Manage Jobs</a></li>
                <li class="nav-item"><a class="nav-link active" href="applicant-list"><i class="bi bi-people me-1"></i> Applicants</a></li>
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

<div class="page-header">
    <div class="container animate-fade-in">
        <h3 class="fw-bold mb-0"><i class="bi bi-people-fill me-2"></i> Application Management</h3>
        <p class="opacity-75 mb-0">Review, verify, and shortlist candidates for active vacancies.</p>
    </div>
</div>

<div class="container animate-fade-in">
    <div class="card filter-card p-4 mb-4">
        <form action="applicant-list" method="GET" class="row g-3 align-items-center">
            <div class="col-auto">
                <label class="fw-bold text-uppercase small" style="color: var(--drdo-teal);">Filter by Job Vacancy:</label>
            </div>
            <div class="col-md-5">
                <select name="jobId" class="form-select">
                    <option value="">All Active Vacancies</option>
                    <% List<Job> allJobs = (List<Job>) request.getAttribute("allJobs");
                       if(allJobs != null) for(Job j : allJobs) { %>
                    <option value="<%= j.getId() %>"><%= j.getTitle() %> (<%= j.getCompany() %>)</option>
                    <% } %>
                </select>
            </div>
            <div class="col-auto">
                <button type="submit" class="btn btn-primary"><i class="bi bi-filter"></i> Apply Filter</button>
            </div>
        </form>
    </div>

    <% List<Application> apps = (List<Application>) request.getAttribute("applications"); %>
    <% if(apps != null && !apps.isEmpty()) { %>
    <div class="card">
        <div class="table-responsive">
            <table class="table table-hover align-middle mb-0">
                <thead>
                    <tr>
                        <th>Applicant Name</th>
                        <th>Position</th>
                        <th>Institution</th>
                        <th>Applied On</th>
                        <th>Status</th>
                        <th class="text-center">Selection Actions</th>
                    </tr>
                </thead>
                <tbody>
                <% for(Application a : apps) { %>
                <tr>
                    <td class="fw-bold"><%= a.getApplicantName() %></td>
                    <td><%= a.getJobTitle() %></td>
                    <td class="text-muted"><%= a.getCompany() %></td>
                    <td><%= a.getApplyDate() %></td>
                    <td>
                        <span class="badge bg-<%= "applied".equals(a.getStatus()) ? "primary" : "shortlisted".equals(a.getStatus()) ? "success" : "rejected".equals(a.getStatus()) ? "danger" : "info" %>">
                            <%= a.getStatus().toUpperCase() %>
                        </span>
                    </td>
                    <td>
                        <div class="d-flex justify-content-center gap-1">
                            <a href="applicant-list?action=updateStatus&appId=<%= a.getId() %>&status=shortlisted" class="btn btn-sm btn-outline-success" title="Shortlist"><i class="bi bi-check-circle"></i></a>
                            <a href="applicant-list?action=updateStatus&appId=<%= a.getId() %>&status=rejected" class="btn btn-sm btn-outline-danger" title="Reject"><i class="bi bi-x-circle"></i></a>
                            <a href="document-review?applicantId=<%= a.getApplicantId() %>" class="btn btn-sm btn-outline-info" title="Documents"><i class="bi bi-file-earmark-pdf"></i></a>
                            <a href="verification-panel?applicantId=<%= a.getApplicantId() %>" class="btn btn-sm btn-outline-warning" title="Verify Identity"><i class="bi bi-shield-check"></i></a>
                            <% if("shortlisted".equals(a.getStatus())) { %>
                            <a href="schedule-interview?applicationId=<%= a.getId() %>" class="btn btn-sm btn-primary" title="Schedule Interview"><i class="bi bi-calendar-plus"></i></a>
                            <% } %>
                        </div>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>
    <% } else { %>
    <div class="card p-5 text-center">
        <i class="bi bi-folder-x text-muted" style="font-size: 3rem;"></i>
        <p class="text-muted mt-3">No applications match your current filter criteria.</p>
    </div>
    <% } %>
</div>

<footer class="footer text-center">
    <div class="container">
        <p class="mb-0"> &copy; 2026 VisionRecruit Recruitment Division. </p>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
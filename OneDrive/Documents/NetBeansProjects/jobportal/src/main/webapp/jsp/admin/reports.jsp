<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.jobportal.model.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reports - Admin</title>
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

        /* Card Styling - Fixed to prevent jitter */
        .card {
            border: 1px solid var(--drdo-border);
            border-radius: 4px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            background: #fff;
            transition: none; /* Keep layout perfectly static */
        }
        
        /* Report Specific Accents */
        .report-verified { border-left: 5px solid #198754; }
        .report-mismatch { border-left: 5px solid #dc3545; }
        .report-schedule { border-left: 5px solid #0dcaf0; }

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
            padding: 0.4em 0.6em;
        }

        /* Stable Button Hover */
        .btn-outline-warning {
            transition: background-color 0.2s ease, color 0.2s ease;
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

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#adminNavbarContent">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="adminNavbarContent">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="admin-dashboard"><i class="bi bi-speedometer2 me-1"></i> Dashboard</a></li>
                <li class="nav-item"><a class="nav-link" href="manage-jobs"><i class="bi bi-briefcase me-1"></i> Manage Jobs</a></li>
                <li class="nav-item"><a class="nav-link" href="applicant-list"><i class="bi bi-people me-1"></i> Applicants</a></li>
                <li class="nav-item"><a class="nav-link active" href="reports"><i class="bi bi-bar-chart me-1"></i> Reports</a></li>
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
        <h3 class="fw-bold mb-0"><i class="bi bi-bar-chart-fill me-2"></i> System Audit Reports</h3>
        <p class="opacity-75 mb-0">Analysis of verification status, data integrity, and recruitment progress.</p>
    </div>
</div>

<div class="container py-4 animate-fade-in">
    <div class="card report-verified p-4 mb-4">
        <h5 class="fw-bold text-success mb-3"><i class="bi bi-check-circle-fill"></i> Verified Candidate Registry</h5>
        <% List<Applicant> verified = (List<Applicant>) request.getAttribute("verifiedCandidates"); %>
        <% if(verified != null && !verified.isEmpty()) { %>
        <div class="table-responsive">
            <table class="table align-middle">
                <thead>
                    <tr>
                        <th>Candidate Name</th>
                        <th>Academic Qualification</th>
                        <th>Experience</th>
                        <th>Category</th>
                    </tr>
                </thead>
                <tbody>
                <% for(Applicant a : verified) { %>
                <tr>
                    <td class="fw-bold"><%= a.getFullName() %></td>
                    <td><%= a.getQualification() %></td>
                    <td><%= a.getExperience() %> yrs</td>
                    <td><span class="badge bg-light text-dark border"><%= a.getCategory() %></span></td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
        <% } else { %><p class="text-muted italic">No fully verified candidates found in the current cycle.</p><% } %>
    </div>

    <div class="card report-mismatch p-4 mb-4">
        <h5 class="fw-bold text-danger mb-3"><i class="bi bi-exclamation-triangle-fill"></i> Integrity Mismatch Cases</h5>
        <% List<Applicant> mismatch = (List<Applicant>) request.getAttribute("mismatchCandidates"); %>
        <% if(mismatch != null && !mismatch.isEmpty()) { %>
        <div class="table-responsive">
            <table class="table align-middle">
                <thead>
                    <tr>
                        <th>Candidate Name</th>
                        <th>Claimed Qualification</th>
                        <th>Reported Category</th>
                        <th class="text-center">Investigation</th>
                    </tr>
                </thead>
                <tbody>
                <% for(Applicant a : mismatch) { %>
                <tr>
                    <td class="fw-bold text-danger"><%= a.getFullName() %></td>
                    <td><%= a.getQualification() %></td>
                    <td><%= a.getCategory() %></td>
                    <td class="text-center">
                        <a href="verification-panel?applicantId=<%= a.getId() %>" class="btn btn-sm btn-outline-warning">Review Evidence</a>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
        <% } else { %><p class="text-muted">System audit confirms zero data mismatches.</p><% } %>
    </div>

    <div class="card report-schedule p-4">
        <h5 class="fw-bold text-info mb-3" style="color: #0aa2c0 !important;"><i class="bi bi-calendar-check-fill"></i> Master Interview Schedule</h5>
        <% List<Interview> interviews = (List<Interview>) request.getAttribute("interviews"); %>
        <% if(interviews != null && !interviews.isEmpty()) { %>
        <div class="table-responsive">
            <table class="table align-middle">
                <thead>
                    <tr>
                        <th>Applicant</th>
                        <th>Job Designation</th>
                        <th>Date</th>
                        <th>Time</th>
                        <th>Mode</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                <% for(Interview iv : interviews) { %>
                <tr>
                    <td class="fw-bold"><%= iv.getApplicantName() %></td>
                    <td><%= iv.getJobTitle() %></td>
                    <td><%= iv.getInterviewDate() %></td>
                    <td class="text-muted"><%= iv.getInterviewTime() %></td>
                    <td><span class="badge bg-<%= "Online".equals(iv.getMode()) ? "success" : "warning" %>"><%= iv.getMode() %></span></td>
                    <td><span class="badge bg-info text-dark"><%= iv.getStatus() %></span></td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
        <% } else { %><p class="text-muted">No interviews have been provisioned yet.</p><% } %>
    </div>
</div>

<footer class="footer text-center">
    <div class="container">
        <p class="mb-0">VisionRecruit Reporting Analytics &copy; 2026. Built for Integrity.</p>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
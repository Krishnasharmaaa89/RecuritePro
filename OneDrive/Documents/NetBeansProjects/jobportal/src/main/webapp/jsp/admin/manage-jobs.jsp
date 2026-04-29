<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.jobportal.model.Job" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Jobs - Admin</title>
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
            transition: none; /* Keep static */
        }
        
        .form-card {
            border-top: 4px solid var(--drdo-teal);
        }

        /* Table Styling */
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
        .bg-success { background-color: var(--drdo-teal) !important; }

        /* Stable Buttons */
        .btn {
            transition: background-color 0.2s ease, color 0.2s ease;
        }
        .btn-primary { background-color: var(--drdo-teal); border-color: var(--drdo-teal); }
        .btn-primary:hover { background-color: var(--drdo-dark); border-color: var(--drdo-dark); }
        
        .btn-outline-primary { color: var(--drdo-teal); border-color: var(--drdo-teal); }
        .btn-outline-primary:hover { background-color: var(--drdo-teal); color: #fff; }

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

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#adminManageJobsNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="adminManageJobsNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="admin-dashboard"><i class="bi bi-speedometer2 me-1"></i> Dashboard</a></li>
                <li class="nav-item"><a class="nav-link active" href="manage-jobs"><i class="bi bi-briefcase me-1"></i> Manage Jobs</a></li>
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

<div class="page-header">
    <div class="container animate-fade-in">
        <h3 class="fw-bold mb-0"><i class="bi bi-briefcase-fill me-2"></i> Job Listing Management</h3>
        <p class="opacity-75 mb-0">Post new vacancies or update existing institutional job listings.</p>
    </div>
</div>

<div class="container animate-fade-in">
    <% if(request.getAttribute("success") != null) { %>
        <div class="alert alert-success border-0 shadow-sm mb-4">
            <i class="bi bi-check-circle-fill me-2"></i> <%= request.getAttribute("success") %>
        </div>
    <% } %>

    <% Job editJob = (Job) request.getAttribute("editJob"); %>
    
    <div class="card form-card p-4 mb-5">
        <h5 class="fw-bold mb-4" style="color: var(--drdo-teal)">
            <%= editJob != null ? "Modify Vacancy Details" : "Post New Vacancy" %>
        </h5>
        <form action="manage-jobs" method="POST">
            <% if(editJob != null) { %><input type="hidden" name="jobId" value="<%= editJob.getId() %>"><% } %>
            <div class="row g-4">
                <div class="col-md-6">
                    <label class="form-label fw-bold small text-uppercase">Job Title *</label>
                    <input type="text" name="title" class="form-control" value="<%= editJob != null ? editJob.getTitle() : "" %>" required placeholder="e.g. Senior Research Fellow">
                </div>
                <div class="col-md-3">
                    <label class="form-label fw-bold small text-uppercase">Company/Lab *</label>
                    <input type="text" name="company" class="form-control" value="<%= editJob != null ? editJob.getCompany() : "" %>" required>
                </div>
                <div class="col-md-3">
                    <label class="form-label fw-bold small text-uppercase">Location</label>
                    <input type="text" name="location" class="form-control" value="<%= editJob != null ? editJob.getLocation() : "" %>">
                </div>
                <div class="col-md-6">
                    <label class="form-label fw-bold small text-uppercase">Job Description</label>
                    <textarea name="description" class="form-control" rows="4" placeholder="Brief overview of responsibilities..."><%= editJob != null ? editJob.getDescription() : "" %></textarea>
                </div>
                <div class="col-md-6">
                    <label class="form-label fw-bold small text-uppercase">Eligibility Requirements</label>
                    <textarea name="requirements" class="form-control" rows="4" placeholder="Qualifications, experience, skills..."><%= editJob != null ? editJob.getRequirements() : "" %></textarea>
                </div>
            </div>
            <div class="mt-4">
                <button type="submit" class="btn btn-primary px-4">
                    <i class="bi bi-cloud-arrow-up me-2"></i> <%= editJob != null ? "Update Job Listing" : "Publish Job Vacancy" %>
                </button>
                <% if(editJob != null) { %><a href="manage-jobs" class="btn btn-secondary px-4 ms-2">Discard Changes</a><% } %>
            </div>
        </form>
    </div>

    <h5 class="fw-bold mb-3" style="color: var(--drdo-dark);">Active Job Inventories</h5>
    <% List<Job> jobs = (List<Job>) request.getAttribute("jobs"); %>
    <% if(jobs != null && !jobs.isEmpty()) { %>
    <div class="card">
        <div class="table-responsive">
            <table class="table align-middle mb-0">
                <thead>
                    <tr>
                        <th>Designation</th>
                        <th>Institution</th>
                        <th>Location</th>
                        <th>Post Date</th>
                        <th>Status</th>
                        <th class="text-center">Operations</th>
                    </tr>
                </thead>
                <tbody>
                <% for(Job j : jobs) { %>
                <tr>
                    <td class="fw-bold"><%= j.getTitle() %></td>
                    <td class="text-muted"><%= j.getCompany() %></td>
                    <td><%= j.getLocation() %></td>
                    <td><%= j.getPostedDate() %></td>
                    <td>
                        <span class="badge bg-<%= j.isActive() ? "success" : "secondary" %>">
                            <%= j.isActive() ? "OPEN" : "CLOSED" %>
                        </span>
                    </td>
                    <td>
                        <div class="d-flex justify-content-center gap-2">
                            <a href="manage-jobs?action=edit&id=<%= j.getId() %>" class="btn btn-sm btn-outline-primary" title="Edit"><i class="bi bi-pencil-square"></i></a>
                            <a href="manage-jobs?action=delete&id=<%= j.getId() %>" class="btn btn-sm btn-outline-danger" title="Delete" onclick="return confirm('Archive this job listing?')"><i class="bi bi-trash"></i></a>
                            <a href="applicant-list?jobId=<%= j.getId() %>" class="btn btn-sm btn-outline-info" title="View Applicants"><i class="bi bi-people-fill"></i></a>
                        </div>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>
    <% } else { %>
        <div class="card p-5 text-center text-muted">
            <i class="bi bi-folder-x mb-2" style="font-size: 2.5rem;"></i>
            <p>No vacancies posted yet.</p>
        </div>
    <% } %>
</div>

<footer class="footer text-center">
    <div class="container">
        <p class="mb-0">VisionRecruit Administration &copy; 2026. All Systems Operational.</p>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
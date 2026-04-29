<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.jobportal.model.Job" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Find Jobs - VisionRecruit</title>
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
            padding: 60px 0 100px 0; /* Extra bottom padding for search overlap */
            margin-bottom: 0;
            text-align: center;
        }

        /* Search Bar Styling - Positioned statically relative to container */
        .search-container {
            background: #fff;
            padding: 25px;
            border-radius: 4px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            margin-top: -50px;
            position: relative;
            z-index: 10;
            border: 1px solid var(--drdo-border);
        }

        .form-control:focus {
            border-color: var(--drdo-teal);
            box-shadow: 0 0 0 0.25rem rgba(0, 90, 90, 0.1);
        }

        /* Job Card Styling - Removed translateY to keep layout static */
        .job-card {
            border: 1px solid var(--drdo-border);
            border-left: 5px solid var(--drdo-teal);
            border-radius: 4px;
            background: #fff;
            transition: box-shadow 0.2s ease;
        }
        .job-card:hover {
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            transform: none; /* Removed movement jitter */
        }
        .job-title { color: var(--drdo-teal); font-weight: 700; }
        
        /* Buttons Stability */
        .btn-primary { 
            background-color: var(--drdo-teal); 
            border-color: var(--drdo-teal); 
            transition: background-color 0.2s ease;
        }
        .btn-primary:hover { 
            background-color: var(--drdo-dark); 
            border-color: var(--drdo-dark); 
            transform: none; 
        }
        
        .badge-location {
            background-color: #e9f1f1;
            color: var(--drdo-teal);
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            display: inline-block;
        }

        /* Pagination Stability */
        .page-link { color: var(--drdo-teal); border-radius: 4px !important; margin: 0 2px; }
        .page-item.active .page-link { background-color: var(--drdo-teal); border-color: var(--drdo-teal); }

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

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#findJobsNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="findJobsNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="applicant-dashboard"><i class="bi bi-speedometer2 me-1"></i> Dashboard</a></li>
                <li class="nav-item"><a class="nav-link" href="profile"><i class="bi bi-person me-1"></i> Profile</a></li>
                <li class="nav-item"><a class="nav-link active" href="jobs"><i class="bi bi-search me-1"></i> Find Jobs</a></li>
                <li class="nav-item"><a class="nav-link" href="apply-job"><i class="bi bi-file-earmark-text me-1"></i> My Applications</a></li>
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
        <h2 class="fw-bold mb-2 text-uppercase tracking-wider">Current Vacancies</h2>
        <p class="opacity-75 mb-0">Explore career opportunities across our research laboratories and offices.</p>
    </div>
</div>

<div class="container animate-fade-in">
    <div class="search-container mb-5">
        <form action="jobs" method="GET">
            <div class="input-group">
                <span class="input-group-text bg-white border-end-0"><i class="bi bi-search text-muted"></i></span>
                <input type="text" name="search" class="form-control form-control-lg border-start-0" placeholder="Job title, skills, or location..." value="<%= request.getAttribute("searchQuery") != null ? request.getAttribute("searchQuery") : "" %>">
                <button class="btn btn-primary px-5 fw-bold" type="submit">SEARCH</button>
            </div>
        </form>
    </div>

    <% List<Job> jobs = (List<Job>) request.getAttribute("jobs"); %>
    <% if(jobs != null && !jobs.isEmpty()) { %>
        <div class="row">
            <div class="col-lg-10 mx-auto">
                <% for(Job job : jobs) { %>
                    <div class="card job-card p-4 mb-3">
                        <div class="d-flex flex-column flex-md-row justify-content-between align-items-start align-items-md-center">
                            <div class="mb-3 mb-md-0">
                                <h5 class="job-title mb-2 text-uppercase"><%= job.getTitle() %></h5>
                                <div class="d-flex align-items-center gap-3 mb-3">
                                    <span class="small fw-bold text-muted"><i class="bi bi-building me-1"></i><%= job.getCompany() %></span>
                                    <span class="badge-location"><i class="bi bi-geo-alt me-1"></i><%= job.getLocation() %></span>
                                </div>
                                <p class="text-secondary small mb-3" style="max-width: 700px;"><%= job.getDescription() %></p>
                                <div class="mb-2">
                                    <span class="small fw-bold">Requirements:</span>
                                    <span class="small text-muted ms-1"><%= job.getRequirements() %></span>
                                </div>
                                <div class="text-muted" style="font-size: 0.75rem;">
                                    <i class="bi bi-calendar3 me-1"></i> Posted: <%= job.getPostedDate() %>
                                </div>
                            </div>
                            <form action="apply-job" method="POST" class="ms-md-3">
                                <input type="hidden" name="jobId" value="<%= job.getId() %>">
                                <button type="submit" class="btn btn-primary px-4 fw-bold shadow-sm">
                                    APPLY NOW <i class="bi bi-chevron-right ms-1"></i>
                                </button>
                            </form>
                        </div>
                    </div>
                <% } %>

                <% 
                   Integer currentPageObj = (Integer) request.getAttribute("currentPage");
                   Integer totalPagesObj = (Integer) request.getAttribute("totalPages");
                   int currentPage = (currentPageObj != null) ? currentPageObj : 1;
                   int totalPages = (totalPagesObj != null) ? totalPagesObj : 1;
                %>
                <% if(totalPages > 1) { %>
                    <nav class="mt-5">
                        <ul class="pagination justify-content-center">
                            <% for(int i = 1; i <= totalPages; i++) { %>
                                <li class="page-item <%= i == currentPage ? "active" : "" %>">
                                    <a class="page-link shadow-sm" href="jobs?page=<%= i %><%= request.getAttribute("searchQuery") != null ? "&search=" + request.getAttribute("searchQuery") : "" %>"><%= i %></a>
                                </li>
                            <% } %>
                        </ul>
                    </nav>
                <% } %>
            </div>
        </div>
    <% } else { %>
        <div class="text-center py-5 card border-0 bg-transparent">
            <i class="bi bi-search text-muted" style="font-size:3rem;"></i>
            <h5 class="mt-3 text-muted">No vacancies found matching your criteria.</h5>
            <p class="text-muted">Try adjusting your search terms or filters.</p>
        </div>
    <% } %>
</div>

<footer class="footer text-center">
    <div class="container">
        <p class="mb-0 small">VisionRecruit Recruitment Division &copy; 2026. All Rights Reserved.</p>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
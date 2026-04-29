<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.jobportal.model.Interview" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Interview Schedule - VisionRecruit</title>
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

        /* Static Page Header */
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
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
            background: #fff;
            transition: none; /* Keep layout perfectly static */
        }
        
        /* Removed hover transform to prevent shifting */
        .card:hover {
            transform: none;
            box-shadow: 0 4px 16px rgba(0,0,0,0.1);
        }

        .table-sm td {
            padding: 0.75rem 0.5rem;
            border-bottom: 1px solid #f1f1f1;
        }
        
        .badge {
            font-weight: 600;
            border-radius: 2px;
            padding: 0.4em 0.8em;
            text-transform: uppercase;
            font-size: 0.7rem;
        }
        
        .text-teal { color: var(--drdo-teal) !important; }

        .border-dashed {
            border: 2px dashed var(--drdo-border);
            border-top: 2px dashed var(--drdo-border); /* Resetting Teal top border for empty state */
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

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#interviewNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="interviewNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link" href="applicant-dashboard">Dashboard</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="apply-job">My Applications</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="interview-status">Interviews</a>
                </li>
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
        <h3 class="fw-bold mb-0"><i class="bi bi-calendar-check-fill me-2"></i> Official Interview Schedule</h3>
        <p class="opacity-75 mb-0">Review your confirmed selection committee meetings and reporting details.</p>
    </div>
</div>

<div class="container py-2 animate-fade-in">
    <% List<Interview> interviews = (List<Interview>) request.getAttribute("interviews"); %>
    <% if(interviews != null && !interviews.isEmpty()) { %>
    <div class="row g-4">
        <% for(Interview iv : interviews) { %>
        <div class="col-md-6">
            <div class="card p-4 h-100">
                <div class="d-flex align-items-center mb-3">
                    <div class="rounded-circle bg-light p-2 me-3">
                        <i class="bi bi-briefcase-fill text-teal fs-4"></i>
                    </div>
                    <h5 class="fw-bold mb-0 text-teal"><%= iv.getJobTitle() %></h5>
                </div>
                
                <div class="table-responsive">
                    <table class="table table-sm border-0 mb-0">
                        <tr>
                            <td class="text-muted small text-uppercase" style="width: 35%;"><i class="bi bi-calendar-event me-2"></i>Date</td>
                            <td class="fw-bold"><%= iv.getInterviewDate() %></td>
                        </tr>
                        <tr>
                            <td class="text-muted small text-uppercase"><i class="bi bi-clock-history me-2"></i>Time</td>
                            <td class="fw-bold"><%= iv.getInterviewTime() %></td>
                        </tr>
                        <tr>
                            <td class="text-muted small text-uppercase"><i class="bi bi-camera-video me-2"></i>Mode</td>
                            <td><span class="badge bg-<%= "Online".equals(iv.getMode()) ? "success" : "warning" %>"><%= iv.getMode() %></span></td>
                        </tr>
                        
                        <% if("Online".equals(iv.getMode()) && iv.getMeetingLink() != null) { %>
                        <tr>
                            <td class="text-muted small text-uppercase"><i class="bi bi-link-45deg me-2"></i>Access</td>
                            <td><a href="<%= iv.getMeetingLink() %>" target="_blank" class="text-teal text-decoration-none fw-bold"><i class="bi bi-box-arrow-up-right me-1"></i>Join Session</a></td>
                        </tr>
                        <% } else if(iv.getLocation() != null) { %>
                        <tr>
                            <td class="text-muted small text-uppercase"><i class="bi bi-geo-alt-fill me-2"></i>Reporting</td>
                            <td class="small"><%= iv.getLocation() %></td>
                        </tr>
                        <% } %>
                        
                        <tr>
                            <td class="text-muted small text-uppercase border-0"><i class="bi bi-info-circle-fill me-2"></i>Status</td>
                            <td class="border-0"><span class="badge bg-info text-dark"><%= iv.getStatus() %></span></td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        <% } %>
    </div>
    <% } else { %>
    <div class="text-center py-5 card border-dashed">
        <i class="bi bi-calendar-x text-muted" style="font-size:3.5rem;"></i>
        <h5 class="mt-3 text-muted">No Scheduled Interviews</h5>
        <p class="text-muted">You will be notified once the selection committee provisionally schedules your meeting.</p>
    </div>
    <% } %>
</div>

<footer class="footer text-center">
    <div class="container">
        <p class="mb-0 small text-muted">VisionRecruit Recruitment Division &copy; 2026. Built for Precision.</p>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
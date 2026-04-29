<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.jobportal.model.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Verification Panel - Admin</title>
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
        .nav-link:hover {
            color: var(--drdo-teal) !important;
        }

        /* Static Header Area */
        .page-header {
            background: linear-gradient(135deg, var(--drdo-teal) 0%, var(--drdo-dark) 100%);
            color: white;
            padding: 40px 0;
            margin-bottom: 25px;
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

        .table thead {
            background-color: #f1f5f5;
            color: var(--drdo-dark);
        }
        
        .table th {
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-weight: 700;
            border-bottom: 2px solid var(--drdo-border);
        }

        /* Verification Status Tints - Locked Backgrounds */
        .table-success-custom { background-color: #f0fff4 !important; }
        .table-danger-custom { background-color: #fff5f5 !important; }
        .table-warning-custom { background-color: #fffaf0 !important; }

        .badge-verified { background-color: #198754; color: white; padding: 0.4em 0.8em; border-radius: 2px; font-size: 0.75rem; font-weight: 600; }
        .badge-mismatch { background-color: #dc3545; color: white; padding: 0.4em 0.8em; border-radius: 2px; font-size: 0.75rem; font-weight: 600; }
        .badge-review { background-color: #ffc107; color: #333; padding: 0.4em 0.8em; border-radius: 2px; font-size: 0.75rem; font-weight: 600; }

        /* Buttons Stability */
        .btn {
            transition: background-color 0.2s ease;
        }
        .btn-outline-secondary { color: #666; border-color: #ccc; }
        .btn-outline-secondary:hover { background-color: #eee; color: #333; transform: none; }

        footer {
            background-color: #ffffff;
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

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#adminMobileNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="adminMobileNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link" href="admin-dashboard">
                        <i class="bi bi-speedometer2 me-1"></i> Dashboard
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="applicant-list">
                        <i class="bi bi-people me-1"></i> Applicants
                    </a>
                </li>
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

<% Applicant applicant = (Applicant) request.getAttribute("applicant"); %>

<div class="page-header">
    <div class="container animate-fade-in">
        <h3 class="fw-bold mb-1"><i class="bi bi-shield-check-fill me-2"></i> Integrity Verification Panel</h3>
        <p class="opacity-75 mb-0">Candidate: <%= applicant != null ? applicant.getFullName() : "Unknown Record" %></p>
    </div>
</div>

<div class="container animate-fade-in">
    <div class="mb-4">
        <a href="applicant-list" class="btn btn-outline-secondary btn-sm"><i class="bi bi-arrow-left"></i> Return to List</a>
    </div>

    <% List<VerificationResult> results = (List<VerificationResult>) request.getAttribute("results"); %>
    <% if(results != null && !results.isEmpty()) { %>
    <div class="card">
        <div class="table-responsive">
            <table class="table align-middle mb-0">
                <thead>
                    <tr>
                        <th class="ps-4">Validation Field</th>
                        <th>User-Declared Value</th>
                        <th>AI-Extracted Evidence</th>
                        <th class="text-center">Authentication Status</th>
                    </tr>
                </thead>
                <tbody>
                <% for(VerificationResult vr : results) { 
                    String rowClass = "MISMATCH".equals(vr.getMatchStatus()) ? "table-danger-custom" : 
                                     "VERIFIED".equals(vr.getMatchStatus()) ? "table-success-custom" : "table-warning-custom";
                    String badgeClass = "VERIFIED".equals(vr.getMatchStatus()) ? "badge-verified" : 
                                      "MISMATCH".equals(vr.getMatchStatus()) ? "badge-mismatch" : "badge-review";
                %>
                <tr class="<%= rowClass %>">
                    <td class="ps-4 fw-bold text-dark"><%= vr.getFieldName() %></td>
                    <td><%= vr.getFormValue() %></td>
                    <td class="font-monospace small"><%= vr.getExtractedValue() %></td>
                    <td class="text-center">
                        <span class="<%= badgeClass %>"><%= vr.getMatchStatus() %></span>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>
    <% } else { %>
    <div class="card p-5 text-center text-muted">
        <i class="bi bi-clipboard-x mb-2" style="font-size: 3rem;"></i>
        <p>Verification results pending. System AI is currently cross-referencing user documentation.</p>
    </div>
    <% } %>
</div>

<footer class="footer text-center">
    <div class="container">
        <p class="mb-0">VisionRecruit Recruitment Division  2026. Integrity Verified.</p>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
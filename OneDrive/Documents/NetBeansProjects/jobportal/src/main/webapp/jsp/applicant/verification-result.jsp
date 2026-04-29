<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.jobportal.model.VerificationResult" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Verification Results - VisionRecruit</title>
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

        /* Card & Table Stability */
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
            border-bottom: 2px solid var(--drdo-border);
        }
        
        .table th {
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-weight: 700;
        }

        /* Verification Status Tints - Static Colors */
        .table-success-custom { background-color: #f0fff4 !important; }
        .table-danger-custom { background-color: #fff5f5 !important; }
        .table-warning-custom { background-color: #fffaf0 !important; }

        .badge-verified { background-color: #198754; color: white; padding: 0.4em 0.8em; border-radius: 2px; font-size: 0.75rem; font-weight: 600; display: inline-block; }
        .badge-mismatch { background-color: #dc3545; color: white; padding: 0.4em 0.8em; border-radius: 2px; font-size: 0.75rem; font-weight: 600; display: inline-block; }
        .badge-review { background-color: #ffc107; color: #333; padding: 0.4em 0.8em; border-radius: 2px; font-size: 0.75rem; font-weight: 600; display: inline-block; }

        .border-dashed {
            border: 2px dashed var(--drdo-border);
            background: transparent;
            box-shadow: none;
        }

        /* Stable Buttons */
        .btn-primary {
            background-color: var(--drdo-teal);
            border-color: var(--drdo-teal);
            font-weight: 600;
            transition: background-color 0.2s ease;
        }
        .btn-primary:hover {
            background-color: var(--drdo-dark);
            transform: none;
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

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#verificationNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="verificationNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="applicant-dashboard">Dashboard</a></li>
                <li class="nav-item"><a class="nav-link" href="upload-document">Documents</a></li>
                <li class="nav-item"><a class="nav-link" href="extracted-data">Extracted Data</a></li>
                <li class="nav-item"><a class="nav-link active" href="verification">Verification</a></li>
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
        <h3 class="fw-bold mb-0"><i class="bi bi-shield-shaded me-2"></i> Data Authentication Report</h3>
        <p class="opacity-75 mb-0">Validation of your profile attributes against system-extracted document metadata.</p>
    </div>
</div>

<div class="container py-2 animate-fade-in">
    <% List<VerificationResult> results = (List<VerificationResult>) request.getAttribute("results"); %>
    <% if(results != null && !results.isEmpty()) { %>
    <div class="card">
        <div class="table-responsive">
            <table class="table align-middle mb-0">
                <thead>
                    <tr>
                        <th class="ps-4">Profile Attribute</th>
                        <th>Declared Value</th>
                        <th>Evidence Found</th>
                        <th class="text-center">Authentication</th>
                    </tr>
                </thead>
                <tbody>
                <% for(VerificationResult vr : results) { 
                    String rowClass = "MISMATCH".equals(vr.getMatchStatus()) ? "table-danger-custom" : 
                                     "VERIFIED".equals(vr.getMatchStatus()) ? "table-success-custom" : "table-warning-custom";
                    String badgeClass = "VERIFIED".equals(vr.getMatchStatus()) ? "badge-verified" : 
                                      "MISMATCH".equals(vr.getMatchStatus()) ? "badge-mismatch" : "badge-review";
                    String icon = "VERIFIED".equals(vr.getMatchStatus()) ? "check-circle-fill" : 
                                 "MISMATCH".equals(vr.getMatchStatus()) ? "x-circle-fill" : "question-circle-fill";
                %>
                <tr class="<%= rowClass %>">
                    <td class="ps-4 fw-bold text-dark"><%= vr.getFieldName() %></td>
                    <td><%= vr.getFormValue() %></td>
                    <td class="font-monospace text-secondary"><%= vr.getExtractedValue() %></td>
                    <td class="text-center">
                        <span class="<%= badgeClass %> text-uppercase">
                            <i class="bi bi-<%= icon %> me-1"></i><%= vr.getMatchStatus() %>
                        </span>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>
    <% } else { %>
    <div class="text-center py-5 card border-dashed">
        <i class="bi bi-shield-exclamation text-muted mb-3" style="font-size:3rem;"></i>
        <h5 class="text-muted">No Verification Results Generated</h5>
        <p class="text-muted">Results will be available once your profile data is cross-referenced with your uploaded credentials.</p>
        <div class="mt-2">
            <a href="upload-document" class="btn btn-primary px-4 py-2">
                Check Document Status
            </a>
        </div>
    </div>
    <% } %>
</div>

<footer class="footer text-center">
    <div class="container">
        <p class="mb-0 small text-muted">VisionRecruit Verification System &copy; 2026. Automated Data Integrity.</p>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
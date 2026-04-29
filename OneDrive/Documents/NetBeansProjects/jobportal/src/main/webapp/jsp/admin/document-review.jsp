<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.jobportal.model.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document Review - Admin</title>
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

        /* Header Area */
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
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
            background: #fff;
            margin-bottom: 20px;
            transition: none; /* Keep static */
        }
        
        .profile-card {
            border-left: 5px solid var(--drdo-teal);
        }

        .document-card {
            border-top: 3px solid #6c757d;
        }

        /* Table Styling */
        .table thead {
            background-color: #f1f5f5;
            color: var(--drdo-dark);
        }
        
        .table th {
            font-size: 0.8rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-weight: 700;
        }

        .badge {
            font-weight: 600;
            border-radius: 2px;
            text-transform: uppercase;
            font-size: 0.75rem;
        }
        
        .bg-info { background-color: #17a2b8 !important; }

        /* Buttons */
        .btn {
            transition: background-color 0.2s ease, color 0.2s ease;
        }
        .btn-outline-secondary { color: #666; border-color: #ccc; }
        .btn-outline-secondary:hover { background-color: #eee; color: #333; }
        .btn-warning { background-color: #ffc107; border-color: #ffc107; font-weight: 600; color: #333; }

        footer {
            background-color: #ffffff;
            border-top: 1px solid var(--drdo-border);
            padding: 25px 0;
            color: #666;
            margin-top: 40px;
        }

        /* Fade in for smooth loading */
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

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#adminReviewNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="adminReviewNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="admin-dashboard"><i class="bi bi-speedometer2 me-1"></i> Dashboard</a></li>
                <li class="nav-item"><a class="nav-link" href="applicant-list"><i class="bi bi-people me-1"></i> Applicants</a></li>
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
        <h3 class="fw-bold mb-1"><i class="bi bi-file-earmark-check-fill me-2"></i> Document Evidence Review</h3>
        <p class="opacity-75 mb-0">Candidate: <%= applicant != null ? applicant.getFullName() : "System Record" %></p>
    </div>
</div>

<div class="container animate-fade-in">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <a href="applicant-list" class="btn btn-outline-secondary btn-sm"><i class="bi bi-arrow-left"></i> Return to List</a>
        <a href="verification-panel?applicantId=<%= applicant != null ? applicant.getId() : 0 %>" class="btn btn-warning"><i class="bi bi-shield-check"></i> Finalize Verification</a>
    </div>

    <% if(applicant != null) { %>
    <div class="card profile-card p-3">
        <h6 class="fw-bold text-uppercase small mb-3" style="color: var(--drdo-teal);">Verified Profile Summary</h6>
        <div class="row">
            <div class="col-md-4"><span class="text-muted small">Full Name:</span> <div class="fw-bold"><%= applicant.getFullName() %></div></div>
            <div class="col-md-4"><span class="text-muted small">Academic Qualification:</span> <div class="fw-bold"><%= applicant.getQualification() %></div></div>
            <div class="col-md-4"><span class="text-muted small">Total Experience:</span> <div class="fw-bold"><%= applicant.getExperience() %> Years</div></div>
        </div>
    </div>
    <% } %>

    <h5 class="fw-bold mb-3 mt-4" style="color: var(--drdo-dark);">Extracted AI Data</h5>

    <% Map<Document, List<ExtractedData>> docDataMap = (Map<Document, List<ExtractedData>>) request.getAttribute("docDataMap"); %>
    <% if(docDataMap != null && !docDataMap.isEmpty()) { %>
        <% for(Map.Entry<Document, List<ExtractedData>> entry : docDataMap.entrySet()) { %>
        <div class="card document-card p-3">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h6 class="fw-bold mb-0 text-dark">
                    <i class="bi bi-file-earmark-text me-2"></i><%= entry.getKey().getDocumentName() %>
                </h6>
                <span class="badge bg-info">Type: <%= entry.getKey().getDocumentType() %></span>
            </div>
            
            <div class="table-responsive">
                <table class="table table-bordered align-middle mb-0">
                    <thead>
                        <tr>
                            <th style="width: 40%;">Metadata Field</th>
                            <th>Extracted System Value</th>
                        </tr>
                    </thead>
                    <tbody>
                    <% for(ExtractedData ed : entry.getValue()) { %>
                    <tr>
                        <td class="bg-light fw-semibold"><%= ed.getFieldName() %></td>
                        <td class="font-monospace"><%= ed.getExtractedValue() %></td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
        </div>
        <% } %>
    <% } else { %>
        <div class="card p-5 text-center text-muted">
            <i class="bi bi-cloud-slash mb-2" style="font-size: 2.5rem;"></i>
            <p>No document metadata found for this applicant.</p>
        </div>
    <% } %>
</div>

<footer class="footer text-center">
    <div class="container">
        <p class="mb-0">VisionRecruit Verification System &copy; 2026. Built for Accuracy.</p>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
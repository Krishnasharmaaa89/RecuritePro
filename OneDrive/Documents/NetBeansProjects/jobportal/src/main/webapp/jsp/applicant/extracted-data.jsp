<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.jobportal.model.Document, com.jobportal.model.ExtractedData" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Extracted Data - VisionRecruit</title>
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
            border-radius: 4px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            background: #fff;
            border-left: 5px solid var(--drdo-teal);
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

        .badge {
            font-weight: 600;
            border-radius: 2px;
            padding: 0.4em 0.8em;
            text-transform: uppercase;
            font-size: 0.7rem;
        }
        
        .bg-info { background-color: #17a2b8 !important; }

        .border-dashed {
            border: 2px dashed var(--drdo-border);
            border-left: 2px dashed var(--drdo-border); /* Overriding left teal border for empty state */
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
        
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#extractedDataNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="extractedDataNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="applicant-dashboard">Dashboard</a></li>
                <li class="nav-item"><a class="nav-link" href="upload-document">Documents</a></li>
                <li class="nav-item"><a class="nav-link active" href="extracted-data">Extracted Data</a></li>
                <li class="nav-item"><a class="nav-link" href="verification">Verification</a></li>
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
        <h3 class="fw-bold mb-0"><i class="bi bi-file-earmark-bar-graph-fill me-2"></i> Document Information Extraction</h3>
        <p class="opacity-75 mb-0">Review the metadata automatically captured by the AI from your uploaded certifications.</p>
    </div>
</div>

<div class="container py-2 animate-fade-in">
    <% Map<Document, List<ExtractedData>> docDataMap = (Map<Document, List<ExtractedData>>) request.getAttribute("docDataMap"); %>
    <% if(docDataMap != null && !docDataMap.isEmpty()) { %>
        <% for(Map.Entry<Document, List<ExtractedData>> entry : docDataMap.entrySet()) { %>
            <div class="card mb-4 p-3">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h6 class="fw-bold mb-0" style="color: var(--drdo-dark);">
                        <i class="bi bi-file-earmark-text me-2"></i><%= entry.getKey().getDocumentName() %>
                    </h6>
                    <span class="badge bg-info"><%= entry.getKey().getDocumentType() %></span>
                </div>
                
                <div class="table-responsive">
                    <table class="table align-middle mb-0">
                        <thead>
                            <tr>
                                <th style="width: 35%;">Information Field</th>
                                <th>Captured System Value</th>
                            </tr>
                        </thead>
                        <tbody>
                        <% for(ExtractedData ed : entry.getValue()) { %>
                        <tr>
                            <td class="fw-bold bg-light" style="font-size: 0.9rem;"><%= ed.getFieldName() %></td>
                            <td class="font-monospace text-secondary"><%= ed.getExtractedValue() %></td>
                        </tr>
                        <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        <% } %>
    <% } else { %>
    <div class="text-center py-5 card border-dashed">
        <i class="bi bi-search text-muted mb-3" style="font-size:3rem;"></i>
        <h5 class="text-muted">No Data Found</h5>
        <p class="text-muted">Extracted information will appear here once your uploads have been processed by the system.</p>
        <div class="mt-2">
            <a href="upload-document" class="btn btn-primary" style="background-color: var(--drdo-teal); border: none;">
                <i class="bi bi-upload me-2"></i>Go to Upload
            </a>
        </div>
    </div>
    <% } %>
</div>

<footer class="footer text-center">
    <div class="container">
        <p class="mb-0 small text-muted">VisionRecruit AI Document Processing Unit &copy; 2026. Built for Accuracy.</p>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
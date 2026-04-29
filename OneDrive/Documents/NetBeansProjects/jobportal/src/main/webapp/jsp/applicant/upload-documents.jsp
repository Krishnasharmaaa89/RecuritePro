<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.jobportal.model.Document" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Upload Documents - VisionRecruit</title>
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
            transition: none; /* Keep layout static */
        }
        
        .upload-card {
            border-top: 4px solid var(--drdo-teal);
        }

        .form-label {
            font-size: 0.82rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            color: #444;
            font-weight: 700;
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
            font-weight: 600;
            border-radius: 2px;
            padding: 0.4em 0.8em;
            text-transform: uppercase;
            font-size: 0.7rem;
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
            border-color: var(--drdo-dark);
            transform: none; /* Removed movement jitter */
        }

        .border-dashed {
            border: 2px dashed var(--drdo-border);
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
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#documentsNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="documentsNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="applicant-dashboard">Dashboard</a></li>
                <li class="nav-item"><a class="nav-link active" href="upload-document">Documents</a></li>
                <li class="nav-item"><a class="nav-link" href="extracted-data">Extracted Data</a></li>
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
        <h3 class="fw-bold mb-0"><i class="bi bi-cloud-upload-fill me-2"></i> Document Evidence Vault</h3>
        <p class="opacity-75 mb-0">Upload official certifications for AI-powered verification and profile authentication.</p>
    </div>
</div>

<div class="container py-2 animate-fade-in">
    <% if(request.getAttribute("success") != null) { %>
        <div class="alert alert-success border-0 shadow-sm mb-4"><i class="bi bi-check-circle-fill me-2"></i> <%= request.getAttribute("success") %></div>
    <% } %>
    <% if(request.getAttribute("error") != null) { %>
        <div class="alert alert-danger border-0 shadow-sm mb-4"><i class="bi bi-exclamation-triangle-fill me-2"></i> <%= request.getAttribute("error") %></div>
    <% } %>

    <div class="card upload-card p-4 mb-4">
        <h5 class="fw-bold mb-4" style="color: var(--drdo-teal)">Resume / CV</h5>
        <form action="upload-document" method="POST" enctype="multipart/form-data">
            <div class="row g-4">
                <div class="col-md-4">
                    <label class="form-label">Document Category</label>
                    <select name="documentType" class="form-select" required>
                        <option value="resume">Resume / CV</option>
                        <option value="portfolio">Portfolio</option>
                        <option value="other">Other Supporting Docs</option>
                    </select>
                </div>
                <div class="col-md-5">
                    <label class="form-label">Select File (PDF or Image)</label>
                    <input type="file" name="file" class="form-control" accept=".pdf,.jpg,.jpeg,.png" required>
                </div>
                <div class="col-md-3 d-flex align-items-end">
                    <button type="submit" class="btn btn-primary w-100 py-2">UPLOAD RESUME</button>
                </div>
            </div>
        </form>
    </div>

    <div class="card upload-card p-4 mb-4">
        <h5 class="fw-bold mb-4" style="color: var(--drdo-teal)">Secondary Education (12th)</h5>
        <form action="upload-document" method="POST" enctype="multipart/form-data">
            <div class="row g-4">
                <div class="col-md-4">
                    <label class="form-label">Examining Board</label>
                    <select name="documentType" class="form-select" required>
                        <option value="cbse">CBSE</option>
                        <option value="icse">ICSE</option>
                        <option value="state_board">State Board</option>
                        <option value="other">Other</option>
                    </select>
                </div>
                <div class="col-md-5">
                    <label class="form-label">12th Marksheet/Certificate</label>
                    <input type="file" name="file" class="form-control" accept=".pdf,.jpg,.jpeg,.png" required>
                </div>
                <div class="col-md-3 d-flex align-items-end">
                    <button type="submit" class="btn btn-primary w-100 py-2">UPLOAD 12TH DOC</button>
                </div>
            </div>
        </form>
    </div>
    <div class="card upload-card p-4 mb-4">
        <h5 class="fw-bold mb-4" style="color: var(--drdo-teal)">Secondary Education (10th)</h5>
        <form action="upload-document" method="POST" enctype="multipart/form-data">
            <div class="row g-4">
                <div class="col-md-4">
                    <label class="form-label">Examining Board</label>
                    <select name="documentType" class="form-select" required>
                        <option value="cbse">CBSE</option>
                        <option value="icse">ICSE</option>
                        <option value="state_board">State Board</option>
                        <option value="other">Other</option>
                    </select>
                </div>
                <div class="col-md-5">
                    <label class="form-label">10th Marksheet/Certificate</label>
                    <input type="file" name="file" class="form-control" accept=".pdf,.jpg,.jpeg,.png" required>
                </div>
                <div class="col-md-3 d-flex align-items-end">
                    <button type="submit" class="btn btn-primary w-100 py-2">UPLOAD 10TH DOC</button>
                </div>
            </div>
        </form>
    </div>

    <div class="card upload-card p-4 mb-4">
        <h5 class="fw-bold mb-4" style="color: var(--drdo-teal)">Identity Verification</h5>
        <form action="upload-document" method="POST" enctype="multipart/form-data">
            <div class="row g-4">
                <div class="col-md-4">
                    <label class="form-label">Valid Government ID</label>
                    <select name="documentType" class="form-select" required>
                        <option value="aadhaar">Aadhaar Card</option>
                        <option value="pan">PAN Card</option>
                        <option value="voter_id">Voter ID</option>
                        <option value="passport">Passport</option>
                    </select>
                </div>
                <div class="col-md-5">
                    <label class="form-label">Upload Front Side</label>
                    <input type="file" name="file" class="form-control" accept=".pdf,.jpg,.jpeg,.png" required>
                </div>
                <div class="col-md-3 d-flex align-items-end">
                    <button type="submit" class="btn btn-primary w-100 py-2">UPLOAD ID</button>
                </div>
            </div>
        </form>
    </div>

    <h5 class="fw-bold mb-3" style="color: var(--drdo-dark);">Uploaded Document Registry</h5>
    <% List<Document> docs = (List<Document>) request.getAttribute("documents"); %>
    <% if(docs != null && !docs.isEmpty()) { %>
    <div class="card">
        <div class="table-responsive">
            <table class="table align-middle mb-0">
                <thead>
                    <tr>
                        <th class="ps-3">#</th>
                        <th>Document Reference</th>
                        <th>Classification</th>
                        <th>Upload Timestamp</th>
                    </tr>
                </thead>
                <tbody>
                <% int c = 1; for(Document d : docs) { %>
                <tr>
                    <td class="ps-3 text-muted"><%= c++ %></td>
                    <td class="fw-bold"><i class="bi bi-file-earmark-text me-2" style="color: var(--drdo-teal);"></i> <%= d.getDocumentName() %></td>
                    <td><span class="badge bg-secondary"><%= d.getDocumentType() %></span></td>
                    <td class="text-muted"><%= d.getUploadedAt() %></td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>
    <% } else { %>
    <div class="card p-5 text-center text-muted border-dashed">
        <i class="bi bi-folder2-open mb-2" style="font-size: 3rem;"></i>
        <p class="mb-0">No documents found in your official record. Upload evidence above to begin verification.</p>
    </div>
    <% } %>
</div>

<footer class="footer text-center">
    <div class="container">
        <p class="mb-0 small text-muted">VisionRecruit Recruitment Division &copy; 2026. Secure Vault Active.</p>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
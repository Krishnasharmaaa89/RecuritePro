<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Smart Job Portal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Public+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --drdo-teal: #005a5a;
            --drdo-dark: #003d3d;
            --drdo-bg: #f0f4f4;
        }

        body {
            font-family: 'Public Sans', sans-serif;
            background-color: var(--drdo-bg);
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0;
        }

        .auth-card {
            background: #ffffff;
            padding: 2.5rem;
            border-radius: 4px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
            border-top: 5px solid var(--drdo-teal);
            width: 100%;
            max-width: 420px;
        }

        .auth-card h2 {
            color: var(--drdo-dark);
            font-weight: 700;
            letter-spacing: -0.5px;
        }

        .subtitle {
            color: #666;
            font-size: 0.95rem;
        }

        /* Input Styling */
        .form-control:focus {
            border-color: var(--drdo-teal);
            box-shadow: 0 0 0 0.25rem rgba(0, 90, 90, 0.15);
        }

        .input-group-text {
            background-color: #f8f9fa;
            color: var(--drdo-teal);
        }

        /* Button Styling */
        .btn-primary {
            background-color: var(--drdo-teal);
            border-color: var(--drdo-teal);
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            background-color: var(--drdo-dark);
            border-color: var(--drdo-dark);
        }

        .text-primary {
            color: var(--drdo-teal) !important;
        }

        a {
            color: var(--drdo-teal);
            transition: color 0.2s;
        }

        a:hover {
            color: var(--drdo-dark);
        }
    </style>
</head>
<body>

<div class="container d-flex justify-content-center">
    <div class="auth-card">
        <div class="text-center mb-4">
            <i class="bi bi-shield-lock-fill text-primary" style="font-size: 3rem;"></i>
            <h2 class="mt-3">User Login</h2>
            <p class="subtitle">Access your recruitment dashboard</p>
        </div>

        <% if(request.getAttribute("error") != null) { %>
            <div class="alert alert-danger alert-dismissible fade show border-0 shadow-sm" role="alert">
                <i class="bi bi-exclamation-triangle-fill me-2"></i> <%= request.getAttribute("error") %>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        <% } %>

        <% if(request.getAttribute("success") != null) { %>
            <div class="alert alert-success alert-dismissible fade show border-0 shadow-sm" role="alert">
                <i class="bi bi-check-circle-fill me-2"></i> <%= request.getAttribute("success") %>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        <% } %>

        <form action="login" method="POST">
            <div class="mb-3">
                <label class="form-label fw-bold small text-uppercase" style="letter-spacing: 0.5px;">Email Address</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="bi bi-envelope-fill"></i></span>
                    <input type="email" name="email" class="form-control" placeholder="name@example.com" required>
                </div>
            </div>
            
            <div class="mb-4">
                <label class="form-label fw-bold small text-uppercase" style="letter-spacing: 0.5px;">Password</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="bi bi-key-fill"></i></span>
                    <input type="password" name="password" class="form-control" placeholder="••••••••" required>
                </div>
            </div>

            <button type="submit" class="btn btn-primary w-100 py-2 fw-bold text-uppercase" style="letter-spacing: 1px;">
                Secure Sign In <i class="bi bi-arrow-right-short"></i>
            </button>
        </form>

        <div class="mt-4 pt-3 border-top">
            <p class="text-center mb-1">
                New user? <a href="register" class="text-decoration-none fw-bold">Create an account</a>
            </p>
            <p class="text-center mb-0">
                <a href="index.html" class="text-muted small text-decoration-none">
                    <i class="bi bi-house-door"></i> Return to Portal Home
                </a>
            </p>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
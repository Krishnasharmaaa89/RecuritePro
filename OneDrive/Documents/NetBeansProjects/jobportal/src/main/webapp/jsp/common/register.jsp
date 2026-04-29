<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Smart Job Portal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Public+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --drdo-teal: #005a5a;
            --drdo-dark: #003d3d;
            --drdo-bg: #f4f7f7;
        }

        body {
            font-family: 'Public Sans', sans-serif;
            background-color: var(--drdo-bg);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px 0;
        }

        .auth-card {
            background: #ffffff;
            padding: 2.5rem;
            border-radius: 4px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.08);
            border-top: 5px solid var(--drdo-teal);
            width: 100%;
            max-width: 480px;
        }

        .auth-card h2 {
            color: var(--drdo-dark);
            font-weight: 700;
            letter-spacing: -0.5px;
        }

        .subtitle {
            color: #666;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        /* Input Styling */
        .form-label {
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            color: #444;
        }

        .form-control:focus {
            border-color: var(--drdo-teal);
            box-shadow: 0 0 0 0.25rem rgba(0, 90, 90, 0.1);
        }

        .input-group-text {
            background-color: #f8f9fa;
            color: var(--drdo-teal);
            border-right: none;
        }
        
        .form-control {
            border-left: none;
        }

        /* Button Styling */
        .btn-primary {
            background-color: var(--drdo-teal);
            border-color: var(--drdo-teal);
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            padding: 12px;
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
            text-decoration: none;
            transition: color 0.2s;
        }

        a:hover {
            color: var(--drdo-dark);
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="container d-flex justify-content-center">
    <div class="auth-card">
        <div class="text-center mb-4">
            <i class="bi bi-person-badge-fill text-primary" style="font-size: 3rem;"></i>
            <h2 class="mt-3">Candidate Registration</h2>
            <p class="subtitle">Join the recruitment portal</p>
        </div>

        <% if(request.getAttribute("error") != null) { %>
            <div class="alert alert-danger alert-dismissible fade show border-0 shadow-sm" role="alert">
                <i class="bi bi-exclamation-circle-fill me-2"></i> <%= request.getAttribute("error") %>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        <% } %>

        <form action="register" method="POST" id="registerForm">
            <div class="mb-3">
                <label class="form-label fw-bold">Full Name</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="bi bi-person-fill"></i></span>
                    <input type="text" name="name" class="form-control" placeholder="As per official documents" required>
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label fw-bold">Email Address</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="bi bi-envelope-at-fill"></i></span>
                    <input type="email" name="email" class="form-control" placeholder="yourname@example.com" required>
                </div>
            </div>

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label fw-bold">Password</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-shield-lock-fill"></i></span>
                        <input type="password" name="password" class="form-control" placeholder="Min 6 chars" required minlength="6">
                    </div>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label fw-bold">Confirm</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-lock-fill"></i></span>
                        <input type="password" name="confirmPassword" class="form-control" placeholder="Re-type" required>
                    </div>
                </div>
            </div>

            <button type="submit" class="btn btn-primary w-100 mt-2">
                Create Account <i class="bi bi-chevron-right ms-1"></i>
            </button>
        </form>

        <div class="mt-4 pt-3 border-top text-center">
            <p class="mb-1">Already registered? <a href="login" class="fw-bold">Sign In here</a></p>
            <a href="index.html" class="text-muted small">
                <i class="bi bi-arrow-left"></i> Return to Main Page
            </a>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
// Client-side password match validation
document.getElementById('registerForm').addEventListener('submit', function(e) {
    var pwd = this.querySelector('[name="password"]').value;
    var cpwd = this.querySelector('[name="confirmPassword"]').value;
    if (pwd !== cpwd) { 
        e.preventDefault(); 
        alert('Error: Passwords do not match. Please verify and try again.'); 
    }
});
</script>
</body>
</html>
package com.jobportal.servlet;

import com.jobportal.dao.UserDAO;
import com.jobportal.dao.ApplicantDAO;
import com.jobportal.model.User;
import com.jobportal.model.Applicant;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

/**
 * LoginServlet.java - Handles user authentication.
 * URL: /login (GET = show form, POST = authenticate)
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();
    private ApplicantDAO applicantDAO = new ApplicantDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/jsp/common/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Authenticate user
        User user = userDAO.loginUser(email, password);

        if (user != null) {
            // Create session and store user info
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("userId", user.getId());
            session.setAttribute("userName", user.getName());
            session.setAttribute("userRole", user.getRole());
            session.setMaxInactiveInterval(30 * 60); // 30 minutes

            // If applicant, also store applicant profile ID
            if ("applicant".equals(user.getRole())) {
                Applicant applicant = applicantDAO.getByUserId(user.getId());
                if (applicant != null) {
                    session.setAttribute("applicantId", applicant.getId());
                }
                response.sendRedirect("applicant-dashboard");
            } else {
                // Admin
                response.sendRedirect("admin-dashboard");
            }
        } else {
            request.setAttribute("error", "Invalid email or password!");
            request.getRequestDispatcher("/jsp/common/login.jsp").forward(request, response);
        }
    }
}

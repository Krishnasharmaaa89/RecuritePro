package com.jobportal.servlet;

import com.jobportal.dao.*;
import com.jobportal.model.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

/**
 * AdminDashboardServlet.java - Admin dashboard with analytics summary.
 * URL: /admin-dashboard
 */
@WebServlet("/admin-dashboard")
public class AdminDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("userRole"))) {
            response.sendRedirect("login");
            return;
        }

        JobDAO jobDAO = new JobDAO();
        ApplicantDAO applicantDAO = new ApplicantDAO();
        ApplicationDAO appDAO = new ApplicationDAO();
        InterviewDAO interviewDAO = new InterviewDAO();

        request.setAttribute("totalJobs", jobDAO.getAllJobs().size());
        request.setAttribute("totalApplicants", applicantDAO.getAllApplicants().size());
        request.setAttribute("totalApplications", appDAO.getAllApplications().size());
        request.setAttribute("totalInterviews", interviewDAO.getAllInterviews().size());

        // Recent applications
        List<Application> recentApps = appDAO.getAllApplications();
        request.setAttribute("recentApplications", recentApps.subList(0, Math.min(5, recentApps.size())));

        request.getRequestDispatcher("/jsp/admin/admin-dashboard.jsp").forward(request, response);
    }
}

package com.jobportal.servlet;

import com.jobportal.dao.*;
import com.jobportal.model.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

/**
 * ApplicantListServlet.java - Admin view of all applicants and their applications.
 * URL: /applicant-list
 */
@WebServlet("/applicant-list")
public class ApplicantListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("userRole"))) {
            response.sendRedirect("login");
            return;
        }

        String jobIdParam = request.getParameter("jobId");

        ApplicationDAO appDAO = new ApplicationDAO();
        List<Application> applications;

        if (jobIdParam != null && !jobIdParam.isEmpty()) {
            int jobId = Integer.parseInt(jobIdParam);
            applications = appDAO.getByJobId(jobId);
            JobDAO jobDAO = new JobDAO();
            Job job = jobDAO.getById(jobId);
            request.setAttribute("selectedJob", job);
        } else {
            applications = appDAO.getAllApplications();
        }

        // Handle status update
        String action = request.getParameter("action");
        if ("updateStatus".equals(action)) {
            int appId = Integer.parseInt(request.getParameter("appId"));
            String status = request.getParameter("status");
            appDAO.updateStatus(appId, status);
            response.sendRedirect("applicant-list" + (jobIdParam != null ? "?jobId=" + jobIdParam : ""));
            return;
        }

        request.setAttribute("applications", applications);

        // Also load all jobs for filter dropdown
        JobDAO jobDAO = new JobDAO();
        request.setAttribute("allJobs", jobDAO.getAllJobs());

        request.getRequestDispatcher("/jsp/admin/applicant-list.jsp").forward(request, response);
    }
}

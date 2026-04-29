package com.jobportal.servlet;

import com.jobportal.dao.*;
import com.jobportal.model.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

/**
 * ApplyJobServlet.java - Handles job application by applicants.
 * URL: /apply-job
 */
@WebServlet("/apply-job")
public class ApplyJobServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("applicantId") == null) {
            response.sendRedirect("profile");
            return;
        }

        int applicantId = (int) session.getAttribute("applicantId");
        ApplicationDAO appDAO = new ApplicationDAO();
        List<Application> applications = appDAO.getByApplicantId(applicantId);
        request.setAttribute("applications", applications);
        request.getRequestDispatcher("/jsp/applicant/apply-job.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("applicantId") == null) {
            response.sendRedirect("login");
            return;
        }

        int applicantId = (int) session.getAttribute("applicantId");
        int jobId = Integer.parseInt(request.getParameter("jobId"));

        ApplicationDAO appDAO = new ApplicationDAO();
        if (appDAO.applyForJob(applicantId, jobId)) {
            request.setAttribute("success", "Application submitted successfully!");
        } else {
            request.setAttribute("error", "You have already applied for this job.");
        }

        // Refresh list
        List<Application> applications = appDAO.getByApplicantId(applicantId);
        request.setAttribute("applications", applications);
        request.getRequestDispatcher("/jsp/applicant/apply-job.jsp").forward(request, response);
    }
}

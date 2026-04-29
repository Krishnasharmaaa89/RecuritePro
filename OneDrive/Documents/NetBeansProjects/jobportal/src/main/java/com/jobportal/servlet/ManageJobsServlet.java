package com.jobportal.servlet;

import com.jobportal.dao.JobDAO;
import com.jobportal.model.Job;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

/**
 * ManageJobsServlet.java - CRUD operations for job listings (Admin).
 * URL: /manage-jobs
 */
@WebServlet("/manage-jobs")
public class ManageJobsServlet extends HttpServlet {

    private JobDAO jobDAO = new JobDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("userRole"))) {
            response.sendRedirect("login");
            return;
        }

        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            int jobId = Integer.parseInt(request.getParameter("id"));
            jobDAO.deleteJob(jobId);
            response.sendRedirect("manage-jobs");
            return;
        }

        if ("edit".equals(action)) {
            int jobId = Integer.parseInt(request.getParameter("id"));
            Job job = jobDAO.getById(jobId);
            request.setAttribute("editJob", job);
        }

        request.setAttribute("jobs", jobDAO.getAllJobs());
        request.getRequestDispatcher("/jsp/admin/manage-jobs.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("userRole"))) {
            response.sendRedirect("login");
            return;
        }

        Job job = new Job();
        job.setTitle(request.getParameter("title"));
        job.setCompany(request.getParameter("company"));
        job.setLocation(request.getParameter("location"));
        job.setDescription(request.getParameter("description"));
        job.setRequirements(request.getParameter("requirements"));
        job.setActive(true);

        String jobId = request.getParameter("jobId");
        if (jobId != null && !jobId.isEmpty()) {
            // Update existing
            job.setId(Integer.parseInt(jobId));
            jobDAO.updateJob(job);
            request.setAttribute("success", "Job updated successfully!");
        } else {
            // Create new
            jobDAO.createJob(job);
            request.setAttribute("success", "Job posted successfully!");
        }

        request.setAttribute("jobs", jobDAO.getAllJobs());
        request.getRequestDispatcher("/jsp/admin/manage-jobs.jsp").forward(request, response);
    }
}

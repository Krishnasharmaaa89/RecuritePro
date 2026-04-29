package com.jobportal.servlet;

import com.jobportal.dao.JobDAO;
import com.jobportal.model.Job;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

/**
 * JobListServlet.java - Shows available jobs to applicants with search.
 * URL: /jobs
 */
@WebServlet("/jobs")
public class JobListServlet extends HttpServlet {

    private JobDAO jobDAO = new JobDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String search = request.getParameter("search");
        List<Job> jobs;

        if (search != null && !search.trim().isEmpty()) {
            jobs = jobDAO.searchJobs(search.trim());
            request.setAttribute("searchQuery", search);
        } else {
            jobs = jobDAO.getActiveJobs();
        }

        // Pagination
        int page = 1;
        int pageSize = 5;
        try { page = Integer.parseInt(request.getParameter("page")); } catch (Exception e) {}
        int totalJobs = jobs.size();
        int totalPages = (int) Math.ceil((double) totalJobs / pageSize);
        int fromIndex = (page - 1) * pageSize;
        int toIndex = Math.min(fromIndex + pageSize, totalJobs);

        List<Job> pagedJobs = jobs.subList(fromIndex, toIndex);

        request.setAttribute("jobs", pagedJobs);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("/jsp/applicant/job-list.jsp").forward(request, response);
    }
}

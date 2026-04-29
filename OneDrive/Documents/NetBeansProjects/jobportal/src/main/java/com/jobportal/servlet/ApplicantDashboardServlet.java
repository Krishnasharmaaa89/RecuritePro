package com.jobportal.servlet;

import com.jobportal.dao.*;
import com.jobportal.model.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

/**
 * ApplicantDashboardServlet.java - Shows applicant dashboard with summary.
 * URL: /applicant-dashboard
 */
@WebServlet("/applicant-dashboard")
public class ApplicantDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null || !"applicant".equals(session.getAttribute("userRole"))) {
            response.sendRedirect("login");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        ApplicantDAO applicantDAO = new ApplicantDAO();
        Applicant applicant = applicantDAO.getByUserId(userId);

        if (applicant != null) {
            session.setAttribute("applicantId", applicant.getId());

            // Get applications count
            ApplicationDAO appDAO = new ApplicationDAO();
            List<Application> applications = appDAO.getByApplicantId(applicant.getId());
            request.setAttribute("applicationCount", applications.size());

            // Get interviews
            InterviewDAO interviewDAO = new InterviewDAO();
            List<Interview> interviews = interviewDAO.getByApplicantId(applicant.getId());
            request.setAttribute("interviewCount", interviews.size());

            // Get documents
            DocumentDAO docDAO = new DocumentDAO();
            List<Document> documents = docDAO.getByApplicantId(applicant.getId());
            request.setAttribute("documentCount", documents.size());

            request.setAttribute("applicant", applicant);
            request.setAttribute("hasProfile", true);
        } else {
            request.setAttribute("hasProfile", false);
        }

        request.getRequestDispatcher("/jsp/applicant/dashboard.jsp").forward(request, response);
    }
}

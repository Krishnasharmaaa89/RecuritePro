package com.jobportal.servlet;

import com.jobportal.dao.InterviewDAO;
import com.jobportal.model.Interview;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

/**
 * InterviewStatusServlet.java - Shows interview schedule to applicant.
 * URL: /interview-status
 */
@WebServlet("/interview-status")
public class InterviewStatusServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("applicantId") == null) {
            response.sendRedirect("login");
            return;
        }

        int applicantId = (int) session.getAttribute("applicantId");
        InterviewDAO interviewDAO = new InterviewDAO();
        List<Interview> interviews = interviewDAO.getByApplicantId(applicantId);
        request.setAttribute("interviews", interviews);

        request.getRequestDispatcher("/jsp/applicant/interview-status.jsp").forward(request, response);
    }
}

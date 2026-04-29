package com.jobportal.servlet;

import com.jobportal.dao.*;
import com.jobportal.model.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/schedule-interview")
public class ScheduleInterviewServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("userRole"))) {
            response.sendRedirect("login");
            return;
        }

        String appIdStr = request.getParameter("applicationId");
        if (appIdStr == null || appIdStr.isEmpty()) {
            session.setAttribute("errorMsg", "Missing application reference.");
            response.sendRedirect("applicant-list");
            return;
        }
// Replace your line 28 logic with this defensive code
String appIdParam = request.getParameter("applicationId");

if (appIdParam != null && !appIdParam.isEmpty()) {
    try {
        int applicationId = Integer.parseInt(appIdParam);
        ApplicationDAO appDAO = new ApplicationDAO();
        Application app = appDAO.getById(applicationId);
        request.setAttribute("application", app);
    } catch (NumberFormatException e) {
        // Handle cases where the ID is not a number
        System.out.println("Invalid ID format: " + appIdParam);
    }
} else {
    // If ID is null, we can either fetch all interviews or redirect
    System.out.println("No Application ID provided in URL.");
}

// Continue to fetch general interview list
InterviewDAO interviewDAO = new InterviewDAO();
request.setAttribute("interviews", interviewDAO.getAllInterviews());
request.getRequestDispatcher("/jsp/admin/schedule-interview.jsp").forward(request, response);
        try {
            int applicationId = Integer.parseInt(appIdStr);
            ApplicationDAO appDAO = new ApplicationDAO();
            Application app = appDAO.getById(applicationId);
            if (app == null) {
                session.setAttribute("errorMsg", "Application not found.");
                response.sendRedirect("applicant-list");
                return;
            }
            request.setAttribute("application", app);
            request.getRequestDispatcher("/jsp/admin/schedule-interview.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            session.setAttribute("errorMsg", "Invalid application reference.");
            response.sendRedirect("applicant-list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("userRole"))) {
            response.sendRedirect("login");
            return;
        }

        String appIdStr = request.getParameter("applicationId");
        if (appIdStr == null || appIdStr.isEmpty()) {
            session.setAttribute("errorMsg", "Missing application reference.");
            response.sendRedirect("applicant-list");
            return;
        }

        int applicationId;
        try {
            applicationId = Integer.parseInt(appIdStr);
        } catch (NumberFormatException e) {
            session.setAttribute("errorMsg", "Invalid application reference.");
            response.sendRedirect("applicant-list");
            return;
        }

        try {
            Interview interview = new Interview();
            interview.setApplicationId(applicationId);
            interview.setInterviewDate(request.getParameter("interviewDate"));
            interview.setInterviewTime(request.getParameter("interviewTime"));
            interview.setMode(request.getParameter("mode"));
            interview.setMeetingLink(request.getParameter("meetingLink"));
            interview.setLocation(request.getParameter("location"));

            InterviewDAO interviewDAO = new InterviewDAO();
            if (interviewDAO.scheduleInterview(interview)) {
                ApplicationDAO appDAO = new ApplicationDAO();
                appDAO.updateStatus(applicationId, "interview_scheduled");

                session.setAttribute("successMsg", "Interview successfully scheduled for application #" + applicationId);
                response.sendRedirect("applicant-list");
            } else {
                session.setAttribute("errorMsg", "Database error: Could not save interview.");
                response.sendRedirect("applicant-list");
            }
        } catch (Exception e) {
            session.setAttribute("errorMsg", "Unexpected error occurred while scheduling interview.");
            response.sendRedirect("applicant-list");
        }
    }
}

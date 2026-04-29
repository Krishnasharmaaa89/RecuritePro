package com.jobportal.servlet;

import com.jobportal.dao.ApplicantDAO;
import com.jobportal.model.Applicant;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

/**
 * ProfileServlet.java - Handles applicant profile creation and updates.
 * URL: /profile
 */
@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

    private ApplicantDAO applicantDAO = new ApplicantDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        Applicant applicant = applicantDAO.getByUserId(userId);
        if (applicant != null) {
            request.setAttribute("applicant", applicant);
        }

        request.getRequestDispatcher("/jsp/applicant/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login");
            return;
        }

        int userId = (int) session.getAttribute("userId");

        // Build applicant object from form
        Applicant applicant = new Applicant();
        applicant.setUserId(userId);
        applicant.setFullName(request.getParameter("fullName"));
        applicant.setFatherName(request.getParameter("fatherName"));
        applicant.setDob(request.getParameter("dob"));
        applicant.setQualification(request.getParameter("qualification"));
        applicant.setSkills(request.getParameter("skills"));
        applicant.setExperience(Integer.parseInt(request.getParameter("experience")));
        applicant.setCategory(request.getParameter("category"));

        // Check if profile exists - update or create
        Applicant existing = applicantDAO.getByUserId(userId);
        boolean success;
        if (existing != null) {
            success = applicantDAO.updateProfile(applicant);
        } else {
            success = applicantDAO.createProfile(applicant);
        }

        if (success) {
            // Refresh applicant ID in session
            Applicant updated = applicantDAO.getByUserId(userId);
            session.setAttribute("applicantId", updated.getId());
            request.setAttribute("success", "Profile saved successfully!");
        } else {
            request.setAttribute("error", "Failed to save profile.");
        }

        request.setAttribute("applicant", applicantDAO.getByUserId(userId));
        request.getRequestDispatcher("/jsp/applicant/profile.jsp").forward(request, response);
    }
}

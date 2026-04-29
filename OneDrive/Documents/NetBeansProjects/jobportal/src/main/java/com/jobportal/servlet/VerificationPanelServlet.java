package com.jobportal.servlet;

import com.jobportal.dao.*;
import com.jobportal.model.*;
import com.jobportal.util.VerificationEngine;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.*;

/**
 * VerificationPanelServlet.java - Admin panel to view/compare verification results.
 * URL: /verification-panel
 */
@WebServlet("/verification-panel")
public class VerificationPanelServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("userRole"))) {
            response.sendRedirect("login");
            return;
        }

        int applicantId = Integer.parseInt(request.getParameter("applicantId"));

        ApplicantDAO applicantDAO = new ApplicantDAO();
        VerificationDAO verDAO = new VerificationDAO();

        Applicant applicant = applicantDAO.getById(applicantId);
        List<VerificationResult> results = verDAO.getByApplicantId(applicantId);

        request.setAttribute("applicant", applicant);
        request.setAttribute("results", results);
        request.getRequestDispatcher("/jsp/admin/verification-panel.jsp").forward(request, response);
    }
}

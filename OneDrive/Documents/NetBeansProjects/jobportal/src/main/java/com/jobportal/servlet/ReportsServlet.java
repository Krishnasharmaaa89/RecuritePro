package com.jobportal.servlet;

import com.jobportal.dao.*;
import com.jobportal.model.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;

/**
 * ReportsServlet.java - Generates reports for admin.
 * URL: /reports
 */
@WebServlet("/reports")
public class ReportsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("userRole"))) {
            response.sendRedirect("login");
            return;
        }

        ApplicantDAO applicantDAO = new ApplicantDAO();
        VerificationDAO verDAO = new VerificationDAO();
        InterviewDAO interviewDAO = new InterviewDAO();

        List<Applicant> allApplicants = applicantDAO.getAllApplicants();

        // Verified candidates: all fields verified
        List<Applicant> verified = new ArrayList<>();
        List<Applicant> mismatch = new ArrayList<>();

        for (Applicant a : allApplicants) {
            List<VerificationResult> results = verDAO.getByApplicantId(a.getId());
            if (results.isEmpty()) continue;

            boolean allVerified = results.stream().allMatch(r -> "VERIFIED".equals(r.getMatchStatus()));
            boolean hasMismatch = results.stream().anyMatch(r -> "MISMATCH".equals(r.getMatchStatus()));

            if (allVerified) verified.add(a);
            if (hasMismatch) mismatch.add(a);
        }

        request.setAttribute("verifiedCandidates", verified);
        request.setAttribute("mismatchCandidates", mismatch);
        request.setAttribute("interviews", interviewDAO.getAllInterviews());

        request.getRequestDispatcher("/jsp/admin/reports.jsp").forward(request, response);
    }
}

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
 * VerificationServlet.java - Runs verification comparing form data vs extracted data.
 * URL: /verification
 */
@WebServlet("/verification")
public class VerificationServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("applicantId") == null) {
            response.sendRedirect("login");
            return;
        }

        int applicantId = (int) session.getAttribute("applicantId");

        // Get existing verification results
        VerificationDAO verDAO = new VerificationDAO();
        List<VerificationResult> results = verDAO.getByApplicantId(applicantId);

        // If no results yet, run verification
        if (results.isEmpty()) {
            runVerification(applicantId);
            results = verDAO.getByApplicantId(applicantId);
        }

        request.setAttribute("results", results);
        request.getRequestDispatcher("/jsp/applicant/verification-result.jsp").forward(request, response);
    }

    /**
     * Runs the verification process for an applicant.
     * Compares form-entered profile data with data extracted from documents.
     */
    private void runVerification(int applicantId) {
        ApplicantDAO applicantDAO = new ApplicantDAO();
        DocumentDAO docDAO = new DocumentDAO();
        ExtractedDataDAO edDAO = new ExtractedDataDAO();
        VerificationDAO verDAO = new VerificationDAO();

        Applicant applicant = applicantDAO.getById(applicantId);
        if (applicant == null) return;

        // Clear old results
        verDAO.deleteByApplicantId(applicantId);

        // Build form data map
        Map<String, String> formData = new HashMap<>();
        formData.put("name", applicant.getFullName());
        formData.put("father_name", applicant.getFatherName());
        formData.put("qualification", applicant.getQualification());
        formData.put("skills", applicant.getSkills());
        formData.put("experience", String.valueOf(applicant.getExperience()));
        formData.put("category", applicant.getCategory());

        // Get all extracted data across all documents
        Map<String, String> extractedMap = new HashMap<>();
        List<Document> documents = docDAO.getByApplicantId(applicantId);
        for (Document doc : documents) {
            List<ExtractedData> dataList = edDAO.getByDocumentId(doc.getId());
            for (ExtractedData ed : dataList) {
                extractedMap.put(ed.getFieldName(), ed.getExtractedValue());
            }
        }

        // Compare each field
        for (Map.Entry<String, String> entry : formData.entrySet()) {
            String fieldName = entry.getKey();
            String formValue = entry.getValue();
            String extractedValue = extractedMap.get(fieldName);

            String matchStatus = VerificationEngine.compare(formValue, extractedValue);

            VerificationResult vr = new VerificationResult();
            vr.setApplicantId(applicantId);
            vr.setFieldName(fieldName);
            vr.setFormValue(formValue);
            vr.setExtractedValue(extractedValue != null ? extractedValue : "N/A");
            vr.setMatchStatus(matchStatus);
            verDAO.save(vr);
        }
    }
}

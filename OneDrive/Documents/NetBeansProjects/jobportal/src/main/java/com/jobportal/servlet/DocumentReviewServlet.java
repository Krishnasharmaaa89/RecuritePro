package com.jobportal.servlet;

import com.jobportal.dao.*;
import com.jobportal.model.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.*;

/**
 * DocumentReviewServlet.java - Admin views uploaded documents and extracted data.
 * URL: /document-review
 */
@WebServlet("/document-review")
public class DocumentReviewServlet extends HttpServlet {

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
        DocumentDAO docDAO = new DocumentDAO();
        ExtractedDataDAO edDAO = new ExtractedDataDAO();

        Applicant applicant = applicantDAO.getById(applicantId);
        List<Document> documents = docDAO.getByApplicantId(applicantId);
        Map<Document, List<ExtractedData>> docDataMap = new LinkedHashMap<>();

        for (Document doc : documents) {
            List<ExtractedData> data = edDAO.getByDocumentId(doc.getId());
            docDataMap.put(doc, data);
        }

        request.setAttribute("applicant", applicant);
        request.setAttribute("docDataMap", docDataMap);
        request.getRequestDispatcher("/jsp/admin/document-review.jsp").forward(request, response);
    }
}

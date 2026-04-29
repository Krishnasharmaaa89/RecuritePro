package com.jobportal.servlet;

import com.jobportal.dao.*;
import com.jobportal.model.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.*;

/**
 * ExtractedDataServlet.java - Shows extracted data from uploaded documents.
 * URL: /extracted-data
 */
@WebServlet("/extracted-data")
public class ExtractedDataServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("applicantId") == null) {
            response.sendRedirect("login");
            return;
        }

        int applicantId = (int) session.getAttribute("applicantId");

        DocumentDAO docDAO = new DocumentDAO();
        ExtractedDataDAO edDAO = new ExtractedDataDAO();

        List<Document> documents = docDAO.getByApplicantId(applicantId);
        Map<Document, List<ExtractedData>> docDataMap = new LinkedHashMap<>();

        for (Document doc : documents) {
            List<ExtractedData> data = edDAO.getByDocumentId(doc.getId());
            docDataMap.put(doc, data);
        }

        request.setAttribute("docDataMap", docDataMap);
        request.getRequestDispatcher("/jsp/applicant/extracted-data.jsp").forward(request, response);
    }
}

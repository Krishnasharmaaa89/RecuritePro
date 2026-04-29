package com.jobportal.servlet;

import com.jobportal.dao.*;
import com.jobportal.model.*;
import com.jobportal.util.DocumentExtractor;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;
import java.util.List;
import java.util.Map;

/**
 * UploadDocumentServlet.java - Handles document upload and triggers extraction.
 * URL: /upload-document
 * Uses Servlet 3.0+ @MultipartConfig for file upload.
 */
@WebServlet("/upload-document")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,     // 1MB
    maxFileSize = 5 * 1024 * 1024,       // 5MB
    maxRequestSize = 10 * 1024 * 1024    // 10MB
)
public class UploadDocumentServlet extends HttpServlet {

    // Directory to store uploaded files (relative to webapp)
    private static final String UPLOAD_DIR = "uploads";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("applicantId") == null) {
            response.sendRedirect("profile");
            return;
        }

        int applicantId = (int) session.getAttribute("applicantId");
        DocumentDAO docDAO = new DocumentDAO();
        List<Document> documents = docDAO.getByApplicantId(applicantId);
        request.setAttribute("documents", documents);

        request.getRequestDispatcher("/jsp/applicant/upload-documents.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("applicantId") == null) {
            response.sendRedirect("login");
            return;
        }

        int applicantId = (int) session.getAttribute("applicantId");
        String documentType = request.getParameter("documentType");

        // Get the uploaded file
        Part filePart = request.getPart("file");
        String fileName = getFileName(filePart);

        if (fileName == null || fileName.isEmpty()) {
            request.setAttribute("error", "Please select a file to upload.");
            doGet(request, response);
            return;
        }

        // Create upload directory if not exists
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        // Save file
        String filePath = uploadPath + File.separator + System.currentTimeMillis() + "_" + fileName;
        filePart.write(filePath);

        // Save document record to DB
        Document doc = new Document();
        doc.setApplicantId(applicantId);
        doc.setDocumentName(fileName);
        doc.setDocumentType(documentType);
        doc.setFilePath(filePath);

        DocumentDAO docDAO = new DocumentDAO();
        int documentId = docDAO.saveDocument(doc);

        if (documentId > 0) {
            // Simulate document extraction
            ApplicantDAO applicantDAO = new ApplicantDAO();
            Applicant applicant = applicantDAO.getById(applicantId);
            String applicantName = applicant != null ? applicant.getFullName() : "Unknown";

            Map<String, String> extractedFields = DocumentExtractor.extract(documentType, fileName, applicantName);

            // Save extracted data
            ExtractedDataDAO edDAO = new ExtractedDataDAO();
            for (Map.Entry<String, String> entry : extractedFields.entrySet()) {
                ExtractedData ed = new ExtractedData();
                ed.setDocumentId(documentId);
                ed.setFieldName(entry.getKey());
                ed.setExtractedValue(entry.getValue());
                edDAO.save(ed);
            }

            request.setAttribute("success", "Document uploaded and data extracted successfully!");
        } else {
            request.setAttribute("error", "Failed to upload document.");
        }

        doGet(request, response);
    }

    /**
     * Extracts the file name from the Part header.
     */
    private String getFileName(Part part) {
        String header = part.getHeader("content-disposition");
        for (String token : header.split(";")) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }
}

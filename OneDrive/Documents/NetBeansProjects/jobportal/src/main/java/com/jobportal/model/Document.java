package com.jobportal.model;

/**
 * Document.java - Model class for uploaded documents.
 * Maps to the 'documents' table.
 */
public class Document {
    private int id;
    private int applicantId;
    private String documentName;
    private String documentType; // resume, educational, marksheet, experience, category
    private String filePath;
    private String uploadedAt;

    public Document() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getApplicantId() { return applicantId; }
    public void setApplicantId(int applicantId) { this.applicantId = applicantId; }

    public String getDocumentName() { return documentName; }
    public void setDocumentName(String documentName) { this.documentName = documentName; }

    public String getDocumentType() { return documentType; }
    public void setDocumentType(String documentType) { this.documentType = documentType; }

    public String getFilePath() { return filePath; }
    public void setFilePath(String filePath) { this.filePath = filePath; }

    public String getUploadedAt() { return uploadedAt; }
    public void setUploadedAt(String uploadedAt) { this.uploadedAt = uploadedAt; }
}

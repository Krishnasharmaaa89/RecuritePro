package com.jobportal.model;

/**
 * ExtractedData.java - Model for data extracted from documents.
 * Maps to the 'extracted_data' table.
 */
public class ExtractedData {
    private int id;
    private int documentId;
    private String fieldName;
    private String extractedValue;

    public ExtractedData() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getDocumentId() { return documentId; }
    public void setDocumentId(int documentId) { this.documentId = documentId; }

    public String getFieldName() { return fieldName; }
    public void setFieldName(String fieldName) { this.fieldName = fieldName; }

    public String getExtractedValue() { return extractedValue; }
    public void setExtractedValue(String extractedValue) { this.extractedValue = extractedValue; }
}

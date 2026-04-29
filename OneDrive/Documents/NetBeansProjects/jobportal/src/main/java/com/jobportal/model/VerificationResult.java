package com.jobportal.model;

/**
 * VerificationResult.java - Model for verification comparison results.
 * Maps to the 'verification_results' table.
 */
public class VerificationResult {
    private int id;
    private int applicantId;
    private String fieldName;
    private String formValue;
    private String extractedValue;
    private String matchStatus; // VERIFIED, MISMATCH, NEEDS_MANUAL_REVIEW

    public VerificationResult() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getApplicantId() { return applicantId; }
    public void setApplicantId(int applicantId) { this.applicantId = applicantId; }

    public String getFieldName() { return fieldName; }
    public void setFieldName(String fieldName) { this.fieldName = fieldName; }

    public String getFormValue() { return formValue; }
    public void setFormValue(String formValue) { this.formValue = formValue; }

    public String getExtractedValue() { return extractedValue; }
    public void setExtractedValue(String extractedValue) { this.extractedValue = extractedValue; }

    public String getMatchStatus() { return matchStatus; }
    public void setMatchStatus(String matchStatus) { this.matchStatus = matchStatus; }
}

package com.jobportal.util;

/**
 * VerificationEngine.java - Compares form data with extracted document data.
 * 
 * Logic:
 *   IF form_data == extracted_data → VERIFIED
 *   ELSE IF data is unclear/empty → NEEDS_MANUAL_REVIEW
 *   ELSE → MISMATCH FOUND
 * 
 * This simple engine can be enhanced with fuzzy matching or ML-based comparison.
 */
public class VerificationEngine {

    /**
     * Compares two values and returns the match status.
     * 
     * @param formValue     Value entered by applicant in the form
     * @param extractedValue Value extracted from the document
     * @return "VERIFIED", "MISMATCH", or "NEEDS_MANUAL_REVIEW"
     */
    public static String compare(String formValue, String extractedValue) {
        // If either value is null or empty, needs manual review
        if (formValue == null || formValue.trim().isEmpty() ||
            extractedValue == null || extractedValue.trim().isEmpty()) {
            return "NEEDS_MANUAL_REVIEW";
        }

        // Normalize both values: trim whitespace, convert to lowercase
        String normalizedForm = formValue.trim().toLowerCase();
        String normalizedExtracted = extractedValue.trim().toLowerCase();

        // Exact match check
        if (normalizedForm.equals(normalizedExtracted)) {
            return "VERIFIED";
        }

        // Partial match check (one contains the other)
        if (normalizedForm.contains(normalizedExtracted) || normalizedExtracted.contains(normalizedForm)) {
            return "VERIFIED";
        }

        // Otherwise, it's a mismatch
        return "MISMATCH";
    }
}

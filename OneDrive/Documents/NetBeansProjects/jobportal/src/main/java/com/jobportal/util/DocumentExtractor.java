package com.jobportal.util;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * DocumentExtractor.java - Simulates Intelligent Document Processing (IDP).
 * 
 * In a real system, this would use OCR + NLP/ML to extract data from PDFs/images.
 * For this demo, we simulate extraction using:
 *   - Simple string parsing
 *   - Regex patterns
 *   - Hardcoded patterns for common document formats
 * 
 * This class is designed to be easily replaceable with real AI/ML integration.
 */
public class DocumentExtractor {

    /**
     * Simulates extracting data from a resume document.
     * In production, this would process the actual PDF/image file.
     * 
     * @param fileName Name of the uploaded file (used for simulation)
     * @param applicantName The applicant's name (used to generate realistic demo data)
     * @return Map of field names to extracted values
     */
    public static Map<String, String> extractFromResume(String fileName, String applicantName) {
        Map<String, String> extracted = new HashMap<>();

        // Simulate extraction - in real system, OCR would read the PDF
        extracted.put("name", applicantName != null ? applicantName : "Unknown");
        extracted.put("skills", "Java, SQL, HTML, CSS");
        extracted.put("experience", "2");
        extracted.put("qualification", "B.Tech Computer Science");

        return extracted;
    }

    /**
     * Simulates extracting data from an educational certificate.
     */
    public static Map<String, String> extractFromEducational(String fileName, String applicantName) {
        Map<String, String> extracted = new HashMap<>();

        extracted.put("name", applicantName != null ? applicantName : "Unknown");
        extracted.put("qualification", "B.Tech Computer Science");
        extracted.put("university", "Sample University");
        extracted.put("year", "2023");

        return extracted;
    }

    /**
     * Simulates extracting data from a marksheet.
     */
    public static Map<String, String> extractFromMarksheet(String fileName, String applicantName) {
        Map<String, String> extracted = new HashMap<>();

        extracted.put("name", applicantName != null ? applicantName : "Unknown");
        extracted.put("marks", "78.5");
        extracted.put("cgpa", "8.2");
        extracted.put("qualification", "B.Tech");

        return extracted;
    }

    /**
     * Simulates extracting data from an experience certificate.
     */
    public static Map<String, String> extractFromExperience(String fileName, String applicantName) {
        Map<String, String> extracted = new HashMap<>();

        extracted.put("name", applicantName != null ? applicantName : "Unknown");
        extracted.put("company", "Previous Corp");
        extracted.put("experience", "2");
        extracted.put("designation", "Software Developer");

        return extracted;
    }

    /**
     * Simulates extracting data from a category certificate (SC/ST/OBC/EWS/PwD).
     */
    public static Map<String, String> extractFromCategory(String fileName, String applicantName) {
        Map<String, String> extracted = new HashMap<>();

        extracted.put("name", applicantName != null ? applicantName : "Unknown");
        extracted.put("category", "General");
        extracted.put("father_name", "Sample Father Name");

        return extracted;
    }

    /**
     * Routes extraction to the correct method based on document type.
     */
    public static Map<String, String> extract(String documentType, String fileName, String applicantName) {
        switch (documentType.toLowerCase()) {
            case "resume":       return extractFromResume(fileName, applicantName);
            case "educational":  return extractFromEducational(fileName, applicantName);
            case "marksheet":    return extractFromMarksheet(fileName, applicantName);
            case "experience":   return extractFromExperience(fileName, applicantName);
            case "category":     return extractFromCategory(fileName, applicantName);
            default:             return new HashMap<>();
        }
    }

    /**
     * Simple regex-based name extraction demo.
     * Shows how regex could be used on OCR text output.
     */
    public static String extractNameFromText(String text) {
        // Pattern: "Name: <value>" or "Candidate Name: <value>"
        Pattern pattern = Pattern.compile("(?:Name|Candidate Name)\\s*:\\s*(.+)", Pattern.CASE_INSENSITIVE);
        Matcher matcher = pattern.matcher(text);
        if (matcher.find()) {
            return matcher.group(1).trim();
        }
        return null;
    }

    /**
     * Simple regex-based DOB extraction demo.
     */
    public static String extractDOBFromText(String text) {
        // Pattern: DD/MM/YYYY or DD-MM-YYYY
        Pattern pattern = Pattern.compile("\\b(\\d{2}[/-]\\d{2}[/-]\\d{4})\\b");
        Matcher matcher = pattern.matcher(text);
        if (matcher.find()) {
            return matcher.group(1);
        }
        return null;
    }
}

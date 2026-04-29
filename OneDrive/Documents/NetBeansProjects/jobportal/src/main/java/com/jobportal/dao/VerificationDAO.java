package com.jobportal.dao;

import com.jobportal.model.VerificationResult;
import com.jobportal.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * VerificationDAO.java - DAO for verification results.
 */
public class VerificationDAO {

    /** Saves a verification result. */
    public boolean save(VerificationResult vr) {
        String sql = "INSERT INTO verification_results (applicant_id, field_name, form_value, extracted_value, match_status) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, vr.getApplicantId());
            ps.setString(2, vr.getFieldName());
            ps.setString(3, vr.getFormValue());
            ps.setString(4, vr.getExtractedValue());
            ps.setString(5, vr.getMatchStatus());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    /** Gets all verification results for an applicant. */
    public List<VerificationResult> getByApplicantId(int applicantId) {
        List<VerificationResult> list = new ArrayList<>();
        String sql = "SELECT * FROM verification_results WHERE applicant_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, applicantId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                VerificationResult vr = new VerificationResult();
                vr.setId(rs.getInt("id"));
                vr.setApplicantId(rs.getInt("applicant_id"));
                vr.setFieldName(rs.getString("field_name"));
                vr.setFormValue(rs.getString("form_value"));
                vr.setExtractedValue(rs.getString("extracted_value"));
                vr.setMatchStatus(rs.getString("match_status"));
                list.add(vr);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    /** Deletes all verification results for an applicant (for re-verification). */
    public boolean deleteByApplicantId(int applicantId) {
        String sql = "DELETE FROM verification_results WHERE applicant_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, applicantId);
            return ps.executeUpdate() >= 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }
}

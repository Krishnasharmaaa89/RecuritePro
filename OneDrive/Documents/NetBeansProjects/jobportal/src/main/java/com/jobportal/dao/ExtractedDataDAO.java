package com.jobportal.dao;

import com.jobportal.model.ExtractedData;
import com.jobportal.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * ExtractedDataDAO.java - DAO for extracted document data.
 */
public class ExtractedDataDAO {

    /** Saves extracted field data. */
    public boolean save(ExtractedData data) {
        String sql = "INSERT INTO extracted_data (document_id, field_name, extracted_value) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, data.getDocumentId());
            ps.setString(2, data.getFieldName());
            ps.setString(3, data.getExtractedValue());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    /** Gets all extracted data for a document. */
    public List<ExtractedData> getByDocumentId(int documentId) {
        List<ExtractedData> list = new ArrayList<>();
        String sql = "SELECT * FROM extracted_data WHERE document_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, documentId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ExtractedData ed = new ExtractedData();
                ed.setId(rs.getInt("id"));
                ed.setDocumentId(rs.getInt("document_id"));
                ed.setFieldName(rs.getString("field_name"));
                ed.setExtractedValue(rs.getString("extracted_value"));
                list.add(ed);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }
}

package com.jobportal.dao;

import com.jobportal.model.Document;
import com.jobportal.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * DocumentDAO.java - Data Access Object for uploaded documents.
 */
public class DocumentDAO {

    /** Saves a document record after file upload. */
    public int saveDocument(Document doc) {
        String sql = "INSERT INTO documents (applicant_id, document_name, document_type, file_path) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, doc.getApplicantId());
            ps.setString(2, doc.getDocumentName());
            ps.setString(3, doc.getDocumentType());
            ps.setString(4, doc.getFilePath());
            ps.executeUpdate();
            ResultSet keys = ps.getGeneratedKeys();
            if (keys.next()) return keys.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return -1;
    }

    /** Gets all documents for an applicant. */
    public List<Document> getByApplicantId(int applicantId) {
        List<Document> list = new ArrayList<>();
        String sql = "SELECT * FROM documents WHERE applicant_id = ? ORDER BY uploaded_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, applicantId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapResultSet(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    /** Gets a document by ID. */
    public Document getById(int id) {
        String sql = "SELECT * FROM documents WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapResultSet(rs);
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    private Document mapResultSet(ResultSet rs) throws SQLException {
        Document d = new Document();
        d.setId(rs.getInt("id"));
        d.setApplicantId(rs.getInt("applicant_id"));
        d.setDocumentName(rs.getString("document_name"));
        d.setDocumentType(rs.getString("document_type"));
        d.setFilePath(rs.getString("file_path"));
        d.setUploadedAt(rs.getString("uploaded_at"));
        return d;
    }
}

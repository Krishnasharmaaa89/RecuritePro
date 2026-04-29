package com.jobportal.dao;

import com.jobportal.model.Applicant;
import com.jobportal.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * ApplicantDAO.java - Data Access Object for Applicant profile operations.
 */
public class ApplicantDAO {

    /**
     * Creates a new applicant profile linked to a user account.
     */
    public boolean createProfile(Applicant applicant) {
        String sql = "INSERT INTO applicants (user_id, full_name, father_name, dob, qualification, skills, experience, category) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, applicant.getUserId());
            ps.setString(2, applicant.getFullName());
            ps.setString(3, applicant.getFatherName());
            ps.setString(4, applicant.getDob());
            ps.setString(5, applicant.getQualification());
            ps.setString(6, applicant.getSkills());
            ps.setInt(7, applicant.getExperience());
            ps.setString(8, applicant.getCategory());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Updates an existing applicant profile.
     */
    public boolean updateProfile(Applicant applicant) {
        String sql = "UPDATE applicants SET full_name=?, father_name=?, dob=?, qualification=?, skills=?, experience=?, category=? WHERE user_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, applicant.getFullName());
            ps.setString(2, applicant.getFatherName());
            ps.setString(3, applicant.getDob());
            ps.setString(4, applicant.getQualification());
            ps.setString(5, applicant.getSkills());
            ps.setInt(6, applicant.getExperience());
            ps.setString(7, applicant.getCategory());
            ps.setInt(8, applicant.getUserId());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Gets applicant profile by user ID.
     */
    public Applicant getByUserId(int userId) {
        String sql = "SELECT * FROM applicants WHERE user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Gets applicant profile by applicant ID.
     */
    public Applicant getById(int id) {
        String sql = "SELECT * FROM applicants WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Gets all applicants (for admin view).
     */
    public List<Applicant> getAllApplicants() {
        List<Applicant> list = new ArrayList<>();
        String sql = "SELECT * FROM applicants ORDER BY id DESC";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                list.add(mapResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Helper: maps a ResultSet row to an Applicant object
    private Applicant mapResultSet(ResultSet rs) throws SQLException {
        Applicant a = new Applicant();
        a.setId(rs.getInt("id"));
        a.setUserId(rs.getInt("user_id"));
        a.setFullName(rs.getString("full_name"));
        a.setFatherName(rs.getString("father_name"));
        a.setDob(rs.getString("dob"));
        a.setQualification(rs.getString("qualification"));
        a.setSkills(rs.getString("skills"));
        a.setExperience(rs.getInt("experience"));
        a.setCategory(rs.getString("category"));
        a.setStatus(rs.getString("status"));
        return a;
    }
}

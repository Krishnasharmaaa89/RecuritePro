package com.jobportal.dao;

import com.jobportal.model.Application;
import com.jobportal.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * ApplicationDAO.java - Data Access Object for job application operations.
 */
public class ApplicationDAO {

    /** Applicant applies for a job. */
    public boolean applyForJob(int applicantId, int jobId) {
        // Check if already applied
        if (hasApplied(applicantId, jobId)) return false;

        String sql = "INSERT INTO applications (applicant_id, job_id) VALUES (?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, applicantId);
            ps.setInt(2, jobId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    /** Check if applicant already applied for a job. */
    public boolean hasApplied(int applicantId, int jobId) {
        String sql = "SELECT id FROM applications WHERE applicant_id = ? AND job_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, applicantId);
            ps.setInt(2, jobId);
            return ps.executeQuery().next();
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    /** Get all applications by an applicant (with job details). */
    public List<Application> getByApplicantId(int applicantId) {
        List<Application> list = new ArrayList<>();
        String sql = "SELECT a.*, j.title AS job_title, j.company FROM applications a JOIN jobs j ON a.job_id = j.id WHERE a.applicant_id = ? ORDER BY a.apply_date DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, applicantId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Application app = mapResultSet(rs);
                app.setJobTitle(rs.getString("job_title"));
                app.setCompany(rs.getString("company"));
                list.add(app);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    /** Get all applications for a job (with applicant details, for admin). */
    public List<Application> getByJobId(int jobId) {
        List<Application> list = new ArrayList<>();
        String sql = "SELECT a.*, ap.full_name AS applicant_name FROM applications a JOIN applicants ap ON a.applicant_id = ap.id WHERE a.job_id = ? ORDER BY a.apply_date DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, jobId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Application app = mapResultSet(rs);
                app.setApplicantName(rs.getString("applicant_name"));
                list.add(app);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    /** Get all applications (for admin). */
    public List<Application> getAllApplications() {
        List<Application> list = new ArrayList<>();
        String sql = "SELECT a.*, j.title AS job_title, j.company, ap.full_name AS applicant_name FROM applications a JOIN jobs j ON a.job_id = j.id JOIN applicants ap ON a.applicant_id = ap.id ORDER BY a.apply_date DESC";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Application app = mapResultSet(rs);
                app.setJobTitle(rs.getString("job_title"));
                app.setCompany(rs.getString("company"));
                app.setApplicantName(rs.getString("applicant_name"));
                list.add(app);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    /** Update application status (shortlisted, rejected, etc.) */
    public boolean updateStatus(int applicationId, String status) {
        String sql = "UPDATE applications SET status = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, applicationId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    /** Get application by ID. */
    public Application getById(int id) {
        String sql = "SELECT a.*, j.title AS job_title, j.company, ap.full_name AS applicant_name FROM applications a JOIN jobs j ON a.job_id = j.id JOIN applicants ap ON a.applicant_id = ap.id WHERE a.id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Application app = mapResultSet(rs);
                app.setJobTitle(rs.getString("job_title"));
                app.setCompany(rs.getString("company"));
                app.setApplicantName(rs.getString("applicant_name"));
                return app;
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    private Application mapResultSet(ResultSet rs) throws SQLException {
        Application a = new Application();
        a.setId(rs.getInt("id"));
        a.setApplicantId(rs.getInt("applicant_id"));
        a.setJobId(rs.getInt("job_id"));
        a.setApplyDate(rs.getString("apply_date"));
        a.setStatus(rs.getString("status"));
        return a;
    }
}

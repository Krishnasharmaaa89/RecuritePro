package com.jobportal.dao;

import com.jobportal.model.Job;
import com.jobportal.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * JobDAO.java - Data Access Object for Job listing operations.
 */
public class JobDAO {

    /** Creates a new job listing. */
    public boolean createJob(Job job) {
        String sql = "INSERT INTO jobs (title, company, location, description, requirements) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, job.getTitle());
            ps.setString(2, job.getCompany());
            ps.setString(3, job.getLocation());
            ps.setString(4, job.getDescription());
            ps.setString(5, job.getRequirements());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    /** Updates an existing job listing. */
    public boolean updateJob(Job job) {
        String sql = "UPDATE jobs SET title=?, company=?, location=?, description=?, requirements=?, is_active=? WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, job.getTitle());
            ps.setString(2, job.getCompany());
            ps.setString(3, job.getLocation());
            ps.setString(4, job.getDescription());
            ps.setString(5, job.getRequirements());
            ps.setBoolean(6, job.isActive());
            ps.setInt(7, job.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    /** Deletes a job listing. */
    public boolean deleteJob(int id) {
        String sql = "DELETE FROM jobs WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    /** Gets a job by ID. */
    public Job getById(int id) {
        String sql = "SELECT * FROM jobs WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapResultSet(rs);
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    /** Gets all active jobs (for applicants). */
    public List<Job> getActiveJobs() {
        return getJobs("SELECT * FROM jobs WHERE is_active = TRUE ORDER BY posted_date DESC");
    }

    /** Gets all jobs (for admin). */
    public List<Job> getAllJobs() {
        return getJobs("SELECT * FROM jobs ORDER BY posted_date DESC");
    }

    /** Search jobs by keyword. */
    public List<Job> searchJobs(String keyword) {
        List<Job> list = new ArrayList<>();
        String sql = "SELECT * FROM jobs WHERE is_active = TRUE AND (title LIKE ? OR company LIKE ? OR location LIKE ? OR requirements LIKE ?) ORDER BY posted_date DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            String pattern = "%" + keyword + "%";
            ps.setString(1, pattern); ps.setString(2, pattern);
            ps.setString(3, pattern); ps.setString(4, pattern);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapResultSet(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    private List<Job> getJobs(String sql) {
        List<Job> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) list.add(mapResultSet(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    private Job mapResultSet(ResultSet rs) throws SQLException {
        Job j = new Job();
        j.setId(rs.getInt("id"));
        j.setTitle(rs.getString("title"));
        j.setCompany(rs.getString("company"));
        j.setLocation(rs.getString("location"));
        j.setDescription(rs.getString("description"));
        j.setRequirements(rs.getString("requirements"));
        j.setPostedDate(rs.getString("posted_date"));
        j.setActive(rs.getBoolean("is_active"));
        return j;
    }
}

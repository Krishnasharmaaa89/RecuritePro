package com.jobportal.dao;

import com.jobportal.model.Interview;
import com.jobportal.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * InterviewDAO.java - DAO for interview scheduling operations.
 */
public class InterviewDAO {

    /** Schedules a new interview. */
    public boolean scheduleInterview(Interview interview) {
        String sql = "INSERT INTO interviews (application_id, interview_date, interview_time, mode, meeting_link, location) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, interview.getApplicationId());
            ps.setString(2, interview.getInterviewDate());
            ps.setString(3, interview.getInterviewTime());
            ps.setString(4, interview.getMode());
            ps.setString(5, interview.getMeetingLink());
            ps.setString(6, interview.getLocation());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    /** Gets interviews for an applicant (joins through applications). */
    public List<Interview> getByApplicantId(int applicantId) {
        List<Interview> list = new ArrayList<>();
        String sql = "SELECT i.*, j.title AS job_title FROM interviews i " +
                     "JOIN applications a ON i.application_id = a.id " +
                     "JOIN jobs j ON a.job_id = j.id " +
                     "WHERE a.applicant_id = ? ORDER BY i.interview_date";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, applicantId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Interview iv = mapResultSet(rs);
                iv.setJobTitle(rs.getString("job_title"));
                list.add(iv);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    /** Gets all interviews (for admin). */
    public List<Interview> getAllInterviews() {
        List<Interview> list = new ArrayList<>();
        String sql = "SELECT i.*, j.title AS job_title, ap.full_name AS applicant_name FROM interviews i " +
                     "JOIN applications a ON i.application_id = a.id " +
                     "JOIN jobs j ON a.job_id = j.id " +
                     "JOIN applicants ap ON a.applicant_id = ap.id " +
                     "ORDER BY i.interview_date";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Interview iv = mapResultSet(rs);
                iv.setJobTitle(rs.getString("job_title"));
                iv.setApplicantName(rs.getString("applicant_name"));
                list.add(iv);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    /** Updates interview status. */
    public boolean updateStatus(int interviewId, String status) {
        String sql = "UPDATE interviews SET status = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, interviewId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    private Interview mapResultSet(ResultSet rs) throws SQLException {
        Interview i = new Interview();
        i.setId(rs.getInt("id"));
        i.setApplicationId(rs.getInt("application_id"));
        i.setInterviewDate(rs.getString("interview_date"));
        i.setInterviewTime(rs.getString("interview_time"));
        i.setMode(rs.getString("mode"));
        i.setMeetingLink(rs.getString("meeting_link"));
        i.setLocation(rs.getString("location"));
        i.setStatus(rs.getString("status"));
        return i;
    }
}

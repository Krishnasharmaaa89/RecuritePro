package com.jobportal.model;

/**
 * Application.java - Model class for job applications.
 * Maps to the 'applications' table.
 */
public class Application {
    private int id;
    private int applicantId;
    private int jobId;
    private String applyDate;
    private String status; // applied, shortlisted, rejected, interview_scheduled

    // Extra fields for display (joined from other tables)
    private String jobTitle;
    private String company;
    private String applicantName;

    public Application() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getApplicantId() { return applicantId; }
    public void setApplicantId(int applicantId) { this.applicantId = applicantId; }

    public int getJobId() { return jobId; }
    public void setJobId(int jobId) { this.jobId = jobId; }

    public String getApplyDate() { return applyDate; }
    public void setApplyDate(String applyDate) { this.applyDate = applyDate; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getJobTitle() { return jobTitle; }
    public void setJobTitle(String jobTitle) { this.jobTitle = jobTitle; }

    public String getCompany() { return company; }
    public void setCompany(String company) { this.company = company; }

    public String getApplicantName() { return applicantName; }
    public void setApplicantName(String applicantName) { this.applicantName = applicantName; }
}

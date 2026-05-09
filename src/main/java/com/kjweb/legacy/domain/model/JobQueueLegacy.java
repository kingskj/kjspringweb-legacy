package com.kjweb.legacy.domain.model;
import java.util.Date;
public class JobQueueLegacy {
    private Long id; private String jobType; private String payload; private String status; private Integer attemptCount; private String forceErrorCode; private Date createdAt;
    public Long getId(){return id;} public void setId(Long id){this.id=id;}
    public String getJobType(){return jobType;} public void setJobType(String jobType){this.jobType=jobType;}
    public String getPayload(){return payload;} public void setPayload(String payload){this.payload=payload;}
    public String getStatus(){return status;} public void setStatus(String status){this.status=status;}
    public Integer getAttemptCount(){return attemptCount;} public void setAttemptCount(Integer attemptCount){this.attemptCount=attemptCount;}
    public String getForceErrorCode(){return forceErrorCode;} public void setForceErrorCode(String forceErrorCode){this.forceErrorCode=forceErrorCode;}
    public Date getCreatedAt(){return createdAt;} public void setCreatedAt(Date createdAt){this.createdAt=createdAt;}
}
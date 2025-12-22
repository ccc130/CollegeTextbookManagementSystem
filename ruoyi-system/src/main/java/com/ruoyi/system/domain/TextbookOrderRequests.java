package com.ruoyi.system.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 征订申请对象 textbook_order_requests
 * 
 * @author ccc
 * @date 2025-12-22
 */
public class TextbookOrderRequests extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 申请ID */
    private Long requestId;

    /** 申请人 */
    @Excel(name = "申请人")
    private Long teacherId;

    /** 申请教材 */
    @Excel(name = "申请教材")
    private Long textbookId;

    /** 课程名称 */
    @Excel(name = "课程名称")
    private String courseName;

    /** 授课班级 */
    @Excel(name = "授课班级")
    private Long classId;

    /** 申请数量 */
    @Excel(name = "申请数量")
    private String quantity;

    /** 状态 */
    @Excel(name = "状态")
    private Long status;

    /** 所属学院 */
    @Excel(name = "所属学院")
    private Long collegeId;

    /** 提交时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "提交时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date submittedAt;

    /** 审核人 */
    @Excel(name = "审核人")
    private Long reviewedBy;

    /** 审核时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "审核时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date reviewedAt;

    /** 审核意见 */
    @Excel(name = "审核意见")
    private String remarks;

    public void setRequestId(Long requestId) 
    {
        this.requestId = requestId;
    }

    public Long getRequestId() 
    {
        return requestId;
    }

    public void setTeacherId(Long teacherId) 
    {
        this.teacherId = teacherId;
    }

    public Long getTeacherId() 
    {
        return teacherId;
    }

    public void setTextbookId(Long textbookId) 
    {
        this.textbookId = textbookId;
    }

    public Long getTextbookId() 
    {
        return textbookId;
    }

    public void setCourseName(String courseName) 
    {
        this.courseName = courseName;
    }

    public String getCourseName() 
    {
        return courseName;
    }

    public void setClassId(Long classId) 
    {
        this.classId = classId;
    }

    public Long getClassId() 
    {
        return classId;
    }

    public void setQuantity(String quantity) 
    {
        this.quantity = quantity;
    }

    public String getQuantity() 
    {
        return quantity;
    }

    public void setStatus(Long status) 
    {
        this.status = status;
    }

    public Long getStatus() 
    {
        return status;
    }

    public void setCollegeId(Long collegeId) 
    {
        this.collegeId = collegeId;
    }

    public Long getCollegeId() 
    {
        return collegeId;
    }

    public void setSubmittedAt(Date submittedAt) 
    {
        this.submittedAt = submittedAt;
    }

    public Date getSubmittedAt() 
    {
        return submittedAt;
    }

    public void setReviewedBy(Long reviewedBy) 
    {
        this.reviewedBy = reviewedBy;
    }

    public Long getReviewedBy() 
    {
        return reviewedBy;
    }

    public void setReviewedAt(Date reviewedAt) 
    {
        this.reviewedAt = reviewedAt;
    }

    public Date getReviewedAt() 
    {
        return reviewedAt;
    }

    public void setRemarks(String remarks) 
    {
        this.remarks = remarks;
    }

    public String getRemarks() 
    {
        return remarks;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("requestId", getRequestId())
            .append("teacherId", getTeacherId())
            .append("textbookId", getTextbookId())
            .append("courseName", getCourseName())
            .append("classId", getClassId())
            .append("quantity", getQuantity())
            .append("status", getStatus())
            .append("collegeId", getCollegeId())
            .append("submittedAt", getSubmittedAt())
            .append("reviewedBy", getReviewedBy())
            .append("reviewedAt", getReviewedAt())
            .append("remarks", getRemarks())
            .toString();
    }
}

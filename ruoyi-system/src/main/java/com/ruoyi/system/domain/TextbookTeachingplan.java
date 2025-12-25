package com.ruoyi.system.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 教学计划对象 textbook_teachingplan
 * 
 * @author ccc
 * @date 2025-12-25
 */
public class TextbookTeachingplan extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 计划id */
    private Long planid;

    /** 学期 */
    @Excel(name = "学期")
    private String semester;

    /** 课程id */
    @Excel(name = "课程id")
    private Long courseid;

    /** 班级id */
    @Excel(name = "班级id")
    private Long classid;

    /** 教师id */
    @Excel(name = "教师id")
    private Long teacherid;

    /** 学生数量 */
    @Excel(name = "学生数量")
    private Long studentcount;

    public void setPlanid(Long planid) 
    {
        this.planid = planid;
    }

    public Long getPlanid() 
    {
        return planid;
    }

    public void setSemester(String semester) 
    {
        this.semester = semester;
    }

    public String getSemester() 
    {
        return semester;
    }

    public void setCourseid(Long courseid) 
    {
        this.courseid = courseid;
    }

    public Long getCourseid() 
    {
        return courseid;
    }

    public void setClassid(Long classid) 
    {
        this.classid = classid;
    }

    public Long getClassid() 
    {
        return classid;
    }

    public void setTeacherid(Long teacherid) 
    {
        this.teacherid = teacherid;
    }

    public Long getTeacherid() 
    {
        return teacherid;
    }

    public void setStudentcount(Long studentcount) 
    {
        this.studentcount = studentcount;
    }

    public Long getStudentcount() 
    {
        return studentcount;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("planid", getPlanid())
            .append("semester", getSemester())
            .append("courseid", getCourseid())
            .append("classid", getClassid())
            .append("teacherid", getTeacherid())
            .append("studentcount", getStudentcount())
            .toString();
    }
}

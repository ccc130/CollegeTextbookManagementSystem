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
    private Long PlanID;

    /** 学期 */
    @Excel(name = "学期")
    private String Semester;

    /** 班级id */
    @Excel(name = "班级id")
    private Long ClassID;

    /** 课程id */
    @Excel(name = "课程id")
    private Long CourseID;

    /** 教师id */
    @Excel(name = "教师id")
    private Long TeacherID;

    /** 学生数量 */
    @Excel(name = "学生数量")
    private Long StudentCount;

    public void setPlanID(Long PlanID) 
    {
        this.PlanID = PlanID;
    }

    public Long getPlanID() 
    {
        return PlanID;
    }

    public void setSemester(String Semester) 
    {
        this.Semester = Semester;
    }

    public String getSemester() 
    {
        return Semester;
    }

    public void setClassID(Long ClassID) 
    {
        this.ClassID = ClassID;
    }

    public Long getClassID() 
    {
        return ClassID;
    }

    public void setCourseID(Long CourseID) 
    {
        this.CourseID = CourseID;
    }

    public Long getCourseID() 
    {
        return CourseID;
    }

    public void setTeacherID(Long TeacherID) 
    {
        this.TeacherID = TeacherID;
    }

    public Long getTeacherID() 
    {
        return TeacherID;
    }

    public void setStudentCount(Long StudentCount) 
    {
        this.StudentCount = StudentCount;
    }

    public Long getStudentCount() 
    {
        return StudentCount;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("PlanID", getPlanID())
            .append("Semester", getSemester())
            .append("ClassID", getClassID())
            .append("CourseID", getCourseID())
            .append("TeacherID", getTeacherID())
            .append("StudentCount", getStudentCount())
            .toString();
    }
}

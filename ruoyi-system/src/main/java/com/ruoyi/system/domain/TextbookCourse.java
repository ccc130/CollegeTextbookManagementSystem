package com.ruoyi.system.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 课程管理对象 textbook_course
 * 
 * @author ccc
 * @date 2025-12-25
 */
public class TextbookCourse extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 课程id */
    private Long courseId;

    /** 课程名称 */
    @Excel(name = "课程名称")
    private String coursename;

    /** 课程代码 */
    @Excel(name = "课程代码")
    private String coursecode;

    /** 学分 */
    @Excel(name = "学分")
    private Long credits;

    /** 分类 */
    @Excel(name = "分类")
    private String category;

    /** 描述 */
    @Excel(name = "描述")
    private String description;

    public void setCourseId(Long courseId) 
    {
        this.courseId = courseId;
    }

    public Long getCourseId() 
    {
        return courseId;
    }

    public void setCoursename(String coursename) 
    {
        this.coursename = coursename;
    }

    public String getCoursename() 
    {
        return coursename;
    }

    public void setCoursecode(String coursecode) 
    {
        this.coursecode = coursecode;
    }

    public String getCoursecode() 
    {
        return coursecode;
    }

    public void setCredits(Long credits) 
    {
        this.credits = credits;
    }

    public Long getCredits() 
    {
        return credits;
    }

    public void setCategory(String category) 
    {
        this.category = category;
    }

    public String getCategory() 
    {
        return category;
    }

    public void setDescription(String description) 
    {
        this.description = description;
    }

    public String getDescription() 
    {
        return description;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("courseId", getCourseId())
            .append("coursename", getCoursename())
            .append("coursecode", getCoursecode())
            .append("credits", getCredits())
            .append("category", getCategory())
            .append("description", getDescription())
            .toString();
    }
}

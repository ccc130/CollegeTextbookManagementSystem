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
    private Long CourseID;

    /** 课程名称 */
    @Excel(name = "课程名称")
    private String CourseName;

    /** 课程代码 */
    @Excel(name = "课程代码")
    private String CourseCode;

    /** 学分 */
    @Excel(name = "学分")
    private Long Credits;

    /** 分类 */
    @Excel(name = "分类")
    private String Category;

    /** 描述 */
    @Excel(name = "描述")
    private String Description;

    public void setCourseID(Long CourseID) 
    {
        this.CourseID = CourseID;
    }

    public Long getCourseID() 
    {
        return CourseID;
    }

    public void setCourseName(String CourseName) 
    {
        this.CourseName = CourseName;
    }

    public String getCourseName() 
    {
        return CourseName;
    }

    public void setCourseCode(String CourseCode) 
    {
        this.CourseCode = CourseCode;
    }

    public String getCourseCode() 
    {
        return CourseCode;
    }

    public void setCredits(Long Credits) 
    {
        this.Credits = Credits;
    }

    public Long getCredits() 
    {
        return Credits;
    }

    public void setCategory(String Category) 
    {
        this.Category = Category;
    }

    public String getCategory() 
    {
        return Category;
    }

    public void setDescription(String Description) 
    {
        this.Description = Description;
    }

    public String getDescription() 
    {
        return Description;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("CourseID", getCourseID())
            .append("CourseName", getCourseName())
            .append("CourseCode", getCourseCode())
            .append("Credits", getCredits())
            .append("Category", getCategory())
            .append("Description", getDescription())
            .toString();
    }
}

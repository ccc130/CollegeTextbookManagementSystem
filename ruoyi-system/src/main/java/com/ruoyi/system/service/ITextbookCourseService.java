package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.TextbookCourse;

/**
 * 课程管理Service接口
 * 
 * @author ccc
 * @date 2025-12-25
 */
public interface ITextbookCourseService 
{
    /**
     * 查询课程管理
     * 
     * @param courseId 课程管理主键
     * @return 课程管理
     */
    public TextbookCourse selectTextbookCourseByCourseId(Long courseId);

    /**
     * 查询课程管理列表
     * 
     * @param textbookCourse 课程管理
     * @return 课程管理集合
     */
    public List<TextbookCourse> selectTextbookCourseList(TextbookCourse textbookCourse);

    /**
     * 新增课程管理
     * 
     * @param textbookCourse 课程管理
     * @return 结果
     */
    public int insertTextbookCourse(TextbookCourse textbookCourse);

    /**
     * 修改课程管理
     * 
     * @param textbookCourse 课程管理
     * @return 结果
     */
    public int updateTextbookCourse(TextbookCourse textbookCourse);

    /**
     * 批量删除课程管理
     * 
     * @param courseIds 需要删除的课程管理主键集合
     * @return 结果
     */
    public int deleteTextbookCourseByCourseIds(Long[] courseIds);

    /**
     * 删除课程管理信息
     * 
     * @param courseId 课程管理主键
     * @return 结果
     */
    public int deleteTextbookCourseByCourseId(Long courseId);
}

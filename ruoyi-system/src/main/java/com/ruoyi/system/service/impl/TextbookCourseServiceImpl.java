package com.ruoyi.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.TextbookCourseMapper;
import com.ruoyi.system.domain.TextbookCourse;
import com.ruoyi.system.service.ITextbookCourseService;

/**
 * 课程管理Service业务层处理
 * 
 * @author ccc
 * @date 2025-12-25
 */
@Service
public class TextbookCourseServiceImpl implements ITextbookCourseService 
{
    @Autowired
    private TextbookCourseMapper textbookCourseMapper;

    /**
     * 查询课程管理
     * 
     * @param CourseID 课程管理主键
     * @return 课程管理
     */
    @Override
    public TextbookCourse selectTextbookCourseByCourseID(Long CourseID)
    {
        return textbookCourseMapper.selectTextbookCourseByCourseID(CourseID);
    }

    /**
     * 查询课程管理列表
     * 
     * @param textbookCourse 课程管理
     * @return 课程管理
     */
    @Override
    public List<TextbookCourse> selectTextbookCourseList(TextbookCourse textbookCourse)
    {
        return textbookCourseMapper.selectTextbookCourseList(textbookCourse);
    }

    /**
     * 新增课程管理
     * 
     * @param textbookCourse 课程管理
     * @return 结果
     */
    @Override
    public int insertTextbookCourse(TextbookCourse textbookCourse)
    {
        return textbookCourseMapper.insertTextbookCourse(textbookCourse);
    }

    /**
     * 修改课程管理
     * 
     * @param textbookCourse 课程管理
     * @return 结果
     */
    @Override
    public int updateTextbookCourse(TextbookCourse textbookCourse)
    {
        return textbookCourseMapper.updateTextbookCourse(textbookCourse);
    }

    /**
     * 批量删除课程管理
     * 
     * @param CourseIDs 需要删除的课程管理主键
     * @return 结果
     */
    @Override
    public int deleteTextbookCourseByCourseIDs(Long[] CourseIDs)
    {
        return textbookCourseMapper.deleteTextbookCourseByCourseIDs(CourseIDs);
    }

    /**
     * 删除课程管理信息
     * 
     * @param CourseID 课程管理主键
     * @return 结果
     */
    @Override
    public int deleteTextbookCourseByCourseID(Long CourseID)
    {
        return textbookCourseMapper.deleteTextbookCourseByCourseID(CourseID);
    }
}

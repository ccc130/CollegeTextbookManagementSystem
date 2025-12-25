package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.TextbookTeachingplan;

/**
 * 教学计划Service接口
 * 
 * @author ccc
 * @date 2025-12-25
 */
public interface ITextbookTeachingplanService 
{
    /**
     * 查询教学计划
     * 
     * @param PlanID 教学计划主键
     * @return 教学计划
     */
    public TextbookTeachingplan selectTextbookTeachingplanByPlanID(Long PlanID);

    /**
     * 查询教学计划列表
     * 
     * @param textbookTeachingplan 教学计划
     * @return 教学计划集合
     */
    public List<TextbookTeachingplan> selectTextbookTeachingplanList(TextbookTeachingplan textbookTeachingplan);

    /**
     * 新增教学计划
     * 
     * @param textbookTeachingplan 教学计划
     * @return 结果
     */
    public int insertTextbookTeachingplan(TextbookTeachingplan textbookTeachingplan);

    /**
     * 修改教学计划
     * 
     * @param textbookTeachingplan 教学计划
     * @return 结果
     */
    public int updateTextbookTeachingplan(TextbookTeachingplan textbookTeachingplan);

    /**
     * 批量删除教学计划
     * 
     * @param PlanIDs 需要删除的教学计划主键集合
     * @return 结果
     */
    public int deleteTextbookTeachingplanByPlanIDs(Long[] PlanIDs);

    /**
     * 删除教学计划信息
     * 
     * @param PlanID 教学计划主键
     * @return 结果
     */
    public int deleteTextbookTeachingplanByPlanID(Long PlanID);
}

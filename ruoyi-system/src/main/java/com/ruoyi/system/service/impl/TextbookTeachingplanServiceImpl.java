package com.ruoyi.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.TextbookTeachingplanMapper;
import com.ruoyi.system.domain.TextbookTeachingplan;
import com.ruoyi.system.service.ITextbookTeachingplanService;

/**
 * 教学计划Service业务层处理
 * 
 * @author ccc
 * @date 2025-12-25
 */
@Service
public class TextbookTeachingplanServiceImpl implements ITextbookTeachingplanService 
{
    @Autowired
    private TextbookTeachingplanMapper textbookTeachingplanMapper;

    /**
     * 查询教学计划
     * 
     * @param PlanID 教学计划主键
     * @return 教学计划
     */
    @Override
    public TextbookTeachingplan selectTextbookTeachingplanByPlanID(Long PlanID)
    {
        return textbookTeachingplanMapper.selectTextbookTeachingplanByPlanID(PlanID);
    }

    /**
     * 查询教学计划列表
     * 
     * @param textbookTeachingplan 教学计划
     * @return 教学计划
     */
    @Override
    public List<TextbookTeachingplan> selectTextbookTeachingplanList(TextbookTeachingplan textbookTeachingplan)
    {
        return textbookTeachingplanMapper.selectTextbookTeachingplanList(textbookTeachingplan);
    }

    /**
     * 新增教学计划
     * 
     * @param textbookTeachingplan 教学计划
     * @return 结果
     */
    @Override
    public int insertTextbookTeachingplan(TextbookTeachingplan textbookTeachingplan)
    {
        return textbookTeachingplanMapper.insertTextbookTeachingplan(textbookTeachingplan);
    }

    /**
     * 修改教学计划
     * 
     * @param textbookTeachingplan 教学计划
     * @return 结果
     */
    @Override
    public int updateTextbookTeachingplan(TextbookTeachingplan textbookTeachingplan)
    {
        return textbookTeachingplanMapper.updateTextbookTeachingplan(textbookTeachingplan);
    }

    /**
     * 批量删除教学计划
     * 
     * @param PlanIDs 需要删除的教学计划主键
     * @return 结果
     */
    @Override
    public int deleteTextbookTeachingplanByPlanIDs(Long[] PlanIDs)
    {
        return textbookTeachingplanMapper.deleteTextbookTeachingplanByPlanIDs(PlanIDs);
    }

    /**
     * 删除教学计划信息
     * 
     * @param PlanID 教学计划主键
     * @return 结果
     */
    @Override
    public int deleteTextbookTeachingplanByPlanID(Long PlanID)
    {
        return textbookTeachingplanMapper.deleteTextbookTeachingplanByPlanID(PlanID);
    }
}

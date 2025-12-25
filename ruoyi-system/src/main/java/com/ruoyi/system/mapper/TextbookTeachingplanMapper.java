package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.TextbookTeachingplan;

/**
 * 教学计划Mapper接口
 * 
 * @author ccc
 * @date 2025-12-25
 */
public interface TextbookTeachingplanMapper 
{
    /**
     * 查询教学计划
     * 
     * @param planid 教学计划主键
     * @return 教学计划
     */
    public TextbookTeachingplan selectTextbookTeachingplanByPlanid(Long planid);

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
     * 删除教学计划
     * 
     * @param planid 教学计划主键
     * @return 结果
     */
    public int deleteTextbookTeachingplanByPlanid(Long planid);

    /**
     * 批量删除教学计划
     * 
     * @param planids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteTextbookTeachingplanByPlanids(Long[] planids);
}

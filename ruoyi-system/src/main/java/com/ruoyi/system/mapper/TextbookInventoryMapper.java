package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.TextbookInventory;

/**
 * 教材库存Mapper接口
 * 
 * @author ccc
 * @date 2025-12-22
 */
public interface TextbookInventoryMapper 
{
    /**
     * 查询教材库存
     * 
     * @param inventoryId 教材库存主键
     * @return 教材库存
     */
    public TextbookInventory selectTextbookInventoryByInventoryId(Long inventoryId);

    /**
     * 查询教材库存列表
     * 
     * @param textbookInventory 教材库存
     * @return 教材库存集合
     */
    public List<TextbookInventory> selectTextbookInventoryList(TextbookInventory textbookInventory);

    /**
     * 新增教材库存
     * 
     * @param textbookInventory 教材库存
     * @return 结果
     */
    public int insertTextbookInventory(TextbookInventory textbookInventory);

    /**
     * 修改教材库存
     * 
     * @param textbookInventory 教材库存
     * @return 结果
     */
    public int updateTextbookInventory(TextbookInventory textbookInventory);

    /**
     * 删除教材库存
     * 
     * @param inventoryId 教材库存主键
     * @return 结果
     */
    public int deleteTextbookInventoryByInventoryId(Long inventoryId);

    /**
     * 批量删除教材库存
     * 
     * @param inventoryIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteTextbookInventoryByInventoryIds(Long[] inventoryIds);
}

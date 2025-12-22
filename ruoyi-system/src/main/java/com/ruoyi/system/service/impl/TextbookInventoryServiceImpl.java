package com.ruoyi.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.TextbookInventoryMapper;
import com.ruoyi.system.domain.TextbookInventory;
import com.ruoyi.system.service.ITextbookInventoryService;

/**
 * 教材库存Service业务层处理
 * 
 * @author ccc
 * @date 2025-12-22
 */
@Service
public class TextbookInventoryServiceImpl implements ITextbookInventoryService 
{
    @Autowired
    private TextbookInventoryMapper textbookInventoryMapper;

    /**
     * 查询教材库存
     * 
     * @param inventoryId 教材库存主键
     * @return 教材库存
     */
    @Override
    public TextbookInventory selectTextbookInventoryByInventoryId(Long inventoryId)
    {
        return textbookInventoryMapper.selectTextbookInventoryByInventoryId(inventoryId);
    }

    /**
     * 查询教材库存列表
     * 
     * @param textbookInventory 教材库存
     * @return 教材库存
     */
    @Override
    public List<TextbookInventory> selectTextbookInventoryList(TextbookInventory textbookInventory)
    {
        return textbookInventoryMapper.selectTextbookInventoryList(textbookInventory);
    }

    /**
     * 新增教材库存
     * 
     * @param textbookInventory 教材库存
     * @return 结果
     */
    @Override
    public int insertTextbookInventory(TextbookInventory textbookInventory)
    {
        return textbookInventoryMapper.insertTextbookInventory(textbookInventory);
    }

    /**
     * 修改教材库存
     * 
     * @param textbookInventory 教材库存
     * @return 结果
     */
    @Override
    public int updateTextbookInventory(TextbookInventory textbookInventory)
    {
        return textbookInventoryMapper.updateTextbookInventory(textbookInventory);
    }

    /**
     * 批量删除教材库存
     * 
     * @param inventoryIds 需要删除的教材库存主键
     * @return 结果
     */
    @Override
    public int deleteTextbookInventoryByInventoryIds(Long[] inventoryIds)
    {
        return textbookInventoryMapper.deleteTextbookInventoryByInventoryIds(inventoryIds);
    }

    /**
     * 删除教材库存信息
     * 
     * @param inventoryId 教材库存主键
     * @return 结果
     */
    @Override
    public int deleteTextbookInventoryByInventoryId(Long inventoryId)
    {
        return textbookInventoryMapper.deleteTextbookInventoryByInventoryId(inventoryId);
    }
}

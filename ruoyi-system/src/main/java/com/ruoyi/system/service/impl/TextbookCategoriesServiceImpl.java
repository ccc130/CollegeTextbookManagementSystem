package com.ruoyi.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.TextbookCategoriesMapper;
import com.ruoyi.system.domain.TextbookCategories;
import com.ruoyi.system.service.ITextbookCategoriesService;

/**
 * 教材类型Service业务层处理
 * 
 * @author ccc
 * @date 2025-12-22
 */
@Service
public class TextbookCategoriesServiceImpl implements ITextbookCategoriesService 
{
    @Autowired
    private TextbookCategoriesMapper textbookCategoriesMapper;

    /**
     * 查询教材类型
     * 
     * @param categoryId 教材类型主键
     * @return 教材类型
     */
    @Override
    public TextbookCategories selectTextbookCategoriesByCategoryId(Long categoryId)
    {
        return textbookCategoriesMapper.selectTextbookCategoriesByCategoryId(categoryId);
    }

    /**
     * 查询教材类型列表
     * 
     * @param textbookCategories 教材类型
     * @return 教材类型
     */
    @Override
    public List<TextbookCategories> selectTextbookCategoriesList(TextbookCategories textbookCategories)
    {
        return textbookCategoriesMapper.selectTextbookCategoriesList(textbookCategories);
    }

    /**
     * 新增教材类型
     * 
     * @param textbookCategories 教材类型
     * @return 结果
     */
    @Override
    public int insertTextbookCategories(TextbookCategories textbookCategories)
    {
        return textbookCategoriesMapper.insertTextbookCategories(textbookCategories);
    }

    /**
     * 修改教材类型
     * 
     * @param textbookCategories 教材类型
     * @return 结果
     */
    @Override
    public int updateTextbookCategories(TextbookCategories textbookCategories)
    {
        return textbookCategoriesMapper.updateTextbookCategories(textbookCategories);
    }

    /**
     * 批量删除教材类型
     * 
     * @param categoryIds 需要删除的教材类型主键
     * @return 结果
     */
    @Override
    public int deleteTextbookCategoriesByCategoryIds(Long[] categoryIds)
    {
        return textbookCategoriesMapper.deleteTextbookCategoriesByCategoryIds(categoryIds);
    }

    /**
     * 删除教材类型信息
     * 
     * @param categoryId 教材类型主键
     * @return 结果
     */
    @Override
    public int deleteTextbookCategoriesByCategoryId(Long categoryId)
    {
        return textbookCategoriesMapper.deleteTextbookCategoriesByCategoryId(categoryId);
    }
}

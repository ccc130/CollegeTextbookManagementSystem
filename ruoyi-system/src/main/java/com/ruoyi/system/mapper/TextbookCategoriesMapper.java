package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.TextbookCategories;

/**
 * 教材类型Mapper接口
 * 
 * @author ccc
 * @date 2025-12-22
 */
public interface TextbookCategoriesMapper 
{
    /**
     * 查询教材类型
     * 
     * @param categoryId 教材类型主键
     * @return 教材类型
     */
    public TextbookCategories selectTextbookCategoriesByCategoryId(Long categoryId);

    /**
     * 查询教材类型列表
     * 
     * @param textbookCategories 教材类型
     * @return 教材类型集合
     */
    public List<TextbookCategories> selectTextbookCategoriesList(TextbookCategories textbookCategories);

    /**
     * 新增教材类型
     * 
     * @param textbookCategories 教材类型
     * @return 结果
     */
    public int insertTextbookCategories(TextbookCategories textbookCategories);

    /**
     * 修改教材类型
     * 
     * @param textbookCategories 教材类型
     * @return 结果
     */
    public int updateTextbookCategories(TextbookCategories textbookCategories);

    /**
     * 删除教材类型
     * 
     * @param categoryId 教材类型主键
     * @return 结果
     */
    public int deleteTextbookCategoriesByCategoryId(Long categoryId);

    /**
     * 批量删除教材类型
     * 
     * @param categoryIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteTextbookCategoriesByCategoryIds(Long[] categoryIds);
}

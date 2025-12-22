package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.TextbookBooks;

/**
 * 教材信息Service接口
 * 
 * @author ccc
 * @date 2025-12-22
 */
public interface ITextbookBooksService 
{
    /**
     * 查询教材信息
     * 
     * @param textbookId 教材信息主键
     * @return 教材信息
     */
    public TextbookBooks selectTextbookBooksByTextbookId(Long textbookId);

    /**
     * 查询教材信息列表
     * 
     * @param textbookBooks 教材信息
     * @return 教材信息集合
     */
    public List<TextbookBooks> selectTextbookBooksList(TextbookBooks textbookBooks);

    /**
     * 新增教材信息
     * 
     * @param textbookBooks 教材信息
     * @return 结果
     */
    public int insertTextbookBooks(TextbookBooks textbookBooks);

    /**
     * 修改教材信息
     * 
     * @param textbookBooks 教材信息
     * @return 结果
     */
    public int updateTextbookBooks(TextbookBooks textbookBooks);

    /**
     * 批量删除教材信息
     * 
     * @param textbookIds 需要删除的教材信息主键集合
     * @return 结果
     */
    public int deleteTextbookBooksByTextbookIds(Long[] textbookIds);

    /**
     * 删除教材信息信息
     * 
     * @param textbookId 教材信息主键
     * @return 结果
     */
    public int deleteTextbookBooksByTextbookId(Long textbookId);
}

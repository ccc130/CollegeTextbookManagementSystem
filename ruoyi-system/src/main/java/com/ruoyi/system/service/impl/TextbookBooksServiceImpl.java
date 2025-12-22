package com.ruoyi.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.TextbookBooksMapper;
import com.ruoyi.system.domain.TextbookBooks;
import com.ruoyi.system.service.ITextbookBooksService;

/**
 * 教材信息Service业务层处理
 * 
 * @author ccc
 * @date 2025-12-22
 */
@Service
public class TextbookBooksServiceImpl implements ITextbookBooksService 
{
    @Autowired
    private TextbookBooksMapper textbookBooksMapper;

    /**
     * 查询教材信息
     * 
     * @param textbookId 教材信息主键
     * @return 教材信息
     */
    @Override
    public TextbookBooks selectTextbookBooksByTextbookId(Long textbookId)
    {
        return textbookBooksMapper.selectTextbookBooksByTextbookId(textbookId);
    }

    /**
     * 查询教材信息列表
     * 
     * @param textbookBooks 教材信息
     * @return 教材信息
     */
    @Override
    public List<TextbookBooks> selectTextbookBooksList(TextbookBooks textbookBooks)
    {
        return textbookBooksMapper.selectTextbookBooksList(textbookBooks);
    }

    /**
     * 新增教材信息
     * 
     * @param textbookBooks 教材信息
     * @return 结果
     */
    @Override
    public int insertTextbookBooks(TextbookBooks textbookBooks)
    {
        return textbookBooksMapper.insertTextbookBooks(textbookBooks);
    }

    /**
     * 修改教材信息
     * 
     * @param textbookBooks 教材信息
     * @return 结果
     */
    @Override
    public int updateTextbookBooks(TextbookBooks textbookBooks)
    {
        return textbookBooksMapper.updateTextbookBooks(textbookBooks);
    }

    /**
     * 批量删除教材信息
     * 
     * @param textbookIds 需要删除的教材信息主键
     * @return 结果
     */
    @Override
    public int deleteTextbookBooksByTextbookIds(Long[] textbookIds)
    {
        return textbookBooksMapper.deleteTextbookBooksByTextbookIds(textbookIds);
    }

    /**
     * 删除教材信息信息
     * 
     * @param textbookId 教材信息主键
     * @return 结果
     */
    @Override
    public int deleteTextbookBooksByTextbookId(Long textbookId)
    {
        return textbookBooksMapper.deleteTextbookBooksByTextbookId(textbookId);
    }
}

package com.ruoyi.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.TextbookPublishersMapper;
import com.ruoyi.system.domain.TextbookPublishers;
import com.ruoyi.system.service.ITextbookPublishersService;

/**
 * 出版社信息Service业务层处理
 * 
 * @author cccc
 * @date 2025-12-22
 */
@Service
public class TextbookPublishersServiceImpl implements ITextbookPublishersService 
{
    @Autowired
    private TextbookPublishersMapper textbookPublishersMapper;

    /**
     * 查询出版社信息
     * 
     * @param publisherId 出版社信息主键
     * @return 出版社信息
     */
    @Override
    public TextbookPublishers selectTextbookPublishersByPublisherId(Long publisherId)
    {
        return textbookPublishersMapper.selectTextbookPublishersByPublisherId(publisherId);
    }

    /**
     * 查询出版社信息列表
     * 
     * @param textbookPublishers 出版社信息
     * @return 出版社信息
     */
    @Override
    public List<TextbookPublishers> selectTextbookPublishersList(TextbookPublishers textbookPublishers)
    {
        return textbookPublishersMapper.selectTextbookPublishersList(textbookPublishers);
    }

    /**
     * 新增出版社信息
     * 
     * @param textbookPublishers 出版社信息
     * @return 结果
     */
    @Override
    public int insertTextbookPublishers(TextbookPublishers textbookPublishers)
    {
        return textbookPublishersMapper.insertTextbookPublishers(textbookPublishers);
    }

    /**
     * 修改出版社信息
     * 
     * @param textbookPublishers 出版社信息
     * @return 结果
     */
    @Override
    public int updateTextbookPublishers(TextbookPublishers textbookPublishers)
    {
        return textbookPublishersMapper.updateTextbookPublishers(textbookPublishers);
    }

    /**
     * 批量删除出版社信息
     * 
     * @param publisherIds 需要删除的出版社信息主键
     * @return 结果
     */
    @Override
    public int deleteTextbookPublishersByPublisherIds(Long[] publisherIds)
    {
        return textbookPublishersMapper.deleteTextbookPublishersByPublisherIds(publisherIds);
    }

    /**
     * 删除出版社信息信息
     * 
     * @param publisherId 出版社信息主键
     * @return 结果
     */
    @Override
    public int deleteTextbookPublishersByPublisherId(Long publisherId)
    {
        return textbookPublishersMapper.deleteTextbookPublishersByPublisherId(publisherId);
    }
}

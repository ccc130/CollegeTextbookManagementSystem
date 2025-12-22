package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.TextbookPublishers;

/**
 * 出版社信息Service接口
 * 
 * @author cccc
 * @date 2025-12-22
 */
public interface ITextbookPublishersService 
{
    /**
     * 查询出版社信息
     * 
     * @param publisherId 出版社信息主键
     * @return 出版社信息
     */
    public TextbookPublishers selectTextbookPublishersByPublisherId(Long publisherId);

    /**
     * 查询出版社信息列表
     * 
     * @param textbookPublishers 出版社信息
     * @return 出版社信息集合
     */
    public List<TextbookPublishers> selectTextbookPublishersList(TextbookPublishers textbookPublishers);

    /**
     * 新增出版社信息
     * 
     * @param textbookPublishers 出版社信息
     * @return 结果
     */
    public int insertTextbookPublishers(TextbookPublishers textbookPublishers);

    /**
     * 修改出版社信息
     * 
     * @param textbookPublishers 出版社信息
     * @return 结果
     */
    public int updateTextbookPublishers(TextbookPublishers textbookPublishers);

    /**
     * 批量删除出版社信息
     * 
     * @param publisherIds 需要删除的出版社信息主键集合
     * @return 结果
     */
    public int deleteTextbookPublishersByPublisherIds(Long[] publisherIds);

    /**
     * 删除出版社信息信息
     * 
     * @param publisherId 出版社信息主键
     * @return 结果
     */
    public int deleteTextbookPublishersByPublisherId(Long publisherId);
}

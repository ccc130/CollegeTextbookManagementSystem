package com.ruoyi.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.TextbookOrderRequestsMapper;
import com.ruoyi.system.domain.TextbookOrderRequests;
import com.ruoyi.system.service.ITextbookOrderRequestsService;

/**
 * 征订申请Service业务层处理
 * 
 * @author ccc
 * @date 2025-12-22
 */
@Service
public class TextbookOrderRequestsServiceImpl implements ITextbookOrderRequestsService 
{
    @Autowired
    private TextbookOrderRequestsMapper textbookOrderRequestsMapper;

    /**
     * 查询征订申请
     * 
     * @param requestId 征订申请主键
     * @return 征订申请
     */
    @Override
    public TextbookOrderRequests selectTextbookOrderRequestsByRequestId(Long requestId)
    {
        return textbookOrderRequestsMapper.selectTextbookOrderRequestsByRequestId(requestId);
    }

    /**
     * 查询征订申请列表
     * 
     * @param textbookOrderRequests 征订申请
     * @return 征订申请
     */
    @Override
    public List<TextbookOrderRequests> selectTextbookOrderRequestsList(TextbookOrderRequests textbookOrderRequests)
    {
        return textbookOrderRequestsMapper.selectTextbookOrderRequestsList(textbookOrderRequests);
    }

    /**
     * 新增征订申请
     * 
     * @param textbookOrderRequests 征订申请
     * @return 结果
     */
    @Override
    public int insertTextbookOrderRequests(TextbookOrderRequests textbookOrderRequests)
    {
        return textbookOrderRequestsMapper.insertTextbookOrderRequests(textbookOrderRequests);
    }

    /**
     * 修改征订申请
     * 
     * @param textbookOrderRequests 征订申请
     * @return 结果
     */
    @Override
    public int updateTextbookOrderRequests(TextbookOrderRequests textbookOrderRequests)
    {
        return textbookOrderRequestsMapper.updateTextbookOrderRequests(textbookOrderRequests);
    }

    /**
     * 批量删除征订申请
     * 
     * @param requestIds 需要删除的征订申请主键
     * @return 结果
     */
    @Override
    public int deleteTextbookOrderRequestsByRequestIds(Long[] requestIds)
    {
        return textbookOrderRequestsMapper.deleteTextbookOrderRequestsByRequestIds(requestIds);
    }

    /**
     * 删除征订申请信息
     * 
     * @param requestId 征订申请主键
     * @return 结果
     */
    @Override
    public int deleteTextbookOrderRequestsByRequestId(Long requestId)
    {
        return textbookOrderRequestsMapper.deleteTextbookOrderRequestsByRequestId(requestId);
    }
}

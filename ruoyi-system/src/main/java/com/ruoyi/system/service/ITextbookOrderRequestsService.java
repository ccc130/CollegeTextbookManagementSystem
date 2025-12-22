package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.TextbookOrderRequests;

/**
 * 征订申请Service接口
 * 
 * @author ccc
 * @date 2025-12-22
 */
public interface ITextbookOrderRequestsService 
{
    /**
     * 查询征订申请
     * 
     * @param requestId 征订申请主键
     * @return 征订申请
     */
    public TextbookOrderRequests selectTextbookOrderRequestsByRequestId(Long requestId);

    /**
     * 查询征订申请列表
     * 
     * @param textbookOrderRequests 征订申请
     * @return 征订申请集合
     */
    public List<TextbookOrderRequests> selectTextbookOrderRequestsList(TextbookOrderRequests textbookOrderRequests);

    /**
     * 新增征订申请
     * 
     * @param textbookOrderRequests 征订申请
     * @return 结果
     */
    public int insertTextbookOrderRequests(TextbookOrderRequests textbookOrderRequests);

    /**
     * 修改征订申请
     * 
     * @param textbookOrderRequests 征订申请
     * @return 结果
     */
    public int updateTextbookOrderRequests(TextbookOrderRequests textbookOrderRequests);

    /**
     * 批量删除征订申请
     * 
     * @param requestIds 需要删除的征订申请主键集合
     * @return 结果
     */
    public int deleteTextbookOrderRequestsByRequestIds(Long[] requestIds);

    /**
     * 删除征订申请信息
     * 
     * @param requestId 征订申请主键
     * @return 结果
     */
    public int deleteTextbookOrderRequestsByRequestId(Long requestId);
}

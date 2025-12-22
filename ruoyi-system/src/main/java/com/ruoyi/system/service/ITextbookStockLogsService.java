package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.TextbookStockLogs;

/**
 * 出入库日志Service接口
 * 
 * @author ccc
 * @date 2025-12-22
 */
public interface ITextbookStockLogsService 
{
    /**
     * 查询出入库日志
     * 
     * @param logId 出入库日志主键
     * @return 出入库日志
     */
    public TextbookStockLogs selectTextbookStockLogsByLogId(Long logId);

    /**
     * 查询出入库日志列表
     * 
     * @param textbookStockLogs 出入库日志
     * @return 出入库日志集合
     */
    public List<TextbookStockLogs> selectTextbookStockLogsList(TextbookStockLogs textbookStockLogs);

    /**
     * 新增出入库日志
     * 
     * @param textbookStockLogs 出入库日志
     * @return 结果
     */
    public int insertTextbookStockLogs(TextbookStockLogs textbookStockLogs);

    /**
     * 修改出入库日志
     * 
     * @param textbookStockLogs 出入库日志
     * @return 结果
     */
    public int updateTextbookStockLogs(TextbookStockLogs textbookStockLogs);

    /**
     * 批量删除出入库日志
     * 
     * @param logIds 需要删除的出入库日志主键集合
     * @return 结果
     */
    public int deleteTextbookStockLogsByLogIds(Long[] logIds);

    /**
     * 删除出入库日志信息
     * 
     * @param logId 出入库日志主键
     * @return 结果
     */
    public int deleteTextbookStockLogsByLogId(Long logId);
}

package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.TextbookStockLogs;

/**
 * 出入库日志Mapper接口
 * 
 * @author ccc
 * @date 2025-12-22
 */
public interface TextbookStockLogsMapper 
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
     * 删除出入库日志
     * 
     * @param logId 出入库日志主键
     * @return 结果
     */
    public int deleteTextbookStockLogsByLogId(Long logId);

    /**
     * 批量删除出入库日志
     * 
     * @param logIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteTextbookStockLogsByLogIds(Long[] logIds);
}

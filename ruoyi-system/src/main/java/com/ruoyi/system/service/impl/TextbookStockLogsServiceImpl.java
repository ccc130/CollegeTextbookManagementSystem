package com.ruoyi.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.TextbookStockLogsMapper;
import com.ruoyi.system.domain.TextbookStockLogs;
import com.ruoyi.system.service.ITextbookStockLogsService;

/**
 * 出入库日志Service业务层处理
 * 
 * @author ccc
 * @date 2025-12-22
 */
@Service
public class TextbookStockLogsServiceImpl implements ITextbookStockLogsService 
{
    @Autowired
    private TextbookStockLogsMapper textbookStockLogsMapper;

    /**
     * 查询出入库日志
     * 
     * @param logId 出入库日志主键
     * @return 出入库日志
     */
    @Override
    public TextbookStockLogs selectTextbookStockLogsByLogId(Long logId)
    {
        return textbookStockLogsMapper.selectTextbookStockLogsByLogId(logId);
    }

    /**
     * 查询出入库日志列表
     * 
     * @param textbookStockLogs 出入库日志
     * @return 出入库日志
     */
    @Override
    public List<TextbookStockLogs> selectTextbookStockLogsList(TextbookStockLogs textbookStockLogs)
    {
        return textbookStockLogsMapper.selectTextbookStockLogsList(textbookStockLogs);
    }

    /**
     * 新增出入库日志
     * 
     * @param textbookStockLogs 出入库日志
     * @return 结果
     */
    @Override
    public int insertTextbookStockLogs(TextbookStockLogs textbookStockLogs)
    {
        return textbookStockLogsMapper.insertTextbookStockLogs(textbookStockLogs);
    }

    /**
     * 修改出入库日志
     * 
     * @param textbookStockLogs 出入库日志
     * @return 结果
     */
    @Override
    public int updateTextbookStockLogs(TextbookStockLogs textbookStockLogs)
    {
        return textbookStockLogsMapper.updateTextbookStockLogs(textbookStockLogs);
    }

    /**
     * 批量删除出入库日志
     * 
     * @param logIds 需要删除的出入库日志主键
     * @return 结果
     */
    @Override
    public int deleteTextbookStockLogsByLogIds(Long[] logIds)
    {
        return textbookStockLogsMapper.deleteTextbookStockLogsByLogIds(logIds);
    }

    /**
     * 删除出入库日志信息
     * 
     * @param logId 出入库日志主键
     * @return 结果
     */
    @Override
    public int deleteTextbookStockLogsByLogId(Long logId)
    {
        return textbookStockLogsMapper.deleteTextbookStockLogsByLogId(logId);
    }
}

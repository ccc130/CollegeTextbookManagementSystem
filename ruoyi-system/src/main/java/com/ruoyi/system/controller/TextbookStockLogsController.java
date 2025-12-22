package com.ruoyi.system.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.system.domain.TextbookStockLogs;
import com.ruoyi.system.service.ITextbookStockLogsService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 出入库日志Controller
 * 
 * @author ccc
 * @date 2025-12-22
 */
@RestController
@RequestMapping("/system/logs")
public class TextbookStockLogsController extends BaseController
{
    @Autowired
    private ITextbookStockLogsService textbookStockLogsService;

    /**
     * 查询出入库日志列表
     */
    @PreAuthorize("@ss.hasPermi('system:logs:list')")
    @GetMapping("/list")
    public TableDataInfo list(TextbookStockLogs textbookStockLogs)
    {
        startPage();
        List<TextbookStockLogs> list = textbookStockLogsService.selectTextbookStockLogsList(textbookStockLogs);
        return getDataTable(list);
    }

    /**
     * 导出出入库日志列表
     */
    @PreAuthorize("@ss.hasPermi('system:logs:export')")
    @Log(title = "出入库日志", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, TextbookStockLogs textbookStockLogs)
    {
        List<TextbookStockLogs> list = textbookStockLogsService.selectTextbookStockLogsList(textbookStockLogs);
        ExcelUtil<TextbookStockLogs> util = new ExcelUtil<TextbookStockLogs>(TextbookStockLogs.class);
        util.exportExcel(response, list, "出入库日志数据");
    }

    /**
     * 获取出入库日志详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:logs:query')")
    @GetMapping(value = "/{logId}")
    public AjaxResult getInfo(@PathVariable("logId") Long logId)
    {
        return success(textbookStockLogsService.selectTextbookStockLogsByLogId(logId));
    }

    /**
     * 新增出入库日志
     */
    @PreAuthorize("@ss.hasPermi('system:logs:add')")
    @Log(title = "出入库日志", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody TextbookStockLogs textbookStockLogs)
    {
        return toAjax(textbookStockLogsService.insertTextbookStockLogs(textbookStockLogs));
    }

    /**
     * 修改出入库日志
     */
    @PreAuthorize("@ss.hasPermi('system:logs:edit')")
    @Log(title = "出入库日志", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody TextbookStockLogs textbookStockLogs)
    {
        return toAjax(textbookStockLogsService.updateTextbookStockLogs(textbookStockLogs));
    }

    /**
     * 删除出入库日志
     */
    @PreAuthorize("@ss.hasPermi('system:logs:remove')")
    @Log(title = "出入库日志", businessType = BusinessType.DELETE)
	@DeleteMapping("/{logIds}")
    public AjaxResult remove(@PathVariable Long[] logIds)
    {
        return toAjax(textbookStockLogsService.deleteTextbookStockLogsByLogIds(logIds));
    }
}

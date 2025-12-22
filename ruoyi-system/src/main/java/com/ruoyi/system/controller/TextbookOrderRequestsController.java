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
import com.ruoyi.system.domain.TextbookOrderRequests;
import com.ruoyi.system.service.ITextbookOrderRequestsService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 征订申请Controller
 * 
 * @author ccc
 * @date 2025-12-22
 */
@RestController
@RequestMapping("/system/requests")
public class TextbookOrderRequestsController extends BaseController
{
    @Autowired
    private ITextbookOrderRequestsService textbookOrderRequestsService;

    /**
     * 查询征订申请列表
     */
    @PreAuthorize("@ss.hasPermi('system:requests:list')")
    @GetMapping("/list")
    public TableDataInfo list(TextbookOrderRequests textbookOrderRequests)
    {
        startPage();
        List<TextbookOrderRequests> list = textbookOrderRequestsService.selectTextbookOrderRequestsList(textbookOrderRequests);
        return getDataTable(list);
    }

    /**
     * 导出征订申请列表
     */
    @PreAuthorize("@ss.hasPermi('system:requests:export')")
    @Log(title = "征订申请", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, TextbookOrderRequests textbookOrderRequests)
    {
        List<TextbookOrderRequests> list = textbookOrderRequestsService.selectTextbookOrderRequestsList(textbookOrderRequests);
        ExcelUtil<TextbookOrderRequests> util = new ExcelUtil<TextbookOrderRequests>(TextbookOrderRequests.class);
        util.exportExcel(response, list, "征订申请数据");
    }

    /**
     * 获取征订申请详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:requests:query')")
    @GetMapping(value = "/{requestId}")
    public AjaxResult getInfo(@PathVariable("requestId") Long requestId)
    {
        return success(textbookOrderRequestsService.selectTextbookOrderRequestsByRequestId(requestId));
    }

    /**
     * 新增征订申请
     */
    @PreAuthorize("@ss.hasPermi('system:requests:add')")
    @Log(title = "征订申请", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody TextbookOrderRequests textbookOrderRequests)
    {
        return toAjax(textbookOrderRequestsService.insertTextbookOrderRequests(textbookOrderRequests));
    }

    /**
     * 修改征订申请
     */
    @PreAuthorize("@ss.hasPermi('system:requests:edit')")
    @Log(title = "征订申请", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody TextbookOrderRequests textbookOrderRequests)
    {
        return toAjax(textbookOrderRequestsService.updateTextbookOrderRequests(textbookOrderRequests));
    }

    /**
     * 删除征订申请
     */
    @PreAuthorize("@ss.hasPermi('system:requests:remove')")
    @Log(title = "征订申请", businessType = BusinessType.DELETE)
	@DeleteMapping("/{requestIds}")
    public AjaxResult remove(@PathVariable Long[] requestIds)
    {
        return toAjax(textbookOrderRequestsService.deleteTextbookOrderRequestsByRequestIds(requestIds));
    }
}

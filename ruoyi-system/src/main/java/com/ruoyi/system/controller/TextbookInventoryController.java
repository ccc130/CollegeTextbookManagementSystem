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
import com.ruoyi.system.domain.TextbookInventory;
import com.ruoyi.system.service.ITextbookInventoryService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 教材库存Controller
 * 
 * @author ccc
 * @date 2025-12-22
 */
@RestController
@RequestMapping("/system/inventory")
public class TextbookInventoryController extends BaseController
{
    @Autowired
    private ITextbookInventoryService textbookInventoryService;

    /**
     * 查询教材库存列表
     */
    @PreAuthorize("@ss.hasPermi('system:inventory:list')")
    @GetMapping("/list")
    public TableDataInfo list(TextbookInventory textbookInventory)
    {
        startPage();
        List<TextbookInventory> list = textbookInventoryService.selectTextbookInventoryList(textbookInventory);
        return getDataTable(list);
    }

    /**
     * 导出教材库存列表
     */
    @PreAuthorize("@ss.hasPermi('system:inventory:export')")
    @Log(title = "教材库存", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, TextbookInventory textbookInventory)
    {
        List<TextbookInventory> list = textbookInventoryService.selectTextbookInventoryList(textbookInventory);
        ExcelUtil<TextbookInventory> util = new ExcelUtil<TextbookInventory>(TextbookInventory.class);
        util.exportExcel(response, list, "教材库存数据");
    }

    /**
     * 获取教材库存详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:inventory:query')")
    @GetMapping(value = "/{inventoryId}")
    public AjaxResult getInfo(@PathVariable("inventoryId") Long inventoryId)
    {
        return success(textbookInventoryService.selectTextbookInventoryByInventoryId(inventoryId));
    }

    /**
     * 新增教材库存
     */
    @PreAuthorize("@ss.hasPermi('system:inventory:add')")
    @Log(title = "教材库存", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody TextbookInventory textbookInventory)
    {
        return toAjax(textbookInventoryService.insertTextbookInventory(textbookInventory));
    }

    /**
     * 修改教材库存
     */
    @PreAuthorize("@ss.hasPermi('system:inventory:edit')")
    @Log(title = "教材库存", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody TextbookInventory textbookInventory)
    {
        return toAjax(textbookInventoryService.updateTextbookInventory(textbookInventory));
    }

    /**
     * 删除教材库存
     */
    @PreAuthorize("@ss.hasPermi('system:inventory:remove')")
    @Log(title = "教材库存", businessType = BusinessType.DELETE)
	@DeleteMapping("/{inventoryIds}")
    public AjaxResult remove(@PathVariable Long[] inventoryIds)
    {
        return toAjax(textbookInventoryService.deleteTextbookInventoryByInventoryIds(inventoryIds));
    }
}

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
import com.ruoyi.system.domain.TextbookPublishers;
import com.ruoyi.system.service.ITextbookPublishersService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 出版社信息Controller
 * 
 * @author cccc
 * @date 2025-12-22
 */
@RestController
@RequestMapping("/system/publishers")
public class TextbookPublishersController extends BaseController
{
    @Autowired
    private ITextbookPublishersService textbookPublishersService;

    /**
     * 查询出版社信息列表
     */
    @PreAuthorize("@ss.hasPermi('system:publishers:list')")
    @GetMapping("/list")
    public TableDataInfo list(TextbookPublishers textbookPublishers)
    {
        startPage();
        List<TextbookPublishers> list = textbookPublishersService.selectTextbookPublishersList(textbookPublishers);
        return getDataTable(list);
    }

    /**
     * 导出出版社信息列表
     */
    @PreAuthorize("@ss.hasPermi('system:publishers:export')")
    @Log(title = "出版社信息", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, TextbookPublishers textbookPublishers)
    {
        List<TextbookPublishers> list = textbookPublishersService.selectTextbookPublishersList(textbookPublishers);
        ExcelUtil<TextbookPublishers> util = new ExcelUtil<TextbookPublishers>(TextbookPublishers.class);
        util.exportExcel(response, list, "出版社信息数据");
    }

    /**
     * 获取出版社信息详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:publishers:query')")
    @GetMapping(value = "/{publisherId}")
    public AjaxResult getInfo(@PathVariable("publisherId") Long publisherId)
    {
        return success(textbookPublishersService.selectTextbookPublishersByPublisherId(publisherId));
    }

    /**
     * 新增出版社信息
     */
    @PreAuthorize("@ss.hasPermi('system:publishers:add')")
    @Log(title = "出版社信息", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody TextbookPublishers textbookPublishers)
    {
        return toAjax(textbookPublishersService.insertTextbookPublishers(textbookPublishers));
    }

    /**
     * 修改出版社信息
     */
    @PreAuthorize("@ss.hasPermi('system:publishers:edit')")
    @Log(title = "出版社信息", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody TextbookPublishers textbookPublishers)
    {
        return toAjax(textbookPublishersService.updateTextbookPublishers(textbookPublishers));
    }

    /**
     * 删除出版社信息
     */
    @PreAuthorize("@ss.hasPermi('system:publishers:remove')")
    @Log(title = "出版社信息", businessType = BusinessType.DELETE)
	@DeleteMapping("/{publisherIds}")
    public AjaxResult remove(@PathVariable Long[] publisherIds)
    {
        return toAjax(textbookPublishersService.deleteTextbookPublishersByPublisherIds(publisherIds));
    }
}

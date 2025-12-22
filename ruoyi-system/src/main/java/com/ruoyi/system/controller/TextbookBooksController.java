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
import com.ruoyi.system.domain.TextbookBooks;
import com.ruoyi.system.service.ITextbookBooksService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 教材信息Controller
 * 
 * @author ccc
 * @date 2025-12-22
 */
@RestController
@RequestMapping("/textbook/books")
public class TextbookBooksController extends BaseController
{
    @Autowired
    private ITextbookBooksService textbookBooksService;

    /**
     * 查询教材信息列表
     */
    @PreAuthorize("@ss.hasPermi('textbook:books:list')")
    @GetMapping("/list")
    public TableDataInfo list(TextbookBooks textbookBooks)
    {
        startPage();
        List<TextbookBooks> list = textbookBooksService.selectTextbookBooksList(textbookBooks);
        return getDataTable(list);
    }

    /**
     * 导出教材信息列表
     */
    @PreAuthorize("@ss.hasPermi('textbook:books:export')")
    @Log(title = "教材信息", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, TextbookBooks textbookBooks)
    {
        List<TextbookBooks> list = textbookBooksService.selectTextbookBooksList(textbookBooks);
        ExcelUtil<TextbookBooks> util = new ExcelUtil<TextbookBooks>(TextbookBooks.class);
        util.exportExcel(response, list, "教材信息数据");
    }

    /**
     * 获取教材信息详细信息
     */
    @PreAuthorize("@ss.hasPermi('textbook:books:query')")
    @GetMapping(value = "/{textbookId}")
    public AjaxResult getInfo(@PathVariable("textbookId") Long textbookId)
    {
        return success(textbookBooksService.selectTextbookBooksByTextbookId(textbookId));
    }

    /**
     * 新增教材信息
     */
    @PreAuthorize("@ss.hasPermi('textbook:books:add')")
    @Log(title = "教材信息", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody TextbookBooks textbookBooks)
    {
        return toAjax(textbookBooksService.insertTextbookBooks(textbookBooks));
    }

    /**
     * 修改教材信息
     */
    @PreAuthorize("@ss.hasPermi('textbook:books:edit')")
    @Log(title = "教材信息", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody TextbookBooks textbookBooks)
    {
        return toAjax(textbookBooksService.updateTextbookBooks(textbookBooks));
    }

    /**
     * 删除教材信息
     */
    @PreAuthorize("@ss.hasPermi('textbook:books:remove')")
    @Log(title = "教材信息", businessType = BusinessType.DELETE)
	@DeleteMapping("/{textbookIds}")
    public AjaxResult remove(@PathVariable Long[] textbookIds)
    {
        return toAjax(textbookBooksService.deleteTextbookBooksByTextbookIds(textbookIds));
    }
}

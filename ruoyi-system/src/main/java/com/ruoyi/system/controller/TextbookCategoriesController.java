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
import com.ruoyi.system.domain.TextbookCategories;
import com.ruoyi.system.service.ITextbookCategoriesService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 教材类型Controller
 * 
 * @author ccc
 * @date 2025-12-22
 */
@RestController
@RequestMapping("/system/categories")
public class TextbookCategoriesController extends BaseController
{
    @Autowired
    private ITextbookCategoriesService textbookCategoriesService;

    /**
     * 查询教材类型列表
     */
    @PreAuthorize("@ss.hasPermi('system:categories:list')")
    @GetMapping("/list")
    public TableDataInfo list(TextbookCategories textbookCategories)
    {
        startPage();
        List<TextbookCategories> list = textbookCategoriesService.selectTextbookCategoriesList(textbookCategories);
        return getDataTable(list);
    }

    /**
     * 导出教材类型列表
     */
    @PreAuthorize("@ss.hasPermi('system:categories:export')")
    @Log(title = "教材类型", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, TextbookCategories textbookCategories)
    {
        List<TextbookCategories> list = textbookCategoriesService.selectTextbookCategoriesList(textbookCategories);
        ExcelUtil<TextbookCategories> util = new ExcelUtil<TextbookCategories>(TextbookCategories.class);
        util.exportExcel(response, list, "教材类型数据");
    }

    /**
     * 获取教材类型详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:categories:query')")
    @GetMapping(value = "/{categoryId}")
    public AjaxResult getInfo(@PathVariable("categoryId") Long categoryId)
    {
        return success(textbookCategoriesService.selectTextbookCategoriesByCategoryId(categoryId));
    }

    /**
     * 新增教材类型
     */
    @PreAuthorize("@ss.hasPermi('system:categories:add')")
    @Log(title = "教材类型", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody TextbookCategories textbookCategories)
    {
        return toAjax(textbookCategoriesService.insertTextbookCategories(textbookCategories));
    }

    /**
     * 修改教材类型
     */
    @PreAuthorize("@ss.hasPermi('system:categories:edit')")
    @Log(title = "教材类型", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody TextbookCategories textbookCategories)
    {
        return toAjax(textbookCategoriesService.updateTextbookCategories(textbookCategories));
    }

    /**
     * 删除教材类型
     */
    @PreAuthorize("@ss.hasPermi('system:categories:remove')")
    @Log(title = "教材类型", businessType = BusinessType.DELETE)
	@DeleteMapping("/{categoryIds}")
    public AjaxResult remove(@PathVariable Long[] categoryIds)
    {
        return toAjax(textbookCategoriesService.deleteTextbookCategoriesByCategoryIds(categoryIds));
    }
}

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
import com.ruoyi.system.domain.TextbookTeachingplan;
import com.ruoyi.system.service.ITextbookTeachingplanService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 教学计划Controller
 * 
 * @author ccc
 * @date 2025-12-25
 */
@RestController
@RequestMapping("/textbook/teachingplan")
public class TextbookTeachingplanController extends BaseController
{
    @Autowired
    private ITextbookTeachingplanService textbookTeachingplanService;

    /**
     * 查询教学计划列表
     */
    @PreAuthorize("@ss.hasPermi('textbook:teachingplan:list')")
    @GetMapping("/list")
    public TableDataInfo list(TextbookTeachingplan textbookTeachingplan)
    {
        startPage();
        List<TextbookTeachingplan> list = textbookTeachingplanService.selectTextbookTeachingplanList(textbookTeachingplan);
        return getDataTable(list);
    }

    /**
     * 导出教学计划列表
     */
    @PreAuthorize("@ss.hasPermi('textbook:teachingplan:export')")
    @Log(title = "教学计划", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, TextbookTeachingplan textbookTeachingplan)
    {
        List<TextbookTeachingplan> list = textbookTeachingplanService.selectTextbookTeachingplanList(textbookTeachingplan);
        ExcelUtil<TextbookTeachingplan> util = new ExcelUtil<TextbookTeachingplan>(TextbookTeachingplan.class);
        util.exportExcel(response, list, "教学计划数据");
    }

    /**
     * 获取教学计划详细信息
     */
    @PreAuthorize("@ss.hasPermi('textbook:teachingplan:query')")
    @GetMapping(value = "/{PlanID}")
    public AjaxResult getInfo(@PathVariable("PlanID") Long PlanID)
    {
        return success(textbookTeachingplanService.selectTextbookTeachingplanByPlanID(PlanID));
    }

    /**
     * 新增教学计划
     */
    @PreAuthorize("@ss.hasPermi('textbook:teachingplan:add')")
    @Log(title = "教学计划", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody TextbookTeachingplan textbookTeachingplan)
    {
        return toAjax(textbookTeachingplanService.insertTextbookTeachingplan(textbookTeachingplan));
    }

    /**
     * 修改教学计划
     */
    @PreAuthorize("@ss.hasPermi('textbook:teachingplan:edit')")
    @Log(title = "教学计划", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody TextbookTeachingplan textbookTeachingplan)
    {
        return toAjax(textbookTeachingplanService.updateTextbookTeachingplan(textbookTeachingplan));
    }

    /**
     * 删除教学计划
     */
    @PreAuthorize("@ss.hasPermi('textbook:teachingplan:remove')")
    @Log(title = "教学计划", businessType = BusinessType.DELETE)
	@DeleteMapping("/{PlanIDs}")
    public AjaxResult remove(@PathVariable Long[] PlanIDs)
    {
        return toAjax(textbookTeachingplanService.deleteTextbookTeachingplanByPlanIDs(PlanIDs));
    }
}

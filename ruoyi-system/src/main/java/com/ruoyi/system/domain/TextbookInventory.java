package com.ruoyi.system.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 教材库存对象 textbook_inventory
 * 
 * @author ccc
 * @date 2025-12-22
 */
public class TextbookInventory extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 库存记录ID */
    private Long inventoryId;

    /** 教材 */
    @Excel(name = "教材")
    private Long textbookId;

    /** 总数量 */
    @Excel(name = "总数量")
    private Long totalQuantity;

    /** 可领用数量 */
    @Excel(name = "可领用数量")
    private Long availableQuantity;

    public void setInventoryId(Long inventoryId) 
    {
        this.inventoryId = inventoryId;
    }

    public Long getInventoryId() 
    {
        return inventoryId;
    }

    public void setTextbookId(Long textbookId) 
    {
        this.textbookId = textbookId;
    }

    public Long getTextbookId() 
    {
        return textbookId;
    }

    public void setTotalQuantity(Long totalQuantity) 
    {
        this.totalQuantity = totalQuantity;
    }

    public Long getTotalQuantity() 
    {
        return totalQuantity;
    }

    public void setAvailableQuantity(Long availableQuantity) 
    {
        this.availableQuantity = availableQuantity;
    }

    public Long getAvailableQuantity() 
    {
        return availableQuantity;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("inventoryId", getInventoryId())
            .append("textbookId", getTextbookId())
            .append("totalQuantity", getTotalQuantity())
            .append("availableQuantity", getAvailableQuantity())
            .toString();
    }
}

package com.ruoyi.system.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 出入库日志对象 textbook_stock_logs
 * 
 * @author ccc
 * @date 2025-12-22
 */
public class TextbookStockLogs extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 日志ID */
    private Long logId;

    /** 教材名称 */
    @Excel(name = "教材名称")
    private Long textbookId;

    /** 操作类型 */
    @Excel(name = "操作类型")
    private Long operation;

    /** 数量 */
    @Excel(name = "数量")
    private Long quantity;

    /** 操作人 */
    @Excel(name = "操作人")
    private Long operatorId;

    /** 征订申请 */
    @Excel(name = "征订申请")
    private Long relatedRequestId;

    /** 备注 */
    @Excel(name = "备注")
    private String notes;

    /** 操作时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "操作时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date createdAt;

    public void setLogId(Long logId) 
    {
        this.logId = logId;
    }

    public Long getLogId() 
    {
        return logId;
    }

    public void setTextbookId(Long textbookId) 
    {
        this.textbookId = textbookId;
    }

    public Long getTextbookId() 
    {
        return textbookId;
    }

    public void setOperation(Long operation) 
    {
        this.operation = operation;
    }

    public Long getOperation() 
    {
        return operation;
    }

    public void setQuantity(Long quantity) 
    {
        this.quantity = quantity;
    }

    public Long getQuantity() 
    {
        return quantity;
    }

    public void setOperatorId(Long operatorId) 
    {
        this.operatorId = operatorId;
    }

    public Long getOperatorId() 
    {
        return operatorId;
    }

    public void setRelatedRequestId(Long relatedRequestId) 
    {
        this.relatedRequestId = relatedRequestId;
    }

    public Long getRelatedRequestId() 
    {
        return relatedRequestId;
    }

    public void setNotes(String notes) 
    {
        this.notes = notes;
    }

    public String getNotes() 
    {
        return notes;
    }

    public void setCreatedAt(Date createdAt) 
    {
        this.createdAt = createdAt;
    }

    public Date getCreatedAt() 
    {
        return createdAt;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("logId", getLogId())
            .append("textbookId", getTextbookId())
            .append("operation", getOperation())
            .append("quantity", getQuantity())
            .append("operatorId", getOperatorId())
            .append("relatedRequestId", getRelatedRequestId())
            .append("notes", getNotes())
            .append("createdAt", getCreatedAt())
            .toString();
    }
}

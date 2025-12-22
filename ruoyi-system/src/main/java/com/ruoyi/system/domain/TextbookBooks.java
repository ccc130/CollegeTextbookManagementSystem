package com.ruoyi.system.domain;

import java.math.BigDecimal;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 教材信息对象 textbook_books
 * 
 * @author ccc
 * @date 2025-12-22
 */
public class TextbookBooks extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 教材ID */
    private Long textbookId;

    /** 图片 */
    @Excel(name = "图片")
    private String picture;

    /** ISBN */
    @Excel(name = "ISBN")
    private String isbn;

    /** 教材名称 */
    @Excel(name = "教材名称")
    private String title;

    /** 作者 */
    @Excel(name = "作者")
    private String author;

    /** 出版社 */
    @Excel(name = "出版社")
    private Long publisherId;

    /** 教材类型 */
    @Excel(name = "教材类型")
    private Long categoryId;

    /** 版次（如 第3版） */
    @Excel(name = "版次", readConverterExp = "如=,第=3版")
    private String edition;

    /** 定价 */
    @Excel(name = "定价")
    private BigDecimal price;

    /** 添加人 */
    @Excel(name = "添加人")
    private Long createdBy;

    /** 创建时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "创建时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date createdAt;

    public void setTextbookId(Long textbookId) 
    {
        this.textbookId = textbookId;
    }

    public Long getTextbookId() 
    {
        return textbookId;
    }

    public void setPicture(String picture) 
    {
        this.picture = picture;
    }

    public String getPicture() 
    {
        return picture;
    }

    public void setIsbn(String isbn) 
    {
        this.isbn = isbn;
    }

    public String getIsbn() 
    {
        return isbn;
    }

    public void setTitle(String title) 
    {
        this.title = title;
    }

    public String getTitle() 
    {
        return title;
    }

    public void setAuthor(String author) 
    {
        this.author = author;
    }

    public String getAuthor() 
    {
        return author;
    }

    public void setPublisherId(Long publisherId) 
    {
        this.publisherId = publisherId;
    }

    public Long getPublisherId() 
    {
        return publisherId;
    }

    public void setCategoryId(Long categoryId) 
    {
        this.categoryId = categoryId;
    }

    public Long getCategoryId() 
    {
        return categoryId;
    }

    public void setEdition(String edition) 
    {
        this.edition = edition;
    }

    public String getEdition() 
    {
        return edition;
    }

    public void setPrice(BigDecimal price) 
    {
        this.price = price;
    }

    public BigDecimal getPrice() 
    {
        return price;
    }

    public void setCreatedBy(Long createdBy) 
    {
        this.createdBy = createdBy;
    }

    public Long getCreatedBy() 
    {
        return createdBy;
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
            .append("textbookId", getTextbookId())
            .append("picture", getPicture())
            .append("isbn", getIsbn())
            .append("title", getTitle())
            .append("author", getAuthor())
            .append("publisherId", getPublisherId())
            .append("categoryId", getCategoryId())
            .append("edition", getEdition())
            .append("price", getPrice())
            .append("createdBy", getCreatedBy())
            .append("createdAt", getCreatedAt())
            .toString();
    }
}

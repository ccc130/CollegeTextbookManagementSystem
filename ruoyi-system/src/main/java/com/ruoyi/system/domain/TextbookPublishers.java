package com.ruoyi.system.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 出版社信息对象 textbook_publishers
 * 
 * @author cccc
 * @date 2025-12-22
 */
public class TextbookPublishers extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 出版社ID */
    private Long publisherId;

    /** 出版社名称 */
    @Excel(name = "出版社名称")
    private String publisherName;

    /** 联系方式 */
    @Excel(name = "联系方式")
    private String contactInfo;

    public void setPublisherId(Long publisherId) 
    {
        this.publisherId = publisherId;
    }

    public Long getPublisherId() 
    {
        return publisherId;
    }

    public void setPublisherName(String publisherName) 
    {
        this.publisherName = publisherName;
    }

    public String getPublisherName() 
    {
        return publisherName;
    }

    public void setContactInfo(String contactInfo) 
    {
        this.contactInfo = contactInfo;
    }

    public String getContactInfo() 
    {
        return contactInfo;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("publisherId", getPublisherId())
            .append("publisherName", getPublisherName())
            .append("contactInfo", getContactInfo())
            .toString();
    }
}

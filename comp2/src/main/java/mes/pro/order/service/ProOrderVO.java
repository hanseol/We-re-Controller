package mes.pro.order.service;

/**
 * @Class Name : ProOrderVO.java
 * @Description : ProOrder VO class
 * @Modification Information
 *
 * @author dahee
 * @since 20210628
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class ProOrderVO extends ProOrderDefaultVO{
    private static final long serialVersionUID = 1L;
    
    /** PRO_ORDER_CODE */
    private java.lang.String proOrderCode;
    
    /** PRO_ORDER_GUBUN */
    private java.lang.String proOrderGubun;
    
    /** PRO_ORDER_QTY */
    private java.math.BigDecimal proOrderQty;
    
    /** PRO_ORDER_RANK */
    private java.math.BigDecimal proOrderRank;
    
    /** PRO_ORDER_DATE */
    private java.sql.Date proOrderDate;
    
    public java.lang.String getProOrderCode() {
        return this.proOrderCode;
    }
    
    public void setProOrderCode(java.lang.String proOrderCode) {
        this.proOrderCode = proOrderCode;
    }
    
    public java.lang.String getProOrderGubun() {
        return this.proOrderGubun;
    }
    
    public void setProOrderGubun(java.lang.String proOrderGubun) {
        this.proOrderGubun = proOrderGubun;
    }
    
    public java.math.BigDecimal getProOrderQty() {
        return this.proOrderQty;
    }
    
    public void setProOrderQty(java.math.BigDecimal proOrderQty) {
        this.proOrderQty = proOrderQty;
    }
    
    public java.math.BigDecimal getProOrderRank() {
        return this.proOrderRank;
    }
    
    public void setProOrderRank(java.math.BigDecimal proOrderRank) {
        this.proOrderRank = proOrderRank;
    }
    
    public java.sql.Date getProOrderDate() {
        return this.proOrderDate;
    }
    
    public void setProOrderDate(java.sql.Date proOrderDate) {
        this.proOrderDate = proOrderDate;
    }
    
}

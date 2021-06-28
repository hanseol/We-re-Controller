package mes.pro.order.service;

/**
 * @Class Name : ProOrderDetailVO.java
 * @Description : ProOrderDetail VO class
 * @Modification Information
 *
 * @author dahee
 * @since 20210628
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class ProOrderDetailVO extends ProOrderDetailDefaultVO{
    private static final long serialVersionUID = 1L;
    
    /** PRO_ORDER_DETAIL_CODE */
    private java.lang.String proOrderDetailCode;
    
    /** PRO_ORDER_CODE */
    private java.lang.String proOrderCode;
    
    /** PRO_PLAN_DETAIL_CODE */
    private java.lang.String proPlanDetailCode;
    
    /** ERP_PRODUCT_DEADLINE */
    private java.sql.Date erpProductDeadline;
    
    /** PRO_ORDER_DATE */
    private java.sql.Date proOrderDate;
    
    /** ERP_CUSTOMER_CODE */
    private java.lang.String erpCustomerCode;
    
    /** PRO_ORDER_EXPECT_QTY */
    private java.math.BigDecimal proOrderExpectQty;
    
    /** PRO_ORDER_DAY_QTY */
    private java.math.BigDecimal proOrderDayQty;
    
    /** PRO_ORDER_SEQ */
    private java.math.BigDecimal proOrderSeq;
    
    /** PRO_ORDER_ORDER_QTY */
    private java.math.BigDecimal proOrderOrderQty;
    
    /** PRO_ORDER_QTY */
    private java.math.BigDecimal proOrderQty;
    
    public java.lang.String getProOrderDetailCode() {
        return this.proOrderDetailCode;
    }
    
    public void setProOrderDetailCode(java.lang.String proOrderDetailCode) {
        this.proOrderDetailCode = proOrderDetailCode;
    }
    
    public java.lang.String getProOrderCode() {
        return this.proOrderCode;
    }
    
    public void setProOrderCode(java.lang.String proOrderCode) {
        this.proOrderCode = proOrderCode;
    }
    
    public java.lang.String getProPlanDetailCode() {
        return this.proPlanDetailCode;
    }
    
    public void setProPlanDetailCode(java.lang.String proPlanDetailCode) {
        this.proPlanDetailCode = proPlanDetailCode;
    }
    
    public java.sql.Date getErpProductDeadline() {
        return this.erpProductDeadline;
    }
    
    public void setErpProductDeadline(java.sql.Date erpProductDeadline) {
        this.erpProductDeadline = erpProductDeadline;
    }
    
    public java.sql.Date getProOrderDate() {
        return this.proOrderDate;
    }
    
    public void setProOrderDate(java.sql.Date proOrderDate) {
        this.proOrderDate = proOrderDate;
    }
    
    public java.lang.String getErpCustomerCode() {
        return this.erpCustomerCode;
    }
    
    public void setErpCustomerCode(java.lang.String erpCustomerCode) {
        this.erpCustomerCode = erpCustomerCode;
    }
    
    public java.math.BigDecimal getProOrderExpectQty() {
        return this.proOrderExpectQty;
    }
    
    public void setProOrderExpectQty(java.math.BigDecimal proOrderExpectQty) {
        this.proOrderExpectQty = proOrderExpectQty;
    }
    
    public java.math.BigDecimal getProOrderDayQty() {
        return this.proOrderDayQty;
    }
    
    public void setProOrderDayQty(java.math.BigDecimal proOrderDayQty) {
        this.proOrderDayQty = proOrderDayQty;
    }
    
    public java.math.BigDecimal getProOrderSeq() {
        return this.proOrderSeq;
    }
    
    public void setProOrderSeq(java.math.BigDecimal proOrderSeq) {
        this.proOrderSeq = proOrderSeq;
    }
    
    public java.math.BigDecimal getProOrderOrderQty() {
        return this.proOrderOrderQty;
    }
    
    public void setProOrderOrderQty(java.math.BigDecimal proOrderOrderQty) {
        this.proOrderOrderQty = proOrderOrderQty;
    }
    
    public java.math.BigDecimal getProOrderQty() {
        return this.proOrderQty;
    }
    
    public void setProOrderQty(java.math.BigDecimal proOrderQty) {
        this.proOrderQty = proOrderQty;
    }
    
}

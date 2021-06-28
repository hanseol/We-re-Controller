package mes.pro.plan.service;

/**
 * @Class Name : ProPlanVO.java
 * @Description : ProPlan VO class
 * @Modification Information
 *
 * @author dahee
 * @since 20210628
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class ProPlanVO extends ProPlanDefaultVO{
    private static final long serialVersionUID = 1L;
    
    
    //생산관리M 테이블
    /** PRO_PLAN_CODE */
    private java.lang.String proPlanCode;
    
    /** PRO_PLAN_NAME */
    private java.lang.String proPlanName;
    
    /** PRO_PLAN_DATE */
    private java.sql.Date proPlanDate;
    
    /** ERP_CUSTOMER_CODE */
    private java.lang.String erpCustomerCode;
    
    public java.lang.String getProPlanCode() {
        return this.proPlanCode;
    }
    
    public void setProPlanCode(java.lang.String proPlanCode) {
        this.proPlanCode = proPlanCode;
    }
    
    public java.lang.String getProPlanName() {
        return this.proPlanName;
    }
    
    public void setProPlanName(java.lang.String proPlanName) {
        this.proPlanName = proPlanName;
    }
    
    public java.sql.Date getProPlanDate() {
        return this.proPlanDate;
    }
    
    public void setProPlanDate(java.sql.Date proPlanDate) {
        this.proPlanDate = proPlanDate;
    }
    
    public java.lang.String getErpCustomerCode() {
        return this.erpCustomerCode;
    }
    
    public void setErpCustomerCode(java.lang.String erpCustomerCode) {
        this.erpCustomerCode = erpCustomerCode;
    }
    
    
    
    //생산관리D 테이블
    /** PRO_PLAN_DETAIL_CODE */
    private java.lang.String proPlanDetailCode;
    
    /** ERP_ORDER_CODE */
    private java.lang.String erpOrderCode;
    
    /** ERP_PRODUCT_DEADLINE */
    private java.sql.Date erpProductDeadline;
    
    /** PRO_PLAN_EXPECT_QTY */
    private java.math.BigDecimal proPlanExpectQty;
    
    /** PRO_PLAN_DAY_QTY */
    private java.math.BigDecimal proPlanDayQty;
    
    /** PRO_PLAN_SEQ */
    private java.math.BigDecimal proPlanSeq;
    
    /** ERP_ORDER_QTY */
    private java.math.BigDecimal erpOrderQty;
    
    /** PRO_PLAN_QTY */
    private java.math.BigDecimal proPlanQty;
    
    public java.lang.String getProPlanDetailCode() {
        return this.proPlanDetailCode;
    }
    
    public void setProPlanDetailCode(java.lang.String proPlanDetailCode) {
        this.proPlanDetailCode = proPlanDetailCode;
    }
    
    public java.lang.String getErpOrderCode() {
        return this.erpOrderCode;
    }
    
    public void setErpOrderCode(java.lang.String erpOrderCode) {
        this.erpOrderCode = erpOrderCode;
    }
    
    public java.sql.Date getErpProductDeadline() {
        return this.erpProductDeadline;
    }
    
    public void setErpProductDeadline(java.sql.Date erpProductDeadline) {
        this.erpProductDeadline = erpProductDeadline;
    }
    
    
    public java.math.BigDecimal getProPlanExpectQty() {
        return this.proPlanExpectQty;
    }
    
    public void setProPlanExpectQty(java.math.BigDecimal proPlanExpectQty) {
        this.proPlanExpectQty = proPlanExpectQty;
    }
    
    public java.math.BigDecimal getProPlanDayQty() {
        return this.proPlanDayQty;
    }
    
    public void setProPlanDayQty(java.math.BigDecimal proPlanDayQty) {
        this.proPlanDayQty = proPlanDayQty;
    }
    
    public java.math.BigDecimal getProPlanSeq() {
        return this.proPlanSeq;
    }
    
    public void setProPlanSeq(java.math.BigDecimal proPlanSeq) {
        this.proPlanSeq = proPlanSeq;
    }
    
    public java.math.BigDecimal getErpOrderQty() {
        return this.erpOrderQty;
    }
    
    public void setErpOrderQty(java.math.BigDecimal erpOrderQty) {
        this.erpOrderQty = erpOrderQty;
    }
    
    public java.math.BigDecimal getProPlanQty() {
        return this.proPlanQty;
    }
    
    public void setProPlanQty(java.math.BigDecimal proPlanQty) {
        this.proPlanQty = proPlanQty;
    }
    
    
    
}

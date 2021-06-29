package mes.qua.chk.service;

/**
 * @Class Name : QuaMaterialChkVO.java
 * @Description : QuaMaterialChk VO class
 * @Modification Information
 *
 * @author sungwon
 * @since 20210629
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class QuaMaterialChkVO extends QuaMaterialChkDefaultVO{
    private static final long serialVersionUID = 1L;
    
    /** QUA_MATERIAL_STATEMENT */
    private java.lang.String quaMaterialStatement;
    
    /** QUA_MATERIAL_DATE */
    private java.sql.Date quaMaterialDate;
    
    /** ERP_VENDOR_CODE */
    private java.lang.String erpVendorCode;
    
    /** COM_MATERIAL_CODE */
    private java.lang.String comMaterialCode;
    
    /** QUA_MATERIAL_CHK */
    private java.lang.String quaMaterialChk;
    
    /** QUA_MATERIAL_P_QTY */
    private java.math.BigDecimal quaMaterialPQty;
    
    /** QUA_MATERIAL_F_QTY */
    private java.math.BigDecimal quaMaterialFQty;
    
    /** QUA_MATERIAL_CHK_DATE */
    private java.sql.Date quaMaterialChkDate;
    
    /** ERP_MATERIAL_ORDER_CODE */
    private java.lang.String erpMaterialOrderCode;
    
    public java.lang.String getQuaMaterialStatement() {
        return this.quaMaterialStatement;
    }
    
    public void setQuaMaterialStatement(java.lang.String quaMaterialStatement) {
        this.quaMaterialStatement = quaMaterialStatement;
    }
    
    public java.sql.Date getQuaMaterialDate() {
        return this.quaMaterialDate;
    }
    
    public void setQuaMaterialDate(java.sql.Date quaMaterialDate) {
        this.quaMaterialDate = quaMaterialDate;
    }
    
    public java.lang.String getErpVendorCode() {
        return this.erpVendorCode;
    }
    
    public void setErpVendorCode(java.lang.String erpVendorCode) {
        this.erpVendorCode = erpVendorCode;
    }
    
    public java.lang.String getComMaterialCode() {
        return this.comMaterialCode;
    }
    
    public void setComMaterialCode(java.lang.String comMaterialCode) {
        this.comMaterialCode = comMaterialCode;
    }
    
    public java.lang.String getQuaMaterialChk() {
        return this.quaMaterialChk;
    }
    
    public void setQuaMaterialChk(java.lang.String quaMaterialChk) {
        this.quaMaterialChk = quaMaterialChk;
    }
    
    public java.math.BigDecimal getQuaMaterialPQty() {
        return this.quaMaterialPQty;
    }
    
    public void setQuaMaterialPQty(java.math.BigDecimal quaMaterialPQty) {
        this.quaMaterialPQty = quaMaterialPQty;
    }
    
    public java.math.BigDecimal getQuaMaterialFQty() {
        return this.quaMaterialFQty;
    }
    
    public void setQuaMaterialFQty(java.math.BigDecimal quaMaterialFQty) {
        this.quaMaterialFQty = quaMaterialFQty;
    }
    
    public java.sql.Date getQuaMaterialChkDate() {
        return this.quaMaterialChkDate;
    }
    
    public void setQuaMaterialChkDate(java.sql.Date quaMaterialChkDate) {
        this.quaMaterialChkDate = quaMaterialChkDate;
    }
    
    public java.lang.String getErpMaterialOrderCode() {
        return this.erpMaterialOrderCode;
    }
    
    public void setErpMaterialOrderCode(java.lang.String erpMaterialOrderCode) {
        this.erpMaterialOrderCode = erpMaterialOrderCode;
    }
    
}

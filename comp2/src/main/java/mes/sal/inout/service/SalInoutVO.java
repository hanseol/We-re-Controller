package mes.sal.inout.service;

/**
 * @Class Name : SalInoutVO.java
 * @Description : SalInout VO class
 * @Modification Information
 *
 * @author hk
 * @since 2021-06-28
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

public class SalInoutVO extends SalInoutDefaultVO{
    private static final long serialVersionUID = 1L;
    
    /** SAL_INOUT_STATEMENT */
    private java.lang.String salInoutStatement;
    
    /** COM_PRODUCT_CODE */
    private java.lang.String comProductCode;
    
    /** SAL_INOUT_DATE */
    private java.sql.Date salInoutDate;
    
    /** SAL_INOUT_QUANTITY */
    private java.math.BigDecimal salInoutQuantity;
    
    /** SAL_INOUT_CODE */
    private java.lang.String salInoutCode;
    
    /** SAL_INOUT_GUBUN */
    private java.lang.String salInoutGubun;
    
    /** PRO_PROCESS_LOT_NO */
    private java.lang.String proProcessLotNo;
    
    public java.lang.String getSalInoutStatement() {
        return this.salInoutStatement;
    }
    
    public void setSalInoutStatement(java.lang.String salInoutStatement) {
        this.salInoutStatement = salInoutStatement;
    }
    
    public java.lang.String getComProductCode() {
        return this.comProductCode;
    }
    
    public void setComProductCode(java.lang.String comProductCode) {
        this.comProductCode = comProductCode;
    }
    
    public java.sql.Date getSalInoutDate() {
        return this.salInoutDate;
    }
    
    public void setSalInoutDate(java.sql.Date salInoutDate) {
        this.salInoutDate = salInoutDate;
    }
    
    public java.math.BigDecimal getSalInoutQuantity() {
        return this.salInoutQuantity;
    }
    
    public void setSalInoutQuantity(java.math.BigDecimal salInoutQuantity) {
        this.salInoutQuantity = salInoutQuantity;
    }
    
    public java.lang.String getSalInoutCode() {
        return this.salInoutCode;
    }
    
    public void setSalInoutCode(java.lang.String salInoutCode) {
        this.salInoutCode = salInoutCode;
    }
    
    public java.lang.String getSalInoutGubun() {
        return this.salInoutGubun;
    }
    
    public void setSalInoutGubun(java.lang.String salInoutGubun) {
        this.salInoutGubun = salInoutGubun;
    }
    
    public java.lang.String getProProcessLotNo() {
        return this.proProcessLotNo;
    }
    
    public void setProProcessLotNo(java.lang.String proProcessLotNo) {
        this.proProcessLotNo = proProcessLotNo;
    }
    
}

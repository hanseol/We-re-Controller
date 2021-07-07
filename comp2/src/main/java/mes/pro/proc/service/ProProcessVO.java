package mes.pro.proc.service;

import mes.main.service.SearchVO;

/**
 * @Class Name : ProProcessVO.java
 * @Description : ProProcess VO class
 * @Modification Information
 *
 * @author dahee
 * @since 20210707
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class ProProcessVO extends SearchVO{
    private static final long serialVersionUID = 1L;
    
    /** COM_PROCESS_CODE */
    private java.lang.String comProcessCode;
    
    /** PRO_ORDER_DETAIL_CODE */
    private java.lang.String proOrderDetailCode;
    
    /** COM_PRODUCT_F_CODE */
    private java.lang.String comProductFCode;
    
    /** PRO_PROCESS_F_QTY */
    private java.math.BigDecimal proProcessFQty;
    
    /** MAC_LINE_NO */
    private java.math.BigDecimal macLineNo;
    
    /** PRO_PROCESS_START_TIME */
    private java.sql.Date proProcessStartTime;
    
    /** PRO_PROCESS_END_TIME */
    private java.sql.Date proProcessEndTime;
    
    /** ERP_EMPLOYEE_ID */
    private java.math.BigDecimal erpEmployeeId;
    
    /** MAC_CODE */
    private java.lang.String macCode;
    
    /** PRO_PROCESS_LOT_NO */
    private java.lang.String proProcessLotNo;
    
    /** PRO_PROCESS_QUANTITY */
    private java.math.BigDecimal proProcessQuantity;
    
    public java.lang.String getComProcessCode() {
        return this.comProcessCode;
    }
    
    public void setComProcessCode(java.lang.String comProcessCode) {
        this.comProcessCode = comProcessCode;
    }
    
    public java.lang.String getProOrderDetailCode() {
        return this.proOrderDetailCode;
    }
    
    public void setProOrderDetailCode(java.lang.String proOrderDetailCode) {
        this.proOrderDetailCode = proOrderDetailCode;
    }
    
    public java.lang.String getComProductFCode() {
        return this.comProductFCode;
    }
    
    public void setComProductFCode(java.lang.String comProductFCode) {
        this.comProductFCode = comProductFCode;
    }
    
    public java.math.BigDecimal getProProcessFQty() {
        return this.proProcessFQty;
    }
    
    public void setProProcessFQty(java.math.BigDecimal proProcessFQty) {
        this.proProcessFQty = proProcessFQty;
    }
    
    public java.math.BigDecimal getMacLineNo() {
        return this.macLineNo;
    }
    
    public void setMacLineNo(java.math.BigDecimal macLineNo) {
        this.macLineNo = macLineNo;
    }
    
    public java.sql.Date getProProcessStartTime() {
        return this.proProcessStartTime;
    }
    
    public void setProProcessStartTime(java.sql.Date proProcessStartTime) {
        this.proProcessStartTime = proProcessStartTime;
    }
    
    public java.sql.Date getProProcessEndTime() {
        return this.proProcessEndTime;
    }
    
    public void setProProcessEndTime(java.sql.Date proProcessEndTime) {
        this.proProcessEndTime = proProcessEndTime;
    }
    
    public java.math.BigDecimal getErpEmployeeId() {
        return this.erpEmployeeId;
    }
    
    public void setErpEmployeeId(java.math.BigDecimal erpEmployeeId) {
        this.erpEmployeeId = erpEmployeeId;
    }
    
    public java.lang.String getMacCode() {
        return this.macCode;
    }
    
    public void setMacCode(java.lang.String macCode) {
        this.macCode = macCode;
    }
    
    public java.lang.String getProProcessLotNo() {
        return this.proProcessLotNo;
    }
    
    public void setProProcessLotNo(java.lang.String proProcessLotNo) {
        this.proProcessLotNo = proProcessLotNo;
    }
    
    public java.math.BigDecimal getProProcessQuantity() {
        return this.proProcessQuantity;
    }
    
    public void setProProcessQuantity(java.math.BigDecimal proProcessQuantity) {
        this.proProcessQuantity = proProcessQuantity;
    }
    
}

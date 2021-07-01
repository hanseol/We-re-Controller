package mes.mat.inout.service;

import org.springframework.format.annotation.DateTimeFormat;

import mes.main.service.SearchVO;

/**
 * @Class Name : MatInoutVO.java
 * @Description : MatInout VO class
 * @Modification Information
 *
 * @author sungwon
 * @since 20210625
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class MatInoutVO extends SearchVO{
    private static final long serialVersionUID = 1L;
    
    /** MAT_INOUT_STATEMENT */
    private java.lang.String matInoutStatement;
    
    /** COM_MATERIAL_CODE */
    private java.lang.String comMaterialCode;
    
    /** MAT_INOUT_DATE */
    @DateTimeFormat(pattern ="yyyy/MM/dd HH:MI:SS")
    private java.lang.String matInoutDate;
    
    /** MAT_INOUT_GUBUN */
    private java.lang.String matInoutGubun;
    
    /** MAT_INOUT_QUANTITY */
    private java.math.BigDecimal matInoutQuantity;
    
    /** MAT_LOT_NO */
    private java.lang.String matLotNo;
    
    /** COM_PROCESS_CODE */
    private java.lang.String comProcessCode;
    
    /** MAT_INOUT_UNIT_PRICE */
    private java.math.BigDecimal matInoutUnitPrice;
    
    /** MAT_INOUT_PRICE */
    private java.math.BigDecimal matInoutPrice;
    
    public java.lang.String getMatInoutStatement() {
        return this.matInoutStatement;
    }
    
    public void setMatInoutStatement(java.lang.String matInoutStatement) {
        this.matInoutStatement = matInoutStatement;
    }
    
    public java.lang.String getComMaterialCode() {
        return this.comMaterialCode;
    }
    
    public void setComMaterialCode(java.lang.String comMaterialCode) {
        this.comMaterialCode = comMaterialCode;
    }
    
    public java.lang.String getMatInoutDate() {
        return this.matInoutDate;
    }
    
    public void setMatInoutDate(java.lang.String matInoutDate) {
        this.matInoutDate = matInoutDate;
    }
    
    public java.lang.String getMatInoutGubun() {
        return this.matInoutGubun;
    }
    
    public void setMatInoutGubun(java.lang.String matInoutGubun) {
        this.matInoutGubun = matInoutGubun;
    }
    
    public java.math.BigDecimal getMatInoutQuantity() {
        return this.matInoutQuantity;
    }
    
    public void setMatInoutQuantity(java.math.BigDecimal matInoutQuantity) {
        this.matInoutQuantity = matInoutQuantity;
    }
    
    public java.lang.String getMatLotNo() {
        return this.matLotNo;
    }
    
    public void setMatLotNo(java.lang.String matLotNo) {
        this.matLotNo = matLotNo;
    }
    
    public java.lang.String getComProcessCode() {
        return this.comProcessCode;
    }
    
    public void setComProcessCode(java.lang.String comProcessCode) {
        this.comProcessCode = comProcessCode;
    }
    
    public java.math.BigDecimal getMatInoutUnitPrice() {
        return this.matInoutUnitPrice;
    }
    
    public void setMatInoutUnitPrice(java.math.BigDecimal matInoutUnitPrice) {
        this.matInoutUnitPrice = matInoutUnitPrice;
    }
    
    public java.math.BigDecimal getMatInoutPrice() {
        return this.matInoutPrice;
    }
    
    public void setMatInoutPrice(java.math.BigDecimal matInoutPrice) {
        this.matInoutPrice = matInoutPrice;
    }
    
}

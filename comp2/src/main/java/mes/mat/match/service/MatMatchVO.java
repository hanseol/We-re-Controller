package mes.mat.match.service;

import org.springframework.format.annotation.DateTimeFormat;

import mes.main.service.SearchVO;

/**
 * @Class Name : MatMatchVO.java
 * @Description : MatMatch VO class
 * @Modification Information
 *
 * @author sungwon
 * @since 20210625
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class MatMatchVO extends SearchVO{
    private static final long serialVersionUID = 1L;
    
    /** MAT_MATCH_STATEMENT */
    private java.lang.String matMatchStatement;
    
    /** COM_MATERIAL_CODE */
    private java.lang.String comMaterialCode;
    
    /** MAT_LOT_NO */
    private java.lang.String matLotNo;
    
    /** MAT_MATCH_INOUT */
    private java.lang.String matMatchInout;
    
    /** MAT_MATCH_QTY */
    private java.math.BigDecimal matMatchQty;
    
    /** MAT_MATCH_DATE */
    @DateTimeFormat(pattern ="yyyy/MM/dd HH:MI:SS")
    private java.lang.String matMatchDate;
    
    public java.lang.String getMatMatchStatement() {
        return this.matMatchStatement;
    }
    
    public void setMatMatchStatement(java.lang.String matMatchStatement) {
        this.matMatchStatement = matMatchStatement;
    }
    
    public java.lang.String getComMaterialCode() {
        return this.comMaterialCode;
    }
    
    public void setComMaterialCode(java.lang.String comMaterialCode) {
        this.comMaterialCode = comMaterialCode;
    }
    
    public java.lang.String getMatLotNo() {
        return this.matLotNo;
    }
    
    public void setMatLotNo(java.lang.String matLotNo) {
        this.matLotNo = matLotNo;
    }
    
    public java.lang.String getMatMatchInout() {
        return this.matMatchInout;
    }
    
    public void setMatMatchInout(java.lang.String matMatchInout) {
        this.matMatchInout = matMatchInout;
    }
    
    public java.math.BigDecimal getMatMatchQty() {
        return this.matMatchQty;
    }
    
    public void setMatMatchQty(java.math.BigDecimal matMatchQty) {
        this.matMatchQty = matMatchQty;
    }
    
    public java.lang.String getMatMatchDate() {
        return this.matMatchDate;
    }
    
    public void setMatMatchDate(java.lang.String matMatchDate) {
        this.matMatchDate = matMatchDate;
    }
    
}

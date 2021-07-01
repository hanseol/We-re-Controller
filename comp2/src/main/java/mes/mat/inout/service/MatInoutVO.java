package mes.mat.inout.service;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;
import lombok.EqualsAndHashCode;
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
@Data
@EqualsAndHashCode(callSuper=false)
public class MatInoutVO extends SearchVO{
    private static final long serialVersionUID = 1L;
    
    /** MAT_INOUT_STATEMENT */
    private java.lang.String matInoutStatement;
    
    /** COM_MATERIAL_CODE */
    private java.lang.String comMaterialCode;
    
    /** MAT_INOUT_DATE */
    @DateTimeFormat(pattern ="yyyy/MM/dd")
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

}

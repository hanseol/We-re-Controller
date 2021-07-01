package mes.mat.match.service;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;
import lombok.EqualsAndHashCode;
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
@Data
@EqualsAndHashCode(callSuper = false)
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

}

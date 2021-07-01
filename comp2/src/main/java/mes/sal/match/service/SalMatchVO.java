package mes.sal.match.service;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import mes.main.service.SearchVO;

/**
 * @Class Name : SalMatchVO.java
 * @Description : SalMatch VO class
 * @Modification Information
 *
 * @author hk
 * @since 2021-06-29
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
@Data
@NoArgsConstructor
@EqualsAndHashCode(callSuper=false)
public class SalMatchVO extends SearchVO{
    private static final long serialVersionUID = 1L;
    
    /** SAL_MATCH_STATEMENT */
    private java.lang.String salMatchStatement;
    
    /** SAL_MATCH_INOUT */
    private java.lang.String salMatchInout;
    
    /** SAL_MATCH_DATE */
    @DateTimeFormat(pattern ="yyyy/MM/dd HH:mm:SS")	
    private Date salMatchDate;
    
    /** SAL_MATCH_QTY */
    private java.math.BigDecimal salMatchQty;
    
    /** COM_PRODUCT_CODE */
    private java.lang.String comProductCode;
    
    /** PRO_PROCESS_LOT_NO */
    private java.lang.String proProcessLotNo;
   
    
}

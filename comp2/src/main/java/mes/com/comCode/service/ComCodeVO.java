package mes.com.comCode.service;

import lombok.Data;
import lombok.EqualsAndHashCode;
import mes.main.service.SearchVO;

/**
 * @Class Name : ComCodeVO.java
 * @Description : ComCode VO class
 * @Modification Information
 *
 * @author 경윤수
 * @since 2021-06-30
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
@Data
@EqualsAndHashCode(callSuper=false)
public class ComCodeVO extends SearchVO{
    private static final long serialVersionUID = 1L;

    private java.lang.String comCodeId;
    
    private java.lang.String comCodeName;
    
    private java.lang.String comCodeDesc;
    
    private java.lang.String comCodeUsedchk;
    
    private java.lang.String comCodeDetailId;
    
    private java.lang.String comCodeDetailName;
    
    private java.lang.String comCodeDetailDesc;
    
    private java.math.BigDecimal comCodeDetailSeq;
    
    private java.lang.String comCodeDetailUsedchk;
    
}

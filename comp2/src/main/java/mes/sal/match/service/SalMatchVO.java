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
    
    private java.lang.String salMatchStatement;
    
    private java.lang.String salMatchInout;
    
    @DateTimeFormat(pattern ="yyyy/MM/dd")
    private java.lang.String salMatchDate;
    
    private java.math.BigDecimal salMatchQty;
    
    private java.lang.String comProductCode;
    
    private java.lang.String proProcessLotNo;
    
    //작성일
    @DateTimeFormat(pattern ="yyyy/MM/dd")
    private java.lang.String salWriteDate;
    
    //제품명
    private java.lang.String comProductName;
   
    
}

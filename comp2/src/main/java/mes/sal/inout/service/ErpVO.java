package mes.sal.inout.service;

import org.springframework.format.annotation.DateTimeFormat;

import mes.main.service.SearchVO;

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

public class ErpVO extends SearchVO{
    private static final long serialVersionUID = 1L;
    
    private java.lang.String erpOrderCode;
    
    private java.lang.String erpProductCode;
    
    private java.math.BigDecimal erpOrderQty;
    
    private java.lang.String erpCustomerCode;
    
    private java.math.BigDecimal erpProductUnitPrice;
    
    @DateTimeFormat(pattern ="yyyy/MM/dd HH:MI:SS")
    private java.lang.String erpProductDeadline;
    
    @DateTimeFormat(pattern ="yyyy/MM/dd HH:MI:SS")
    private java.lang.String erpProductOrderDate;

    private java.lang.String erpProductName;

    
}

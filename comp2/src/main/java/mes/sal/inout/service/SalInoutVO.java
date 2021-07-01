package mes.sal.inout.service;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
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

@Data
@EqualsAndHashCode(callSuper=false)
@NoArgsConstructor
public class SalInoutVO extends SearchVO{
    private static final long serialVersionUID = 1L;
    
    /** SAL_INOUT_STATEMENT */
    private java.lang.String salInoutStatement;
    
    /** COM_PRODUCT_CODE */
    private java.lang.String comProductCode;
    
    /** SAL_INOUT_DATE */
    @DateTimeFormat(pattern ="yyyy/MM/dd")
    private java.lang.String salInoutDate;
    
    /** SAL_INOUT_QUANTITY */
    private java.math.BigDecimal salInoutQuantity;
    
    /** SAL_INOUT_CODE */
    private java.lang.String salInoutCode;
    
    /** SAL_INOUT_GUBUN */
    private java.lang.String salInoutGubun;
    
    /** PRO_PROCESS_LOT_NO */
    private java.lang.String proProcessLotNo;
    
    //제품명
    private java.lang.String comProductName;
    
    public java.lang.String getComProductName() {
		return comProductName;
	}
    
    //ERP
    private java.lang.String erpOrderCode;
    
    private java.lang.String erpProductCode;
    
    private java.math.BigDecimal erpOrderQty;
    
    private java.lang.String erpCustomerCode;
    
    private java.math.BigDecimal erpProductUnitPrice;
    
    @DateTimeFormat(pattern ="yyyy/MM/dd")
    @JsonFormat(pattern = "yyyy-MM-dd")
    private java.lang.String erpProductDeadline;
    
    @DateTimeFormat(pattern ="yyyy/MM/dd")
    @JsonFormat(pattern = "yyyy-MM-dd")
    private java.lang.String erpProductOrderDate;
    
    private java.lang.String erpProductName;


    
}

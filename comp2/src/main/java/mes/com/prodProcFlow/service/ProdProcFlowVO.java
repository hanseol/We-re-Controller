package mes.com.prodProcFlow.service;

import org.springframework.format.annotation.DateTimeFormat;

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
public class ProdProcFlowVO extends SearchVO{
    private static final long serialVersionUID = 1L;
    
    //COM_PRODUCT
    private java.lang.String comProductCode;
    private java.lang.String comProductName;
    private java.lang.String comProductSize;
    private java.lang.String comProductUnit;
    private java.lang.String comProductUse;
    private java.lang.String comProductImage;
    private java.lang.String comProductQtyImage;
    private java.lang.String comProductFloorImage;
    
    //SAL_INOUT
    private java.lang.String salInoutStatement;
    @DateTimeFormat(pattern ="yyyy/MM/dd")
    private java.lang.String salInoutDate; //date
    private java.math.BigDecimal salInoutQuantity; //number
    private java.lang.String salInoutCode;
    private java.lang.String salInoutGubun;
    private java.lang.String proProcessLotNo;
    @DateTimeFormat(pattern ="yyyy/MM/dd")
    private java.lang.String salWriteDate; //date
    
    //COM_CODE_DETAIL
    private java.lang.String comCodeDetailId;
    private java.lang.String comCodeId;
    private java.lang.String comCodeDetailName;
    private java.lang.String comCodeDetailDesc;
    private java.math.BigDecimal comCodeDetailSeq; //number
    private java.lang.String comCodeDetailUsedchk;
    
    //COM_PROCESS
    private java.lang.String comProcessCode;
    private java.math.BigDecimal comProcessSeq; //number
    
    //COM_PROCESS_DETAIL
    private java.lang.String comProcessName;
    private java.lang.String comProcessDesc;
    private java.lang.String comProcessUnit;
    private java.math.BigDecimal comProcessBuha; //number
    private java.math.BigDecimal comProcessUnitPrice; //number
    private java.lang.String comProcessLeadtime; //date
    private java.math.BigDecimal comProcessProductDay; //number
    private java.lang.String comProcessGubun;
    private java.lang.String comProcessEtc;
}

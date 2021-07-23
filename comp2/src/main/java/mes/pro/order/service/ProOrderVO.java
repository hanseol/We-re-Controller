package mes.pro.order.service;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import mes.main.service.SearchVO;

/**
 * @Class Name : ProOrderVO.java
 * @Description : ProOrder VO class
 * @Modification Information
 *
 * @author dahee
 * @since 20210628
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Data
@EqualsAndHashCode(callSuper=false)
@NoArgsConstructor
public class ProOrderVO extends SearchVO{
    private static final long serialVersionUID = 1L;
    
    //pro_order 테이블
    private java.lang.String proOrderCode;
    private java.lang.String proOrderGubun;
    private java.math.BigDecimal proOrderQty;
    private java.math.BigDecimal proOrderRank;
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private java.lang.String proOrderDate;
    
    //확장
    //pro_order_detail 테이블
    private java.lang.String proOrderDetailCode;
    private java.lang.String proPlanDetailCode;
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private java.lang.String erpProductDeadline;
    private java.lang.String erpCustomerCode;
    private java.math.BigDecimal proOrderExpectQty;
    private java.math.BigDecimal proOrderDayQty;
    private java.math.BigDecimal proOrderSeq;
    private java.math.BigDecimal proOrderOrderQty;
    
    //추가
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private java.lang.String proWorkDate;
    private java.lang.String erpProductCode;
    private java.lang.String erpProductName;
    private java.lang.String erpOrderCode;
    private java.lang.String erpOrderQty;
    
    private java.lang.String macHourQty;
    private java.lang.String dayQty;
    private java.lang.String dayCount;
    
    private java.lang.String proMaterialLot;
    
    private java.lang.String comProductCode;
    
    private java.lang.String comMaterialCode;
    private java.lang.String comMaterialName;
    private java.lang.String comProcessCode;
    
    private java.lang.String matLotNo;
    private java.lang.String matInoutDate;
    private java.lang.String matInoutQuantity;
    private java.lang.String matInoutGubun;
    private java.lang.String matInoutUnitPrice;
    private java.lang.String matInoutPrice;
    
    private java.lang.String proPlanQty;
    private java.lang.String ProProcessLotNo;
    private java.lang.String matInoutStatement;
    private java.lang.String proMaterialNumber;
    
    private java.lang.String quaMaterialStatement;
    
    private java.lang.String proProcessStatus;
    
}

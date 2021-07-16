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
    private String proOrderDate;
    
    //확장
    //pro_order_detail 테이블
    private java.lang.String proOrderDetailCode;
    private java.lang.String proPlanDetailCode;
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private String erpProductDeadline;
    private java.lang.String erpCustomerCode;
    private java.math.BigDecimal proOrderExpectQty;
    private java.math.BigDecimal proOrderDayQty;
    private java.math.BigDecimal proOrderSeq;
    private java.math.BigDecimal proOrderOrderQty;
    
    //추가
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private String proWorkDate;
    private String erpProductCode;
    private String erpProductName;
    private String erpOrderCode;
    private String erpOrderQty;
    
    private String macHourQty;
    private String dayQty;
    private String dayCount;
    
    private String proMaterialLot;
    
    private String comProductCode;
    
    private String comMaterialCode;
    private String comMaterialName;
    private String comProcessCode;
    
    private String matLotNo;
    private String matInoutDate;
    private String matInoutQuantity;
    private String matInoutGubun;
    private String matInoutUnitPrice;
    private String matInoutPrice;
    
    private String proPlanQty;
    private String ProProcessLotNo;
    private String matInoutStatement;
    private String proMaterialNumber;
    
    private String quaMaterialStatement;
    
}

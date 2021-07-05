package mes.pro.plan.service;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import mes.main.service.SearchVO;

/**
 * @Class Name : ProPlanVO.java
 * @Description : ProPlan VO class
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
public class ProPlanVO extends SearchVO{
    private static final long serialVersionUID = 1L;
    
    //김한설
    private java.lang.String comProductCode;
    private java.lang.String comProductName;
    
    //생산관리M 테이블
    private java.lang.String proPlanCode;
    private java.lang.String proPlanName;
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private String proPlanDate;
    private java.lang.String erpCustomerCode;

    //생산관리D 테이블
    private java.lang.String proPlanDetailCode;
    private java.lang.String erpOrderCode;
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private String erpProductDeadline;
    private java.math.BigDecimal proPlanExpectQty;
    private java.math.BigDecimal proPlanDayQty;
    private java.math.BigDecimal proPlanSeq;
    private java.math.BigDecimal erpOrderQty;
    private java.math.BigDecimal proPlanQty;
    
    //erp_order 테이블
    private String erpProductCode;
    private String erpProductName;

}

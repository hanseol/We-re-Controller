package mes.pro.plan.service;

import lombok.Data;

/**
 * @Class Name : ProPlanDetailVO.java
 * @Description : ProPlanDetail VO class
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
public class ProPlanDetailVO extends ProPlanDetailDefaultVO{
    private static final long serialVersionUID = 1L;
    private java.lang.String proPlanDetailCode;
    private java.lang.String proPlanCode;
    private java.lang.String erpOrderCode;
    private java.sql.Date erpProductDeadline;
    private java.sql.Date proPlanDate;
    private java.lang.String erpCustomerCode;
    private java.math.BigDecimal proPlanExpectQty;
    private java.math.BigDecimal proPlanDayQty;
    private java.math.BigDecimal proPlanSeq;
    private java.math.BigDecimal erpOrderQty;
    private java.math.BigDecimal proPlanQty;
    
}

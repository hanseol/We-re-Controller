package mes.pro.order.service;

import lombok.Data;
import lombok.EqualsAndHashCode;
import mes.main.service.SearchVO;

/**
 * @Class Name : ProOrderDetailVO.java
 * @Description : ProOrderDetail VO class
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
public class ProOrderDetailVO extends SearchVO{
    private static final long serialVersionUID = 1L;
    private java.lang.String proOrderDetailCode;
    private java.lang.String proOrderCode;
    private java.lang.String proPlanDetailCode;
    private java.sql.Date erpProductDeadline;
    private java.sql.Date proOrderDate;
    private java.lang.String erpCustomerCode;
    private java.math.BigDecimal proOrderExpectQty;
    private java.math.BigDecimal proOrderDayQty;
    private java.math.BigDecimal proOrderSeq;
    private java.math.BigDecimal proOrderOrderQty;
    private java.math.BigDecimal proOrderQty;
}

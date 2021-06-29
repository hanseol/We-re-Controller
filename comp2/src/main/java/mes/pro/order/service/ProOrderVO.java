package mes.pro.order.service;

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
    private java.lang.String proOrderCode;
    private java.lang.String proOrderGubun;
    private java.math.BigDecimal proOrderQty;
    private java.math.BigDecimal proOrderRank;
    private java.sql.Date proOrderDate;
    //확장
    private java.lang.String proOrderDetailCode;
    private java.lang.String proPlanDetailCode;
    private java.sql.Date erpProductDeadline;
    private java.lang.String erpCustomerCode;
    private java.math.BigDecimal proOrderExpectQty;
    private java.math.BigDecimal proOrderDayQty;
    private java.math.BigDecimal proOrderSeq;
    private java.math.BigDecimal proOrderOrderQty;

}

package mes.pro.order.service;

import lombok.Data;

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
public class ProOrderVO extends ProOrderDefaultVO{
    private static final long serialVersionUID = 1L;
    private java.lang.String proOrderCode;
    private java.lang.String proOrderGubun;
    private java.math.BigDecimal proOrderQty;
    private java.math.BigDecimal proOrderRank;
    private java.sql.Date proOrderDate;
    
   
}

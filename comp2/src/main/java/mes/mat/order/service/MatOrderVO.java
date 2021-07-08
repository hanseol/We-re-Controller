package mes.mat.order.service;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;
import lombok.EqualsAndHashCode;
import mes.main.service.SearchVO;

/**
 * @Class Name : ErpMaterialOrderVO.java
 * @Description : ErpMaterialOrder VO class
 * @Modification Information
 *
 * @author sungwon
 * @since 20210628
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
@Data
@EqualsAndHashCode(callSuper=false)
public class MatOrderVO extends SearchVO{
    private static final long serialVersionUID = 1L;
    
    /** ERP_MATERIAL_ORDER_CODE */
    private java.lang.String erpMaterialOrderCode;
    
    /** COM_MATERIAL_CODE */
    private java.lang.String comMaterialCode;
    
    /** ERP_MATERIAL_ORDER_QTY */
    private java.math.BigDecimal erpMaterialOrderQty;
    
    /** ERP_VENDOR_CODE */
    private java.lang.String erpVendorCode;
    
    /** ERP_MATERIAL_UNIT_PRICE */
    private java.math.BigDecimal erpMaterialUnitPrice;
    
    /** ERP_MATERIAL_ORDER_DATE */
    @DateTimeFormat(pattern ="yyyy/MM/dd HH:MI:SS")
    private java.lang.String erpMaterialOrderDate;
    
    /** ERP_MATERIAL_REQUEST_DATE */
    @DateTimeFormat(pattern ="yyyy/MM/dd HH:MI:SS")
    private java.lang.String erpMaterialRequestDate;

    
}

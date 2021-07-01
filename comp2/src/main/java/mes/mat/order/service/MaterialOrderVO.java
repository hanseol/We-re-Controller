package mes.mat.order.service;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;
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
public class MaterialOrderVO extends SearchVO{
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
    
    public java.lang.String getErpMaterialOrderCode() {
        return this.erpMaterialOrderCode;
    }
    
    public void setErpMaterialOrderCode(java.lang.String erpMaterialOrderCode) {
        this.erpMaterialOrderCode = erpMaterialOrderCode;
    }
    
    public java.lang.String getComMaterialCode() {
        return this.comMaterialCode;
    }
    
    public void setComMaterialCode(java.lang.String comMaterialCode) {
        this.comMaterialCode = comMaterialCode;
    }
    
    public java.math.BigDecimal getErpMaterialOrderQty() {
        return this.erpMaterialOrderQty;
    }
    
    public void setErpMaterialOrderQty(java.math.BigDecimal erpMaterialOrderQty) {
        this.erpMaterialOrderQty = erpMaterialOrderQty;
    }
    
    public java.lang.String getErpVendorCode() {
        return this.erpVendorCode;
    }
    
    public void setErpVendorCode(java.lang.String erpVendorCode) {
        this.erpVendorCode = erpVendorCode;
    }
    
    public java.math.BigDecimal getErpMaterialUnitPrice() {
        return this.erpMaterialUnitPrice;
    }
    
    public void setErpMaterialUnitPrice(java.math.BigDecimal erpMaterialUnitPrice) {
        this.erpMaterialUnitPrice = erpMaterialUnitPrice;
    }
    
    public java.lang.String getErpMaterialOrderDate() {
        return this.erpMaterialOrderDate;
    }
    
    public void setErpMaterialOrderDate(java.lang.String erpMaterialOrderDate) {
        this.erpMaterialOrderDate = erpMaterialOrderDate;
    }
    
    public java.lang.String getErpMaterialRequestDate() {
        return this.erpMaterialRequestDate;
    }
    
    public void setErpMaterialRequestDate(java.lang.String erpMaterialRequestDate) {
        this.erpMaterialRequestDate = erpMaterialRequestDate;
    }
    
}

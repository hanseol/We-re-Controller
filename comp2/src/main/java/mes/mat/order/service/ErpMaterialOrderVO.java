package mes.mat.order.service;

import lombok.Data;

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
public class ErpMaterialOrderVO extends ErpMaterialOrderDefaultVO{
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
    private java.sql.Date erpMaterialOrderDate;
    
    /** ERP_MATERIAL_REQUEST_DATE */
    private java.sql.Date erpMaterialRequestDate;
    
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
    
    public java.sql.Date getErpMaterialOrderDate() {
        return this.erpMaterialOrderDate;
    }
    
    public void setErpMaterialOrderDate(java.sql.Date erpMaterialOrderDate) {
        this.erpMaterialOrderDate = erpMaterialOrderDate;
    }
    
    public java.sql.Date getErpMaterialRequestDate() {
        return this.erpMaterialRequestDate;
    }
    
    public void setErpMaterialRequestDate(java.sql.Date erpMaterialRequestDate) {
        this.erpMaterialRequestDate = erpMaterialRequestDate;
    }
    
}

package mes.mat.matr.service;

import lombok.Data;
import lombok.EqualsAndHashCode;
import mes.main.service.SearchVO;

/**
 * @Class Name : ComMaterialVO.java
 * @Description : ComMaterial VO class
 * @Modification Information
 *
 * @author sungwon
 * @since 20210629
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
@Data
@EqualsAndHashCode(callSuper=false)
public class MaterialVO extends SearchVO{
    private static final long serialVersionUID = 1L;
    
    /** COM_MATERIAL_CODE */
    private java.lang.String comMaterialCode;
    
    /** COM_MATERIAL_NAME */
    private java.lang.String comMaterialName;
    
    /** COM_MATERIAL_BARCODE */
    private java.lang.String comMaterialBarcode;
    
    /** COM_MATERIAL_SIZE */
    private java.lang.String comMaterialSize;
    
    /** COM_MATERIAL_UNIT */
    private java.lang.String comMaterialUnit;
    
    /** COM_MATERIAL_VENDOR_CODE */
    private java.lang.String comMaterialVendorCode;
    
    /** COM_MATERIAL_SAFETY_STOCK */
    private java.lang.String comMaterialSafetyStock;
    
    /** COM_MATERIAL_MIN */
    private java.lang.String comMaterialMin;
    
    /** COM_MATERIAL_MAX */
    private java.lang.String comMaterialMax;
    //업체코드
    private String erpVendorCode;
    

    
}

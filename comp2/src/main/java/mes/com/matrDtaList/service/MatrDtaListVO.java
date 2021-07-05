package mes.com.matrDtaList.service;

import lombok.Data;
import lombok.EqualsAndHashCode;
import mes.main.service.SearchVO;

/**
 * @Class Name : ComCodeVO.java
 * @Description : ComCode VO class
 * @Modification Information
 *
 * @author 경윤수
 * @since 2021-06-30
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
@Data
@EqualsAndHashCode(callSuper=false)
public class MatrDtaListVO extends SearchVO{
    private static final long serialVersionUID = 1L;

    private java.lang.String comCodeDetailId;
    
    private java.lang.String comCodeDetailName;
    
    private java.lang.String comCodeDetailDesc;
    
    private java.math.BigDecimal comCodeDetailSeq;
    
    private java.lang.String comCodeDetailUsedchk;
    
    private java.lang.String comMaterialCode;
    
    private java.lang.String comMaterialName;
    
    private java.lang.String comMaterialBarcode;
    
    private java.lang.String comMaterialSize;
    
    private java.lang.String comMaterialUnit;
    
    private java.lang.String comMaterialVendorCode;
    
    private java.lang.String comMaterialSafetyStock;
    
    private java.lang.String comMaterialMin;
    
    private java.lang.String comMaterialMax;
    
}

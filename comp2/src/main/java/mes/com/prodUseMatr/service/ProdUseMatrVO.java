package mes.com.prodUseMatr.service;

import org.springframework.format.annotation.DateTimeFormat;

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
public class ProdUseMatrVO extends SearchVO{
    private static final long serialVersionUID = 1L;

    //공통, bom
    private java.lang.String comBomNum;
    private java.lang.String comProductCode;
    private java.lang.String comMaterialCode;
    private java.lang.String comProcessCode;
    private java.lang.String comBomOrder;
    private java.lang.String comBomProduce;
    private java.math.BigDecimal comBomUnit;
    private java.lang.String comBomEtc;
    
    //제품정보
    private java.lang.String comProductName;
    private java.lang.String comProductSize;
    private java.lang.String comProductUnit;
    private java.lang.String comProductUse;
    private java.lang.String comProductImage;
    private java.lang.String comProductQtyImage;
    private java.lang.String comProductFloorImage;
    
    //공정
    private java.lang.String comProcessName;
    private java.lang.String comProcessDesc;
    private java.lang.String comProcessUnit;
    private java.lang.String comProcessBuha;
    private java.math.BigDecimal comProcessUnitPrice;
    @DateTimeFormat(pattern ="yyyy/MM/dd HH:MI:SS")
    private java.lang.String comProcessLeadtime;
    private java.math.BigDecimal comProcessProductDay;
    private java.lang.String comProcessGubun;
    private java.lang.String comProcessEtc;
    
    //자재
    private java.lang.String comMaterialName;
    private java.lang.String comMaterialSize;
    private java.lang.String comMaterialUnit;
    private java.lang.String comMaterialVendorCode;
    private java.lang.String comMaterialSafetyStock;
    private java.lang.String comMaterialMin;
    private java.lang.String comMaterialMax;
    
    //영업
    private java.lang.String salInoutCode;
    
    
}

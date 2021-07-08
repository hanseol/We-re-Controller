package mes.qua.chk.service;

import java.math.BigDecimal;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;
import lombok.EqualsAndHashCode;
import mes.main.service.SearchVO;

/**
 * @Class Name : QuaMaterialChkVO.java
 * @Description : QuaMaterialChk VO class
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
public class QuaChkVO extends SearchVO{
    private static final long serialVersionUID = 1L;
    
    /** QUA_MATERIAL_STATEMENT */
    private java.lang.String quaMaterialStatement;
    
    /** QUA_MATERIAL_DATE */
    @DateTimeFormat(pattern ="yyyy/MM/dd")
    private java.lang.String quaMaterialDate;
    
    /** ERP_VENDOR_CODE */
    private java.lang.String erpVendorCode;
    
    /** COM_MATERIAL_CODE */
    private java.lang.String comMaterialCode;
    
    /** QUA_MATERIAL_CHK */
    private java.lang.String quaMaterialChk;
    
    /** QUA_MATERIAL_P_QTY */
    private java.math.BigDecimal quaMaterialPQty;
    
    /** QUA_MATERIAL_F_QTY */
    private java.math.BigDecimal quaMaterialFQty;
    
    /** QUA_MATERIAL_CHK_DATE */
    @DateTimeFormat(pattern ="yyyy/MM/dd")
    private java.lang.String quaMaterialChkDate;
    
    /** ERP_MATERIAL_ORDER_CODE */
    private java.lang.String erpMaterialOrderCode;
    
    //개당단가 추가
    private BigDecimal erpMaterialUnitPrice;
    //자재명 추가
    private String comMaterialName;
    //규격 추가
    private String comMaterialSize;
    //관리단위 추가
    private String comMaterialUnit;
    //업체명(공통코드) 추가
    private String comCodeDetailName;
    //자재납품요청일(입고일)
    @DateTimeFormat(pattern ="yyyy/MM/dd")
    private String erpMaterialRequestDate;

    //입출고데이터--------------------------------------
    //입출고전표번호 추가
    private String matInoutStatement;
    //입출고일자 추가
    @DateTimeFormat(pattern ="yyyy/MM/dd")
    private String matInoutDate;
    //입출고구분 추가
    private String matInoutGubun;
    //입출고수량 추가
    private BigDecimal matInoutQuantity;
    //자재LOT_NO 추가
    private String matLotNo;
    //자재 개당 단가 추가
    private BigDecimal matInoutUnitPrice;
    //금액 추가
    private BigDecimal matInoutPrice;
    
    
}

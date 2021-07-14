package mes.qua.flty.service;

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
public class QuaFltyVO extends SearchVO{
    private static final long serialVersionUID = 1L;
    
    //자재불량테이블----------------------------------
    /** ERP_MATERIAL_ORDER_CODE */
    private String erpMaterialOrderCode;
    
    //자재불량코드
    private String comMaterialFCode;
    
    /** COM_MATERIAL_CODE */
    private String comMaterialCode;
    
    /** QUA_MATERIAL_F_QTY */
    private BigDecimal quaMaterialFQty;
    
    /** QUA_MATERIAL_STATEMENT */
    private String quaMaterialStatement;
    
    
    //입고검사테이블------------------------------------
    /** QUA_MATERIAL_DATE */
    @DateTimeFormat(pattern ="yyyy/MM/dd")
    private String quaMaterialDate;
    
    /** ERP_VENDOR_CODE */
    private String erpVendorCode;
    
    
    /** QUA_MATERIAL_CHK */
    private String quaMaterialChk;
    
    //검사완료일자
    @DateTimeFormat(pattern ="yyyy/MM/dd")
    private String quaMaterialChkDate;


    //자재발주테이블------------------------------
    //납품요청일
    @DateTimeFormat(pattern ="yyyy/MM/dd")
    private String erpMaterialRequestDate;
    
    //발주량
    private BigDecimal erpMaterialOrderQty;
    
    //단가
    private BigDecimal erpMaterialUnitPrice;
    

    
    
    
    //공통코드 디테일----------------------------------

    private String comCodeDetailName;
    
    //자재테이블---------------------------------------
    //자재명
    private String comMaterialName;
    
    //공통자재불량
    private String comMaterialFName;
    
    //날짜 범위 검색 End날짜 추가
    @DateTimeFormat(pattern ="yyyy/MM/dd")
    private String quaMaterialChkEndDate;
    
}

package mes.mat.inout.service;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;
import lombok.EqualsAndHashCode;
import mes.main.service.SearchVO;

/**
 * @Class Name : MatInoutVO.java
 * @Description : MatInout VO class
 * @Modification Information
 *
 * @author sungwon
 * @since 20210625
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
@Data
@EqualsAndHashCode(callSuper=false)
public class MatInoutVO extends SearchVO{
    private static final long serialVersionUID = 1L;
    
    /** MAT_INOUT_STATEMENT 전표번호 */
    private java.lang.String matInoutStatement;
    
    /** COM_MATERIAL_CODE */
    private String comMaterialCode;
    
    /** MAT_INOUT_DATE */
    @DateTimeFormat(pattern ="YYYY-MM-DD")
    private java.lang.String matInoutDate;
    
    /** MAT_INOUT_GUBUN 입출고 구분*/
    private java.lang.String matInoutGubun;
    
    /** MAT_INOUT_QUANTITY */
    private java.math.BigDecimal matInoutQuantity;
    
    /** MAT_LOT_NO */
    private java.lang.String matLotNo;
    
    /** COM_PROCESS_CODE */
    private java.lang.String comProcessCode;
    
    /** MAT_INOUT_UNIT_PRICE */
    private java.math.BigDecimal matInoutUnitPrice;
    
    /** MAT_INOUT_PRICE */
    private java.math.BigDecimal matInoutPrice;
    
    //업체코드 추가
    private String erpVendorCode;
    
    //자재명 추가
    private String comMaterialName;
    
    //공통 업체코드(VENDOR---) 추가
    private String comCodeDetailId;
    
    //입고업체명 추가
    private String comCodeDetailName;
    
    //날짜 범위검색 End 날짜 추가
    @DateTimeFormat(pattern ="YYYY-MM-DD")
    private String matInoutEndDate;

}

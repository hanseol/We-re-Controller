package mes.mat.lot.service;

import java.math.BigDecimal;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;
import lombok.EqualsAndHashCode;
import mes.main.service.SearchVO;

/**
 * @Class Name : MatMatchVO.java
 * @Description : MatMatch VO class
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
@EqualsAndHashCode(callSuper = false)
public class MatLotVO extends SearchVO{
    private static final long serialVersionUID = 1L;
    
    /** MAT_MATCH_STATEMENT */
    private String matMatchStatement;
    
    /** COM_MATERIAL_CODE */
    private String comMaterialCode;
    
    /** MAT_LOT_NO */
    private String matLotNo;
    
    /** MAT_MATCH_INOUT */
    private String matMatchInout;
    
    /** MAT_MATCH_QTY */
    private BigDecimal matMatchQty;
    
    /** MAT_MATCH_DATE */
    @DateTimeFormat(pattern ="YYYY-MM-DD")
    private String matMatchDate;
    
    //자재명
    private String comMaterialName;
    //자재관리단위
    private String comMaterialUnit;
    //단가
    private BigDecimal matInoutUnitPrice;
    //금액
    private BigDecimal matInoutPrice;
    //최종수량
    private BigDecimal finalQty;
    //입출고 수량
    private BigDecimal matInoutQuantity;
    //입출고 구분
    private BigDecimal matInoutGubun;
}

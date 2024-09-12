package mes.pro.proc.service;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import mes.main.service.SearchVO;

/**
 * @Class Name : ProProcessVO.java
 * @Description : ProProcess VO class
 * @Modification Information
 *
 * @author dahee
 * @since 20210707
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Data
@EqualsAndHashCode(callSuper=false)
@NoArgsConstructor
public class ProProcessVO extends SearchVO{
    private static final long serialVersionUID = 1L;
    
    private java.lang.String comProcessCode;
    private java.lang.String proOrderDetailCode;
    private java.lang.String comProductFCode;
    private java.math.BigDecimal proProcessFQty;
    private java.lang.String macLineNo;
    private java.lang.String proProcessStartTime;
    private java.lang.String proProcessEndTime;
    private java.lang.String erpEmployeeId;
    private java.lang.String macCode;
    private java.lang.String proProcessLotNo;
    private java.math.BigDecimal proProcessQuantity;
    
    //확장
    //pro_material_lot 테이블의 자재로트번호
    private java.lang.String matLotNo;
    //자재코드
    private java.lang.String comMaterialCode;
    //자재명
    private java.lang.String comMaterialName;
    //공정명
    private java.lang.String comProcessName;
    //제품명
    private java.lang.String erpProductName;
    
    private java.lang.String comProductName;
    
    private java.lang.String proWorkDate;
    
    private java.lang.String proOrderQty;
    
    private java.lang.String totalProOrderDetailCode;
    
    /**
     * 고객사명 : 공정이동표 발행 시 필요한 정보.
     */
    private java.lang.String erpCustomerName;
    
    /**
     * 주문코드 : 공정이동표 발행 시 필요한 정보.
     */
    private java.lang.String erpOrderCode;
    
    
}

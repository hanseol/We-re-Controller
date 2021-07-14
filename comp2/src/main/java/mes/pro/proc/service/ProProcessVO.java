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
    
    /** COM_PROCESS_CODE */
    private java.lang.String comProcessCode;
    
    /** PRO_ORDER_DETAIL_CODE */
    private java.lang.String proOrderDetailCode;
    
    /** COM_PRODUCT_F_CODE */
    private java.lang.String comProductFCode;
    
    /** PRO_PROCESS_F_QTY */
    private java.math.BigDecimal proProcessFQty;
    
    /** MAC_LINE_NO */
    private String macLineNo;
    
    /** PRO_PROCESS_START_TIME */
    private java.lang.String proProcessStartTime;
    
    /** PRO_PROCESS_END_TIME */
    private java.lang.String proProcessEndTime;
    
    /** ERP_EMPLOYEE_ID */
    private String erpEmployeeId;
    
    /** MAC_CODE */
    private java.lang.String macCode;
    
    /** PRO_PROCESS_LOT_NO */
    private java.lang.String proProcessLotNo;
    
    /** PRO_PROCESS_QUANTITY */
    private java.math.BigDecimal proProcessQuantity;
    
    //확장
    //pro_material_lot 테이블의 자재로트번호
    private String matLotNo;
    //자재코드
    private String comMaterialCode;
    //자재명
    private String comMaterialName;
    //공정명
    private String comProcessName;
    //제품명
    private String erpProductName;
    
    
}

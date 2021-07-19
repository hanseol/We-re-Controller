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
    
    private String comProcessCode;
    private java.lang.String proOrderDetailCode;
    private String comProductFCode;
    private java.math.BigDecimal proProcessFQty;
    private String macLineNo;
    private String proProcessStartTime;
    private String proProcessEndTime;
    private String erpEmployeeId;
    private String macCode;
    private String proProcessLotNo;
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
    
    private String comProductName;
    private String proWorkDate;

    
    
}

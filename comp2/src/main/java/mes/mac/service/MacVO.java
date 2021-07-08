package mes.mac.service;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import mes.main.service.SearchVO;

/**
 * @Class Name : MacVO.java
 * @Description : Mac VO class
 * @Modification Information
 *
 * @author hanseol
 * @since 20210708
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
@Data
@EqualsAndHashCode(callSuper=false)
@NoArgsConstructor
public class MacVO extends SearchVO{
    private static final long serialVersionUID = 1L;
    
    /** MAC_CODE */
    private java.lang.String macCode="";
    
    /** MAC_LINE_NO */
    private java.lang.String macLineNo="";
    
    /** MAC_HOUR_QTY */
    private java.lang.String macHourQty="";
    
    /** COM_PRODUCT_CODE */
    private java.lang.String comProductCode="";
    
    /** COM_PROCESS_CODE */
    private java.lang.String comProcessCode="";
    
    /** MAC_UNUSED */
    private java.lang.String macUnused="";
    
    /** ERP_EMPLOYEE_ID */
    private java.lang.String erpEmployeeId="";
    
    /** MAC_USE_PURPOSE */
    private java.lang.String macUsePurpose="";
    
    /** MAC_GUBUN */
    private java.lang.String macGubun="";
    
    /** MAC_NAME */
    private java.lang.String macName="";
    
    /** MAC_SIZE */
    private java.lang.String macSize="";
    
    /** MAC_MODEL */
    private java.lang.String macModel="";
    
    /** MAC_MACHINE_CONSTRUCTOR */
    private java.lang.String macMachineConstructor="";
    
    /** MAC_POSSIBLE_SIZE */
    private java.lang.String macPossibleSize="";
    
    /** MAC_MACHINE_DATE */
    @DateTimeFormat(pattern ="yyyy/MM/dd")
    private java.lang.String macMachineDate;
    
    /** MAC_MACHINE_COST */
    private java.lang.String macMachineCost;
    
    /** MAC_BUHA */
    private java.lang.String macBuha="";
    
    /** MAC_TEMP */
    private java.lang.String macTemp="";
    
    /** MAC_CHK_DATE */
    @DateTimeFormat(pattern ="yyyy/MM/dd")
    private java.lang.String macChkDate;
    
    /** MAC_NEXT_CHK_DATE */
    @DateTimeFormat(pattern ="yyyy/MM/dd")
    private java.lang.String macNextChkDate;
    
    /** MAC_CHK_CYCLE */
    private java.math.BigDecimal macChkCycle;
    
    
}

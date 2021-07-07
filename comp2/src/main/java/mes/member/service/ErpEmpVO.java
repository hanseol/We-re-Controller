package mes.member.service;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import mes.main.service.SearchVO;

/**
 * @Class Name : ErpEmpVO.java
 * @Description : ErpEmp VO class
 * @Modification Information
 *
 * @author hanseol
 * @since 20210706
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
@Data
@EqualsAndHashCode(callSuper=false)
@NoArgsConstructor
public class ErpEmpVO extends SearchVO{
    private static final long serialVersionUID = 1L;
    
    /** ERP_EMPLOYEE_ID */
    private java.lang.String erpEmployeeId;
    
    /** ERP_EMPLOYEE_NAME */
    private java.lang.String erpEmployeeName="";
    
    /** ERP_EMPLOYEE_POSITION */
    private java.lang.String erpEmployeePosition="";
    
    /** ERP_EMPLOYEE_EMAIL */
    private java.lang.String erpEmployeeEmail="";
    
    /** ERP_EMPLOYEE_PHONE */
    private java.lang.String erpEmployeePhone="";
    
    /** ERP_EMPLOYEE_HIREDATE */
    private java.sql.Date erpEmployeeHiredate;
    
    /** ERP_JOB_NAME */
    private java.lang.String erpJobName="";
    
    /** ERP_DEPARTMENT_NAME */
    private java.lang.String erpDepartmentName="";
    
    /** ERP_EMPLOYEE_PASSWORD */
    private java.lang.String erpEmployeePassword="";
   
    
}

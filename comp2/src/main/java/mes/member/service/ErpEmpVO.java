package mes.member.service;

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
public class ErpEmpVO extends SearchVO{
    private static final long serialVersionUID = 1L;
    
    /** ERP_EMPLOYEE_ID */
    private java.math.BigDecimal erpEmployeeId;
    
    /** ERP_EMPLOYEE_NAME */
    private java.lang.String erpEmployeeName;
    
    /** ERP_EMPLOYEE_POSITION */
    private java.lang.String erpEmployeePosition;
    
    /** ERP_EMPLOYEE_EMAIL */
    private java.lang.String erpEmployeeEmail;
    
    /** ERP_EMPLOYEE_PHONE */
    private java.lang.String erpEmployeePhone;
    
    /** ERP_EMPLOYEE_HIREDATE */
    private java.sql.Date erpEmployeeHiredate;
    
    /** ERP_JOB_NAME */
    private java.lang.String erpJobName;
    
    /** ERP_DEPARTMENT_NAME */
    private java.lang.String erpDepartmentName;
    
    /** ERP_EMPLOYEE_PASSWORD */
    private java.lang.String erpEmployeePassword;
    
    public java.math.BigDecimal getErpEmployeeId() {
        return this.erpEmployeeId;
    }
    
    public void setErpEmployeeId(java.math.BigDecimal erpEmployeeId) {
        this.erpEmployeeId = erpEmployeeId;
    }
    
    public java.lang.String getErpEmployeeName() {
        return this.erpEmployeeName;
    }
    
    public void setErpEmployeeName(java.lang.String erpEmployeeName) {
        this.erpEmployeeName = erpEmployeeName;
    }
    
    public java.lang.String getErpEmployeePosition() {
        return this.erpEmployeePosition;
    }
    
    public void setErpEmployeePosition(java.lang.String erpEmployeePosition) {
        this.erpEmployeePosition = erpEmployeePosition;
    }
    
    public java.lang.String getErpEmployeeEmail() {
        return this.erpEmployeeEmail;
    }
    
    public void setErpEmployeeEmail(java.lang.String erpEmployeeEmail) {
        this.erpEmployeeEmail = erpEmployeeEmail;
    }
    
    public java.lang.String getErpEmployeePhone() {
        return this.erpEmployeePhone;
    }
    
    public void setErpEmployeePhone(java.lang.String erpEmployeePhone) {
        this.erpEmployeePhone = erpEmployeePhone;
    }
    
    public java.sql.Date getErpEmployeeHiredate() {
        return this.erpEmployeeHiredate;
    }
    
    public void setErpEmployeeHiredate(java.sql.Date erpEmployeeHiredate) {
        this.erpEmployeeHiredate = erpEmployeeHiredate;
    }
    
    public java.lang.String getErpJobName() {
        return this.erpJobName;
    }
    
    public void setErpJobName(java.lang.String erpJobName) {
        this.erpJobName = erpJobName;
    }
    
    public java.lang.String getErpDepartmentName() {
        return this.erpDepartmentName;
    }
    
    public void setErpDepartmentName(java.lang.String erpDepartmentName) {
        this.erpDepartmentName = erpDepartmentName;
    }
    
    public java.lang.String getErpEmployeePassword() {
        return this.erpEmployeePassword;
    }
    
    public void setErpEmployeePassword(java.lang.String erpEmployeePassword) {
        this.erpEmployeePassword = erpEmployeePassword;
    }
    
}

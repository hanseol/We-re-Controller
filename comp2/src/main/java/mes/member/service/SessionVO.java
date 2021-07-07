package mes.member.service;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Data
@EqualsAndHashCode(callSuper=false)
@NoArgsConstructor
public class SessionVO {
	
	//접속한 사원의 부서와 직책에 따라 뷰 페이지를 다르게 보여줘야 함.
	//ErpEmpVO 객체를 그대로 사용하는 것보다 SessionVO 객체를 이용하면 보안유지에 좋을 것 같음.
	
    /** ERP_EMPLOYEE_ID */
    private java.lang.String erpEmployeeId;
    
    /** ERP_EMPLOYEE_NAME */
    private java.lang.String erpEmployeeName;
    
    /** ERP_EMPLOYEE_POSITION */
    private java.lang.String erpEmployeePosition;
    
    /** ERP_DEPARTMENT_NAME */
    private java.lang.String erpDepartmentName;
    
    
}

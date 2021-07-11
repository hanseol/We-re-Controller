package mes.member.service;

import java.util.List;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class SessionVO {
	
	//접속한 사원의 부서와 직책에 따라 뷰 페이지를 다르게 보여줘야 함.
	
    /** ERP_EMPLOYEE_ID */
    private java.lang.String erpEmployeeId;
    
    /** ERP_EMPLOYEE_NAME */
    private java.lang.String erpEmployeeName;
    
    /** ERP_EMPLOYEE_POSITION */
    private java.lang.String erpEmployeePosition;
    
    /** ERP_DEPARTMENT_NAME */
    private java.lang.String erpDepartmentName;
    
    private List<MacDateResultVO> macDateResultList;
}

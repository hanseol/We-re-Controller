package mes.member.service;

import java.util.List;
import mes.member.service.ErpEmpVO;

/**
 * @Class Name : ErpEmpService.java
 * @Description : ErpEmp Business class
 * @Modification Information
 *
 * @author hanseol
 * @since 20210706
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface ErpEmpService {
	
	/*
	 * MES_LOGIN ACTION
	 * 2021-07-07
	 * */
	ErpEmpVO login(ErpEmpVO vo) throws Exception;
	
	/**
	 * ERP_EMP을 등록한다.
	 * @param vo - 등록할 정보가 담긴 ErpEmpVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertErpEmp(ErpEmpVO vo) throws Exception;
    
    /**
	 * ERP_EMP을 수정한다.
	 * @param vo - 수정할 정보가 담긴 ErpEmpVO
	 * @return void형
	 * @exception Exception
	 */
    void updateErpEmp(ErpEmpVO vo) throws Exception;
    
    /**
	 * ERP_EMP을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ErpEmpVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteErpEmp(ErpEmpVO vo) throws Exception;
    
    /**
	 * ERP_EMP을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ErpEmpVO
	 * @return 조회한 ERP_EMP
	 * @exception Exception
	 */
    ErpEmpVO selectErpEmp(ErpEmpVO vo) throws Exception;
    
    /**
	 * ERP_EMP 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return ERP_EMP 목록
	 * @exception Exception
	 */
    List selectErpEmpList(ErpEmpVO searchVO) throws Exception;
    
    /**
	 * ERP_EMP 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return ERP_EMP 총 갯수
	 * @exception
	 */
    int selectErpEmpListTotCnt(ErpEmpVO searchVO);
    
}

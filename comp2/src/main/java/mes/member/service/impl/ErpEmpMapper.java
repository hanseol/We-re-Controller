package mes.member.service.impl;

import java.util.List;

import mes.member.service.ErpEmpVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

/**
 * @Class Name : ErpEmpMapper.java
 * @Description : ErpEmp Mapper Class
 * @Modification Information
 *
 * @author hanseol
 * @since 20210706
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Mapper("erpEmpMapper")
public interface ErpEmpMapper {

	/*
	 * MES_LOGIN ACTION
	 * 2021-07-07
	 * */
	public ErpEmpVO login(ErpEmpVO vo) throws Exception;
	
	/**
	 * ERP_EMP을 등록한다.
	 * @param vo - 등록할 정보가 담긴 ErpEmpVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public void insertErpEmp(ErpEmpVO vo) throws Exception;

    /**
	 * ERP_EMP을 수정한다.
	 * @param vo - 수정할 정보가 담긴 ErpEmpVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateErpEmp(ErpEmpVO vo) throws Exception;

    /**
	 * ERP_EMP을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ErpEmpVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteErpEmp(ErpEmpVO vo) throws Exception;

    /**
	 * ERP_EMP을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ErpEmpVO
	 * @return 조회한 ERP_EMP
	 * @exception Exception
	 */
    public ErpEmpVO selectErpEmp(ErpEmpVO vo) throws Exception;

    /**
	 * ERP_EMP 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return ERP_EMP 목록
	 * @exception Exception
	 */
    public List<?> selectErpEmpList(ErpEmpVO searchVO) throws Exception;

    /**
	 * ERP_EMP 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return ERP_EMP 총 갯수
	 * @exception
	 */
    public int selectErpEmpListTotCnt(ErpEmpVO searchVO);

}

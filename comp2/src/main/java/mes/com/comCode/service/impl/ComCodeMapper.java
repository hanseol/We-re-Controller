package mes.com.comCode.service.impl;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import mes.com.comCode.service.ComCodeVO;

/**
 * @Class Name : ComCodeMapper.java
 * @Description : ComCode Mapper Class
 * @Modification Information
 *
 * @author 경윤수
 * @since 2021-06-30
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Mapper("comCodeMapper")
public interface ComCodeMapper {

	/**
	 * COM_CODE을 등록한다.
	 * @param vo - 등록할 정보가 담긴 ComCodeVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public void insertComCode(ComCodeVO vo) throws Exception;

    /**
	 * COM_CODE을 수정한다.
	 * @param vo - 수정할 정보가 담긴 ComCodeVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateComCode(ComCodeVO vo) throws Exception;

    /**
	 * COM_CODE을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ComCodeVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteComCode(ComCodeVO vo) throws Exception;

    /**
	 * COM_CODE을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ComCodeVO
	 * @return 조회한 COM_CODE
	 * @exception Exception
	 */
    public ComCodeVO selectComCode(ComCodeVO vo) throws Exception;

    /**
	 * COM_CODE 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return COM_CODE 목록
	 * @exception Exception
	 */
    public List<?> selectComCodeList(ComCodeVO searchVO) throws Exception;

    /**
	 * COM_CODE 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return COM_CODE 총 갯수
	 * @exception
	 */
    public int selectComCodeListTotCnt(ComCodeVO searchVO);

}

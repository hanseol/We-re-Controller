package mes.sal.match.service.impl;

import java.util.LinkedHashMap;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import mes.sal.match.service.SalMatchVO;

/**
 * @Class Name : SalMatchMapper.java
 * @Description : SalMatch Mapper Class
 * @Modification Information
 *
 * @author hk
 * @since 2021-06-29
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Mapper("salMatchMapper")
public interface SalMatchMapper {

	/**
	 * SAL_MATCH을 등록한다.
	 * @param vo - 등록할 정보가 담긴 SalMatchVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public void insertSalMatch(LinkedHashMap vo) throws Exception;

    /**
	 * SAL_MATCH을 수정한다.
	 * @param vo - 수정할 정보가 담긴 SalMatchVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateSalMatch(LinkedHashMap vo) throws Exception;

    /**
	 * SAL_MATCH을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 SalMatchVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteSalMatch(LinkedHashMap vo) throws Exception;

    /**
	 * SAL_MATCH을 조회한다.
	 * @param vo - 조회할 정보가 담긴 SalMatchVO
	 * @return 조회한 SAL_MATCH
	 * @exception Exception
	 */
    public SalMatchVO selectSalMatch(SalMatchVO vo) throws Exception;

    /**
	 * SAL_MATCH 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return SAL_MATCH 목록
	 * @exception Exception
	 */
    public List<?> selectSalMatchList(SalMatchVO searchVO) throws Exception;

    /**
	 * SAL_MATCH 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return SAL_MATCH 총 갯수
	 * @exception
	 */
    public int selectSalMatchListTotCnt(SalMatchVO searchVO);

}

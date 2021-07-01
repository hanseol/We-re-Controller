package mes.sal.match.service;

import java.util.LinkedHashMap;
import java.util.List;
import mes.sal.match.service.SalMatchVO;

/**
 * @Class Name : SalMatchService.java
 * @Description : SalMatch Business class
 * @Modification Information
 *
 * @author hk
 * @since 2021-06-29
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface SalMatchService {
	
	/**
	 * SAL_MATCH을 등록한다.
	 * @param vo - 등록할 정보가 담긴 SalMatchVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertSalMatch(LinkedHashMap vo) throws Exception;
    
    /**
	 * SAL_MATCH을 수정한다.
	 * @param vo - 수정할 정보가 담긴 SalMatchVO
	 * @return void형
	 * @exception Exception
	 */
    void updateSalMatch(LinkedHashMap vo) throws Exception;
    
    /**
	 * SAL_MATCH을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 SalMatchVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteSalMatch(LinkedHashMap vo) throws Exception;
    
    /**
	 * SAL_MATCH을 조회한다.
	 * @param vo - 조회할 정보가 담긴 SalMatchVO
	 * @return 조회한 SAL_MATCH
	 * @exception Exception
	 */
    SalMatchVO selectSalMatch(SalMatchVO vo) throws Exception;
    
    /**
	 * SAL_MATCH 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return SAL_MATCH 목록
	 * @exception Exception
	 */
    List selectSalMatchList(SalMatchVO searchVO) throws Exception;
    
    /**
	 * SAL_MATCH 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return SAL_MATCH 총 갯수
	 * @exception
	 */
    int selectSalMatchListTotCnt(SalMatchVO searchVO);
    
}

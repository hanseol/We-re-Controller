package mes.com.comCode.service;

import java.util.LinkedHashMap;
import java.util.List;

/**
 * @Class Name : ComCodeService.java
 * @Description : ComCode Business class
 * @Modification Information
 *
 * @author 경윤수
 * @since 2021-06-30
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface ComCodeService {
	
	/**
	 * COM_CODE을 등록한다.
	 * @param vo - 등록할 정보가 담긴 ComCodeVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertComCode(LinkedHashMap vo) throws Exception;
    
    /**
	 * COM_CODE을 수정한다.
	 * @param vo - 수정할 정보가 담긴 ComCodeVO
	 * @return void형
	 * @exception Exception
	 */
    void updateComCode(LinkedHashMap vo) throws Exception;
    
    /**
	 * COM_CODE을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ComCodeVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteComCode(LinkedHashMap vo) throws Exception;
    
    /**
	 * COM_CODE을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ComCodeVO
	 * @return 조회한 COM_CODE
	 * @exception Exception
	 */
    ComCodeVO selectComCode(ComCodeVO vo) throws Exception;
    
    /**
	 * COM_CODE 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COM_CODE 목록
	 * @exception Exception
	 */
    List selectComCodeList(ComCodeVO searchVO) throws Exception;
    
    /**
	 * COM_CODE 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COM_CODE 총 갯수
	 * @exception
	 */
    int selectComCodeListTotCnt(ComCodeVO searchVO);
    
}

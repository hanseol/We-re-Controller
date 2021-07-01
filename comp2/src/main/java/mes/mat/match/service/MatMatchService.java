package mes.mat.match.service;

import java.util.List;

/**
 * @Class Name : MatMatchService.java
 * @Description : MatMatch Business class
 * @Modification Information
 *
 * @author sungwon
 * @since 20210625
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface MatMatchService {
	
	/**
	 * MAT_MATCH을 등록한다.
	 * @param vo - 등록할 정보가 담긴 MatMatchVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertMatMatch(MatMatchVO vo) throws Exception;
    
    /**
	 * MAT_MATCH을 수정한다.
	 * @param vo - 수정할 정보가 담긴 MatMatchVO
	 * @return void형
	 * @exception Exception
	 */
    void updateMatMatch(MatMatchVO vo) throws Exception;
    
    /**
	 * MAT_MATCH을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 MatMatchVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteMatMatch(MatMatchVO vo) throws Exception;
    
    /**
	 * MAT_MATCH을 조회한다.
	 * @param vo - 조회할 정보가 담긴 MatMatchVO
	 * @return 조회한 MAT_MATCH
	 * @exception Exception
	 */
    MatMatchVO selectMatMatch(MatMatchVO vo) throws Exception;
    
    /**
	 * MAT_MATCH 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return MAT_MATCH 목록
	 * @exception Exception
	 */
    List selectMatMatchList(MatMatchVO searchVO) throws Exception;
    
    /**
	 * MAT_MATCH 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return MAT_MATCH 총 갯수
	 * @exception
	 */
    int selectMatMatchListTotCnt(MatMatchVO searchVO);
    
}

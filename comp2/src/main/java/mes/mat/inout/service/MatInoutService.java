package mes.mat.inout.service;

import java.util.List;

/**
 * @Class Name : MatInoutService.java
 * @Description : MatInout Business class
 * @Modification Information
 *
 * @author sungwon
 * @since 20210625
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface MatInoutService {
	
	/**
	 * MAT_INOUT을 등록한다.
	 * @param vo - 등록할 정보가 담긴 MatInoutVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertMatInout(MatInoutVO vo) throws Exception;
    
    /**
	 * MAT_INOUT을 수정한다.
	 * @param vo - 수정할 정보가 담긴 MatInoutVO
	 * @return void형
	 * @exception Exception
	 */
    void updateMatInout(MatInoutVO vo) throws Exception;
    
    /**
	 * MAT_INOUT을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 MatInoutVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteMatInout(MatInoutVO vo) throws Exception;
    
    /**
	 * MAT_INOUT을 조회한다.
	 * @param vo - 조회할 정보가 담긴 MatInoutVO
	 * @return 조회한 MAT_INOUT
	 * @exception Exception
	 */
    MatInoutVO selectMatInout(MatInoutVO vo) throws Exception;
    
    /**
	 * MAT_INOUT 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return MAT_INOUT 목록
	 * @exception Exception
	 */
    List selectMatInoutList(MatInoutDefaultVO searchVO) throws Exception;
    
    /**
	 * MAT_INOUT 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return MAT_INOUT 총 갯수
	 * @exception
	 */
    int selectMatInoutListTotCnt(MatInoutDefaultVO searchVO);
    
    List<?> selectInoutList(MatInoutDefaultVO searchVO) throws Exception;
    
}

package mes.mat.inout.service.impl;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import mes.mat.inout.service.MatInoutVO;

/**
 * @Class Name : MatInoutMapper.java
 * @Description : MatInout Mapper Class
 * @Modification Information
 *
 * @author sungwon
 * @since 20210625
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Mapper("matInoutMapper")
public interface MatInoutMapper {

	/**
	 * MAT_INOUT을 등록한다.
	 * @param vo - 등록할 정보가 담긴 MatInoutVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public void insertMatInout(MatInoutVO vo) throws Exception;

    /**
	 * MAT_INOUT을 수정한다.
	 * @param vo - 수정할 정보가 담긴 MatInoutVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateMatInout(MatInoutVO vo) throws Exception;

    /**
	 * MAT_INOUT을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 MatInoutVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteMatInout(MatInoutVO vo) throws Exception;

    /**
	 * MAT_INOUT을 조회한다.
	 * @param vo - 조회할 정보가 담긴 MatInoutVO
	 * @return 조회한 MAT_INOUT
	 * @exception Exception
	 */
    public MatInoutVO selectMatInout(MatInoutVO vo) throws Exception;

    /**
	 * MAT_INOUT 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return MAT_INOUT 목록
	 * @exception Exception
	 */
    /**
	 * MAT_INOUT 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return MAT_INOUT 총 갯수
	 * @exception
	 */
    
    public int selectMatInoutListTotCnt(MatInoutVO searchVO);
    
    //입출고조회페이지 리스트 조회
    public List<?> selectMatInoutList(MatInoutVO searchVO) throws Exception;

}

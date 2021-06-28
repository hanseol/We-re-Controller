package mes.mat.match.service.impl;

import java.util.List;

import mes.mat.match.service.MatMatchVO;
import mes.mat.match.service.MatMatchDefaultVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

/**
 * @Class Name : MatMatchMapper.java
 * @Description : MatMatch Mapper Class
 * @Modification Information
 *
 * @author sungwon
 * @since 20210625
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Mapper("matMatchMapper")
public interface MatMatchMapper {

	/**
	 * MAT_MATCH을 등록한다.
	 * @param vo - 등록할 정보가 담긴 MatMatchVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public void insertMatMatch(MatMatchVO vo) throws Exception;

    /**
	 * MAT_MATCH을 수정한다.
	 * @param vo - 수정할 정보가 담긴 MatMatchVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateMatMatch(MatMatchVO vo) throws Exception;

    /**
	 * MAT_MATCH을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 MatMatchVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteMatMatch(MatMatchVO vo) throws Exception;

    /**
	 * MAT_MATCH을 조회한다.
	 * @param vo - 조회할 정보가 담긴 MatMatchVO
	 * @return 조회한 MAT_MATCH
	 * @exception Exception
	 */
    public MatMatchVO selectMatMatch(MatMatchVO vo) throws Exception;

    /**
	 * MAT_MATCH 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return MAT_MATCH 목록
	 * @exception Exception
	 */
    public List<?> selectMatMatchList(MatMatchDefaultVO searchVO) throws Exception;

    /**
	 * MAT_MATCH 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return MAT_MATCH 총 갯수
	 * @exception
	 */
    public int selectMatMatchListTotCnt(MatMatchDefaultVO searchVO);

}

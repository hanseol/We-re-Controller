package mes.mat.inout.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import mes.mat.inout.service.MatInoutService;
import mes.mat.inout.service.MatInoutVO;
/**
 * @Class Name : MatInoutServiceImpl.java
 * @Description : MatInout Business Implement class
 * @Modification Information
 *
 * @author sungwon
 * @since 20210625
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("matInoutService")
public class MatInoutServiceImpl extends EgovAbstractServiceImpl implements
        MatInoutService {
        
    private static final Logger LOGGER = LoggerFactory.getLogger(MatInoutServiceImpl.class);

    @Resource(name="matInoutMapper")
    private MatInoutMapper matInoutDAO;
    
    //@Resource(name="matInoutDAO")
    //private MatInoutDAO matInoutDAO;
    
    /** ID Generation */
    //@Resource(name="{egovMatInoutIdGnrService}")    
    //private EgovIdGnrService egovIdGnrService;

	/**
	 * MAT_INOUT을 등록한다.
	 * @param vo - 등록할 정보가 담긴 MatInoutVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertMatInout(MatInoutVO vo) throws Exception {
    	LOGGER.debug(vo.toString());
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	//String id = egovIdGnrService.getNextStringId();
    	//vo.setId(id);
    	LOGGER.debug(vo.toString());
    	
    	matInoutDAO.insertMatInout(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return null;
    }

    /**
	 * MAT_INOUT을 수정한다.
	 * @param vo - 수정할 정보가 담긴 MatInoutVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateMatInout(MatInoutVO vo) throws Exception {
        matInoutDAO.updateMatInout(vo);
    }

    /**
	 * MAT_INOUT을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 MatInoutVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteMatInout(MatInoutVO vo) throws Exception {
        matInoutDAO.deleteMatInout(vo);
    }

    /**
	 * MAT_INOUT을 조회한다.
	 * @param vo - 조회할 정보가 담긴 MatInoutVO
	 * @return 조회한 MAT_INOUT
	 * @exception Exception
	 */
    public MatInoutVO selectMatInout(MatInoutVO vo) throws Exception {
        MatInoutVO resultVO = matInoutDAO.selectMatInout(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * MAT_INOUT 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return MAT_INOUT 목록
	 * @exception Exception
	 */
    public List<?> selectMatInoutList(MatInoutVO searchVO) throws Exception {
        return matInoutDAO.selectMatInoutList(searchVO);
    }

    /**
	 * MAT_INOUT 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return MAT_INOUT 총 갯수
	 * @exception
	 */
    public int selectMatInoutListTotCnt(MatInoutVO searchVO) {
		return matInoutDAO.selectMatInoutListTotCnt(searchVO);
	}
    
    //리스트 전체조회 맵퍼로 돌리기
    public List<?> selectInoutList(MatInoutVO searchVO) throws Exception {
    	return matInoutDAO.selectMatInoutList(searchVO);
    }

}

package mes.mat.match.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import mes.mat.match.service.MatMatchService;
import mes.mat.match.service.MatMatchDefaultVO;
import mes.mat.match.service.MatMatchVO;
import mes.mat.match.service.impl.MatMatchMapper;
/**
 * @Class Name : MatMatchServiceImpl.java
 * @Description : MatMatch Business Implement class
 * @Modification Information
 *
 * @author sungwon
 * @since 20210625
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("matMatchService")
public class MatMatchServiceImpl extends EgovAbstractServiceImpl implements
        MatMatchService {
        
    private static final Logger LOGGER = LoggerFactory.getLogger(MatMatchServiceImpl.class);

    @Resource(name="matMatchMapper")
    private MatMatchMapper matMatchDAO;
    
    //@Resource(name="matMatchDAO")
    //private MatMatchDAO matMatchDAO;
    
    /** ID Generation */
    //@Resource(name="{egovMatMatchIdGnrService}")    
    //private EgovIdGnrService egovIdGnrService;

	/**
	 * MAT_MATCH을 등록한다.
	 * @param vo - 등록할 정보가 담긴 MatMatchVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertMatMatch(MatMatchVO vo) throws Exception {
    	LOGGER.debug(vo.toString());
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	//String id = egovIdGnrService.getNextStringId();
    	//vo.setId(id);
    	LOGGER.debug(vo.toString());
    	
    	matMatchDAO.insertMatMatch(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return null;
    }

    /**
	 * MAT_MATCH을 수정한다.
	 * @param vo - 수정할 정보가 담긴 MatMatchVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateMatMatch(MatMatchVO vo) throws Exception {
        matMatchDAO.updateMatMatch(vo);
    }

    /**
	 * MAT_MATCH을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 MatMatchVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteMatMatch(MatMatchVO vo) throws Exception {
        matMatchDAO.deleteMatMatch(vo);
    }

    /**
	 * MAT_MATCH을 조회한다.
	 * @param vo - 조회할 정보가 담긴 MatMatchVO
	 * @return 조회한 MAT_MATCH
	 * @exception Exception
	 */
    public MatMatchVO selectMatMatch(MatMatchVO vo) throws Exception {
        MatMatchVO resultVO = matMatchDAO.selectMatMatch(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * MAT_MATCH 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return MAT_MATCH 목록
	 * @exception Exception
	 */
    public List<?> selectMatMatchList(MatMatchDefaultVO searchVO) throws Exception {
        return matMatchDAO.selectMatMatchList(searchVO);
    }

    /**
	 * MAT_MATCH 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return MAT_MATCH 총 갯수
	 * @exception
	 */
    public int selectMatMatchListTotCnt(MatMatchDefaultVO searchVO) {
		return matMatchDAO.selectMatMatchListTotCnt(searchVO);
	}
    
}

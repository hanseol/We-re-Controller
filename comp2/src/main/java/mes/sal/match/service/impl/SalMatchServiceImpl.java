package mes.sal.match.service.impl;

import java.util.LinkedHashMap;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import mes.sal.match.service.SalMatchService;
import mes.sal.match.service.SalMatchVO;
/**
 * @Class Name : SalMatchServiceImpl.java
 * @Description : SalMatch Business Implement class
 * @Modification Information
 *
 * @author hk
 * @since 2021-06-29
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("salMatchService")
public class SalMatchServiceImpl extends EgovAbstractServiceImpl implements
        SalMatchService {
        
    private static final Logger LOGGER = LoggerFactory.getLogger(SalMatchServiceImpl.class);

    @Resource(name="salMatchMapper")
    private SalMatchMapper salMatchDAO;
    
    //@Resource(name="salMatchDAO")
    //private SalMatchDAO salMatchDAO;
    
    /** ID Generation */
    //@Resource(name="{egovSalMatchIdGnrService}")    
    //private EgovIdGnrService egovIdGnrService;

	/**
	 * SAL_MATCH을 등록한다.
	 * @param vo - 등록할 정보가 담긴 SalMatchVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertSalMatch(LinkedHashMap vo) throws Exception {
    	LOGGER.debug(vo.toString());
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	//String id = egovIdGnrService.getNextStringId();
    	//vo.setId(id);
    	LOGGER.debug(vo.toString());
    	
    	salMatchDAO.insertSalMatch(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return null;
    }

    /**
	 * SAL_MATCH을 수정한다.
	 * @param vo - 수정할 정보가 담긴 SalMatchVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateSalMatch(LinkedHashMap vo) throws Exception {
        salMatchDAO.updateSalMatch(vo);
    }

    /**
	 * SAL_MATCH을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 SalMatchVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteSalMatch(LinkedHashMap vo) throws Exception {
        salMatchDAO.deleteSalMatch(vo);
    }

    /**
	 * SAL_MATCH을 조회한다.
	 * @param vo - 조회할 정보가 담긴 SalMatchVO
	 * @return 조회한 SAL_MATCH
	 * @exception Exception
	 */
    public SalMatchVO selectSalMatch(SalMatchVO vo) throws Exception {
        SalMatchVO resultVO = salMatchDAO.selectSalMatch(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * SAL_MATCH 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return SAL_MATCH 목록
	 * @exception Exception
	 */
    public List<?> selectSalMatchList(SalMatchVO searchVO) throws Exception {
        return salMatchDAO.selectSalMatchList(searchVO);
    }

    /**
	 * SAL_MATCH 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return SAL_MATCH 총 갯수
	 * @exception
	 */
    public int selectSalMatchListTotCnt(SalMatchVO searchVO) {
		return salMatchDAO.selectSalMatchListTotCnt(searchVO);
	}
    
}

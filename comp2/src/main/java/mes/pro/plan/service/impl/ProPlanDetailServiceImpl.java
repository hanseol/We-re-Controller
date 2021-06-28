package mes.pro.plan.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import mes.pro.plan.service.ProPlanDetailService;
import mes.pro.plan.service.ProPlanDetailDefaultVO;
import mes.pro.plan.service.ProPlanDetailVO;
/**
 * @Class Name : ProPlanDetailServiceImpl.java
 * @Description : ProPlanDetail Business Implement class
 * @Modification Information
 *
 * @author dahee
 * @since 20210628
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("proPlanDetailService")
public class ProPlanDetailServiceImpl extends EgovAbstractServiceImpl implements
        ProPlanDetailService {
        
    private static final Logger LOGGER = LoggerFactory.getLogger(ProPlanDetailServiceImpl.class);

    @Resource(name="proPlanDetailMapper")
    private ProPlanDetailMapper proPlanDetailDAO;
    
    //@Resource(name="proPlanDetailDAO")
    //private ProPlanDetailDAO proPlanDetailDAO;
    
    /** ID Generation */
    //@Resource(name="{egovProPlanDetailIdGnrService}")    
    //private EgovIdGnrService egovIdGnrService;

	/**
	 * PRO_PLAN_DETAIL을 등록한다.
	 * @param vo - 등록할 정보가 담긴 ProPlanDetailVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertProPlanDetail(ProPlanDetailVO vo) throws Exception {
    	LOGGER.debug(vo.toString());
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	//String id = egovIdGnrService.getNextStringId();
    	//vo.setId(id);
    	LOGGER.debug(vo.toString());
    	
    	proPlanDetailDAO.insertProPlanDetail(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return null;
    }

    /**
	 * PRO_PLAN_DETAIL을 수정한다.
	 * @param vo - 수정할 정보가 담긴 ProPlanDetailVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateProPlanDetail(ProPlanDetailVO vo) throws Exception {
        proPlanDetailDAO.updateProPlanDetail(vo);
    }

    /**
	 * PRO_PLAN_DETAIL을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ProPlanDetailVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteProPlanDetail(ProPlanDetailVO vo) throws Exception {
        proPlanDetailDAO.deleteProPlanDetail(vo);
    }

    /**
	 * PRO_PLAN_DETAIL을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ProPlanDetailVO
	 * @return 조회한 PRO_PLAN_DETAIL
	 * @exception Exception
	 */
    public ProPlanDetailVO selectProPlanDetail(ProPlanDetailVO vo) throws Exception {
        ProPlanDetailVO resultVO = proPlanDetailDAO.selectProPlanDetail(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * PRO_PLAN_DETAIL 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return PRO_PLAN_DETAIL 목록
	 * @exception Exception
	 */
    public List<?> selectProPlanDetailList(ProPlanDetailDefaultVO searchVO) throws Exception {
        return proPlanDetailDAO.selectProPlanDetailList(searchVO);
    }

    /**
	 * PRO_PLAN_DETAIL 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return PRO_PLAN_DETAIL 총 갯수
	 * @exception
	 */
    public int selectProPlanDetailListTotCnt(ProPlanDetailDefaultVO searchVO) {
		return proPlanDetailDAO.selectProPlanDetailListTotCnt(searchVO);
	}
    
}

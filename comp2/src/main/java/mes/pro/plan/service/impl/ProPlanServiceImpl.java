		package mes.pro.plan.service.impl;

import java.util.LinkedHashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import mes.pro.plan.service.ProPlanService;
import mes.pro.plan.service.ProPlanVO;
/**
 * @Class Name : ProPlanServiceImpl.java
 * @Description : ProPlan Business Implement class
 * @Modification Information
 *
 * @author dahee
 * @since 20210628
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("proPlanService")
public class ProPlanServiceImpl extends EgovAbstractServiceImpl implements
        ProPlanService {
        
    private static final Logger LOGGER = LoggerFactory.getLogger(ProPlanServiceImpl.class);

    @Resource(name="proPlanMapper")
    private ProPlanMapper proPlanDAO;
    
    //@Resource(name="proPlanDAO")
    //private ProPlanDAO proPlanDAO;
    
    /** ID Generation */
    //@Resource(name="{egovProPlanIdGnrService}")    
    //private EgovIdGnrService egovIdGnrService;

	/**
	 * PRO_PLAN을 등록한다.
	 * @param vo - 등록할 정보가 담긴 ProPlanVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertProPlan(LinkedHashMap vo) throws Exception {
    	LOGGER.debug(vo.toString());
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	//String id = egovIdGnrService.getNextStringId();
    	//vo.setId(id);
    	LOGGER.debug(vo.toString());
    	
    	proPlanDAO.insertProPlan(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return null;
    }

    /**
	 * PRO_PLAN을 수정한다.
	 * @param vo - 수정할 정보가 담긴 ProPlanVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateProPlan(LinkedHashMap vo) throws Exception {
        proPlanDAO.updateProPlan(vo);
    }

    /**
	 * PRO_PLAN을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ProPlanVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteProPlan(LinkedHashMap vo) throws Exception {
        proPlanDAO.deleteProPlan(vo);
    }

    /**
	 * PRO_PLAN을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ProPlanVO
	 * @return 조회한 PRO_PLAN
	 * @exception Exception
	 */
    public ProPlanVO selectProPlan(ProPlanVO vo) throws Exception {
        ProPlanVO resultVO = proPlanDAO.selectProPlan(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * PRO_PLAN 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return PRO_PLAN 목록
	 * @exception Exception
	 */
    public List<?> selectProPlanList(ProPlanVO vo) throws Exception {
        return proPlanDAO.selectProPlanList(vo);
    }

    /**
	 * PRO_PLAN 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return PRO_PLAN 총 갯수
	 * @exception
	 */
    public int selectProPlanListTotCnt(ProPlanVO vo) {
		return proPlanDAO.selectProPlanListTotCnt(vo);
	}

    
    /*
     * PRODUCT 목록조회
     * 모달창에서 사용
     * 김한설
     * */
	@Override
	public List<?> selectProductList(ProPlanVO vo) throws Exception {
		return proPlanDAO.selectProductList(vo);
	}
	
	 /*
     * PRODUCT 총 갯수 조회
     * 모달창에서 사용
     * 김한설
     * */
	@Override
	public int selectProductTotCnt(ProPlanVO vo) {
		return proPlanDAO.selectProductTotCnt(vo);
	}

	
	/*
	 * erp_order테이블에서 제품리스트 가져오기 
	 * 생산계획관리 페이지의 모달창에서 사용
	 * 김다희
     * */
	@Override
	public List<?> selectErpPordList(ProPlanVO vo) {
		return proPlanDAO.selectErpPordList(vo);
	}

	/*
	 * erp_order테이블에서 가져온 리스트 갯수
	 * 생산계획관리 페이지의 모달창에서 사용
	 * 김다희
     * */
	@Override
	public int selectErpProdCnt(ProPlanVO vo) {
		return proPlanDAO.selectErpProdCnt(vo);
	}

	
	/* 
	 * pro_plan테이블에서 계획리스트 가져오기 
	 * 생산계획관리 페이지의 모달창에서 사용
	 * 김다희
	 * */
	@Override
	public List<?> selectPlanList(ProPlanVO vo) {
		return proPlanDAO.selectPlanList(vo);
	}

	@Override
	public int selectPlanListCnt(ProPlanVO vo) {
		return proPlanDAO.selectPlanListCnt(vo);
	}

	@Override
	public List<?> selectProPlanFormList(ProPlanVO vo) {
		return proPlanDAO.selectProPlanFormList(vo);
	}

	@Override
	public int selectPlanFormListCnt(ProPlanVO vo) {
		return proPlanDAO.selectProPlanFormListTotCnt(vo);
	}

	@Override
	public int insertProPlanM(LinkedHashMap vo) {
		return proPlanDAO.insertProPlanM(vo);
	}

	@Override
	public int updateProPlanD(LinkedHashMap vo) {
		return proPlanDAO.updateProPlanD(vo);
	}

	@Override
	public int deleteProPlanD(LinkedHashMap vo) {
		return proPlanDAO.deleteProPlanD(vo);
		
	}

	@Override
	public List<?> selectProdCode(ProPlanVO searchVO) {
		return proPlanDAO.selectProdCode(searchVO);
	}

	@Override
	public List<?> selectCustomerCode(ProPlanVO searchVO) {
		return proPlanDAO.selectCustomerCode(searchVO);
	}

}

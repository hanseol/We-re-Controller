package mes.pro.plan.service;

import java.util.LinkedHashMap;
import java.util.List;

/**
 * @Class Name : ProPlanService.java
 * @Description : ProPlan Business class
 * @Modification Information
 *
 * @author dahee
 * @since 20210628
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface ProPlanService {
	
	/**
	 * PRO_PLAN을 등록한다.
	 * @param linkedHashMap - 등록할 정보가 담긴 ProPlanVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertProPlan(LinkedHashMap linkedHashMap) throws Exception;
    
    /**
	 * PRO_PLAN을 수정한다.
	 * @param linkedHashMap - 수정할 정보가 담긴 ProPlanVO
	 * @return void형
	 * @exception Exception
	 */
    void updateProPlan(LinkedHashMap linkedHashMap) throws Exception;
    
    /**
	 * PRO_PLAN을 삭제한다.
	 * @param linkedHashMap - 삭제할 정보가 담긴 ProPlanVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteProPlan(LinkedHashMap linkedHashMap) throws Exception;
    
    /**
	 * PRO_PLAN을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ProPlanVO
	 * @return 조회한 PRO_PLAN
	 * @exception Exception
	 */
    ProPlanVO selectProPlan(ProPlanVO vo) throws Exception;
    
    /**
	 * PRO_PLAN 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return PRO_PLAN 목록
	 * @exception Exception
	 */
    List<?> selectProPlanList(ProPlanVO searchVO) throws Exception;
    
    
    /**
	 * PRO_PLAN 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return PRO_PLAN 총 갯수
	 * @exception
	 */
    int selectProPlanListTotCnt(ProPlanVO searchVO);
    
    /*
     * 제품명, 제품코드로 검색
     * 모달창에서 사용
     * 김한설
     * */
    List<?> selectProductList(ProPlanVO vo) throws Exception;
    int selectProductTotCnt(ProPlanVO vo);
    
	/* 
	 * erp_order테이블에서 제품리스트 가져오기 
	 * 생산계획관리 페이지의 모달창에서 사용
	 * 김다희
	 * */
    List<?> selectErpPordList(ProPlanVO vo);
    int selectErpProdCnt(ProPlanVO vo);
    
    
	/* 
	 * pro_plan테이블에서 계획리스트 가져오기 
	 * 생산계획관리 페이지의 모달창에서 사용
	 * 김다희
	 * */
    List<?> selectPlanList(ProPlanVO vo);
    int selectPlanListCnt(ProPlanVO vo);
    
    
    //생산계획관리 페이지에서 전체 조회
    List<?> selectProPlanFormList(ProPlanVO searchVO);
    int selectPlanFormListCnt(ProPlanVO vo);

	int insertProPlanM(LinkedHashMap linkedHashMap);

	int updateProPlanD(LinkedHashMap linkedHashMap);

	int deleteProPlanD(LinkedHashMap linkedHashMap);

	List<?> selectProdCode(ProPlanVO searchVO);

	List<?> selectCustomerCode(ProPlanVO searchVO);
    
    
}

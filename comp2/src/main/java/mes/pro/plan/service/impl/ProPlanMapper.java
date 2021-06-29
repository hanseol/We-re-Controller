package mes.pro.plan.service.impl;

import java.util.List;

import mes.pro.plan.service.ProPlanVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

/**
 * @Class Name : ProPlanMapper.java
 * @Description : ProPlan Mapper Class
 * @Modification Information
 *
 * @author dahee
 * @since 20210628
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Mapper("proPlanMapper")
public interface ProPlanMapper {

	/**
	 * PRO_PLAN을 등록한다.
	 * @param vo - 등록할 정보가 담긴 ProPlanVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public void insertProPlan(ProPlanVO vo) throws Exception;

    /**
	 * PRO_PLAN을 수정한다.
	 * @param vo - 수정할 정보가 담긴 ProPlanVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateProPlan(ProPlanVO vo) throws Exception;

    /**
	 * PRO_PLAN을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ProPlanVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteProPlan(ProPlanVO vo) throws Exception;

    /**
	 * PRO_PLAN을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ProPlanVO
	 * @return 조회한 PRO_PLAN
	 * @exception Exception
	 */
    public ProPlanVO selectProPlan(ProPlanVO vo) throws Exception;

    /**
	 * PRO_PLAN 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return PRO_PLAN 목록
	 * @exception Exception
	 */
    public List<?> selectProPlanList(ProPlanVO searchVO) throws Exception;

    /**
	 * PRO_PLAN 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return PRO_PLAN 총 갯수
	 * @exception
	 */
    public int selectProPlanListTotCnt(ProPlanVO searchVO);

}

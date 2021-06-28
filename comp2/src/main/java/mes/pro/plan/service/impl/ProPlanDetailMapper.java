package mes.pro.plan.service.impl;

import java.util.List;

import mes.pro.plan.service.ProPlanDetailVO;
import mes.pro.plan.service.ProPlanDetailDefaultVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

/**
 * @Class Name : ProPlanDetailMapper.java
 * @Description : ProPlanDetail Mapper Class
 * @Modification Information
 *
 * @author dahee
 * @since 20210628
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Mapper("proPlanDetailMapper")
public interface ProPlanDetailMapper {

	/**
	 * PRO_PLAN_DETAIL을 등록한다.
	 * @param vo - 등록할 정보가 담긴 ProPlanDetailVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public void insertProPlanDetail(ProPlanDetailVO vo) throws Exception;

    /**
	 * PRO_PLAN_DETAIL을 수정한다.
	 * @param vo - 수정할 정보가 담긴 ProPlanDetailVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateProPlanDetail(ProPlanDetailVO vo) throws Exception;

    /**
	 * PRO_PLAN_DETAIL을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ProPlanDetailVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteProPlanDetail(ProPlanDetailVO vo) throws Exception;

    /**
	 * PRO_PLAN_DETAIL을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ProPlanDetailVO
	 * @return 조회한 PRO_PLAN_DETAIL
	 * @exception Exception
	 */
    public ProPlanDetailVO selectProPlanDetail(ProPlanDetailVO vo) throws Exception;

    /**
	 * PRO_PLAN_DETAIL 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return PRO_PLAN_DETAIL 목록
	 * @exception Exception
	 */
    public List<?> selectProPlanDetailList(ProPlanDetailDefaultVO searchVO) throws Exception;

    /**
	 * PRO_PLAN_DETAIL 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return PRO_PLAN_DETAIL 총 갯수
	 * @exception
	 */
    public int selectProPlanDetailListTotCnt(ProPlanDetailDefaultVO searchVO);

}

package mes.pro.order.service.impl;

import java.util.List;

import mes.pro.order.service.ProOrderDetailVO;
import mes.pro.order.service.ProOrderDetailDefaultVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

/**
 * @Class Name : ProOrderDetailMapper.java
 * @Description : ProOrderDetail Mapper Class
 * @Modification Information
 *
 * @author dahee
 * @since 20210628
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Mapper("proOrderDetailMapper")
public interface ProOrderDetailMapper {

	/**
	 * PRO_ORDER_DETAIL을 등록한다.
	 * @param vo - 등록할 정보가 담긴 ProOrderDetailVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public void insertProOrderDetail(ProOrderDetailVO vo) throws Exception;

    /**
	 * PRO_ORDER_DETAIL을 수정한다.
	 * @param vo - 수정할 정보가 담긴 ProOrderDetailVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateProOrderDetail(ProOrderDetailVO vo) throws Exception;

    /**
	 * PRO_ORDER_DETAIL을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ProOrderDetailVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteProOrderDetail(ProOrderDetailVO vo) throws Exception;

    /**
	 * PRO_ORDER_DETAIL을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ProOrderDetailVO
	 * @return 조회한 PRO_ORDER_DETAIL
	 * @exception Exception
	 */
    public ProOrderDetailVO selectProOrderDetail(ProOrderDetailVO vo) throws Exception;

    /**
	 * PRO_ORDER_DETAIL 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return PRO_ORDER_DETAIL 목록
	 * @exception Exception
	 */
    public List<?> selectProOrderDetailList(ProOrderDetailDefaultVO searchVO) throws Exception;

    /**
	 * PRO_ORDER_DETAIL 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return PRO_ORDER_DETAIL 총 갯수
	 * @exception
	 */
    public int selectProOrderDetailListTotCnt(ProOrderDetailDefaultVO searchVO);

}

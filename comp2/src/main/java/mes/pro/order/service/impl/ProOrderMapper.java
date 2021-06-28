package mes.pro.order.service.impl;

import java.util.List;

import mes.pro.order.service.ProOrderVO;
import mes.pro.order.service.ProOrderDefaultVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

/**
 * @Class Name : ProOrderMapper.java
 * @Description : ProOrder Mapper Class
 * @Modification Information
 *
 * @author dahee
 * @since 20210628
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Mapper("proOrderMapper")
public interface ProOrderMapper {

	/**
	 * PRO_ORDER을 등록한다.
	 * @param vo - 등록할 정보가 담긴 ProOrderVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public void insertProOrder(ProOrderVO vo) throws Exception;

    /**
	 * PRO_ORDER을 수정한다.
	 * @param vo - 수정할 정보가 담긴 ProOrderVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateProOrder(ProOrderVO vo) throws Exception;

    /**
	 * PRO_ORDER을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ProOrderVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteProOrder(ProOrderVO vo) throws Exception;

    /**
	 * PRO_ORDER을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ProOrderVO
	 * @return 조회한 PRO_ORDER
	 * @exception Exception
	 */
    public ProOrderVO selectProOrder(ProOrderVO vo) throws Exception;

    /**
	 * PRO_ORDER 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return PRO_ORDER 목록
	 * @exception Exception
	 */
    public List<?> selectProOrderList(ProOrderDefaultVO searchVO) throws Exception;

    /**
	 * PRO_ORDER 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return PRO_ORDER 총 갯수
	 * @exception
	 */
    public int selectProOrderListTotCnt(ProOrderDefaultVO searchVO);

}

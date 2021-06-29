package mes.pro.order.service;

import java.util.List;

import mes.main.service.SearchVO;
import mes.pro.order.service.ProOrderDefaultVO;
import mes.pro.order.service.ProOrderVO;

/**
 * @Class Name : ProOrderService.java
 * @Description : ProOrder Business class
 * @Modification Information
 *
 * @author dahee
 * @since 20210628
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface ProOrderService {
	
	/**
	 * PRO_ORDER을 등록한다.
	 * @param vo - 등록할 정보가 담긴 ProOrderVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertProOrder(ProOrderVO vo) throws Exception;
    
    /**
	 * PRO_ORDER을 수정한다.
	 * @param vo - 수정할 정보가 담긴 ProOrderVO
	 * @return void형
	 * @exception Exception
	 */
    void updateProOrder(ProOrderVO vo) throws Exception;
    
    /**
	 * PRO_ORDER을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ProOrderVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteProOrder(ProOrderVO vo) throws Exception;
    
    /**
	 * PRO_ORDER을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ProOrderVO
	 * @return 조회한 PRO_ORDER
	 * @exception Exception
	 */
    ProOrderVO selectProOrder(ProOrderVO vo) throws Exception;
    
    /**
	 * PRO_ORDER 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return PRO_ORDER 목록
	 * @exception Exception
	 */
    List selectProOrderList(SearchVO searchVO) throws Exception;
    
    /**
	 * PRO_ORDER 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return PRO_ORDER 총 갯수
	 * @exception
	 */
    int selectProOrderListTotCnt(SearchVO searchVO);
    
}

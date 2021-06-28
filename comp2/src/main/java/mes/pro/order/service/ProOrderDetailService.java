package mes.pro.order.service;

import java.util.List;
import mes.pro.order.service.ProOrderDetailDefaultVO;
import mes.pro.order.service.ProOrderDetailVO;

/**
 * @Class Name : ProOrderDetailService.java
 * @Description : ProOrderDetail Business class
 * @Modification Information
 *
 * @author dahee
 * @since 20210628
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface ProOrderDetailService {
	
	/**
	 * PRO_ORDER_DETAIL을 등록한다.
	 * @param vo - 등록할 정보가 담긴 ProOrderDetailVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertProOrderDetail(ProOrderDetailVO vo) throws Exception;
    
    /**
	 * PRO_ORDER_DETAIL을 수정한다.
	 * @param vo - 수정할 정보가 담긴 ProOrderDetailVO
	 * @return void형
	 * @exception Exception
	 */
    void updateProOrderDetail(ProOrderDetailVO vo) throws Exception;
    
    /**
	 * PRO_ORDER_DETAIL을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ProOrderDetailVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteProOrderDetail(ProOrderDetailVO vo) throws Exception;
    
    /**
	 * PRO_ORDER_DETAIL을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ProOrderDetailVO
	 * @return 조회한 PRO_ORDER_DETAIL
	 * @exception Exception
	 */
    ProOrderDetailVO selectProOrderDetail(ProOrderDetailVO vo) throws Exception;
    
    /**
	 * PRO_ORDER_DETAIL 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return PRO_ORDER_DETAIL 목록
	 * @exception Exception
	 */
    List selectProOrderDetailList(ProOrderDetailDefaultVO searchVO) throws Exception;
    
    /**
	 * PRO_ORDER_DETAIL 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return PRO_ORDER_DETAIL 총 갯수
	 * @exception
	 */
    int selectProOrderDetailListTotCnt(ProOrderDetailDefaultVO searchVO);
    
}

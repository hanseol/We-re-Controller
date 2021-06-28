package mes.mat.order.service;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import mes.mat.order.service.ErpMaterialOrderDefaultVO;
import mes.mat.order.service.ErpMaterialOrderVO;

/**
 * @Class Name : ErpMaterialOrderService.java
 * @Description : ErpMaterialOrder Business class
 * @Modification Information
 *
 * @author sungwon
 * @since 20210628
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface ErpMaterialOrderService {
	
	/**
	 * ERP_MATERIAL_ORDER을 등록한다.
	 * @param vo - 등록할 정보가 담긴 ErpMaterialOrderVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertErpMaterialOrder(ErpMaterialOrderVO vo) throws Exception;
    
    /**
	 * ERP_MATERIAL_ORDER을 수정한다.
	 * @param vo - 수정할 정보가 담긴 ErpMaterialOrderVO
	 * @return void형
	 * @exception Exception
	 */
    void updateErpMaterialOrder(ErpMaterialOrderVO vo) throws Exception;
    
    /**
	 * ERP_MATERIAL_ORDER을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ErpMaterialOrderVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteErpMaterialOrder(ErpMaterialOrderVO vo) throws Exception;
    
    /**
	 * ERP_MATERIAL_ORDER을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ErpMaterialOrderVO
	 * @return 조회한 ERP_MATERIAL_ORDER
	 * @exception Exception
	 */
    ErpMaterialOrderVO selectErpMaterialOrder(ErpMaterialOrderVO vo) throws Exception;
    
    /**
	 * ERP_MATERIAL_ORDER 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return ERP_MATERIAL_ORDER 목록
	 * @exception Exception
	 */
    List selectErpMaterialOrderList(ErpMaterialOrderDefaultVO searchVO) throws Exception;
    
    /**
	 * ERP_MATERIAL_ORDER 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return ERP_MATERIAL_ORDER 총 갯수
	 * @exception
	 */
    int selectErpMaterialOrderListTotCnt(ErpMaterialOrderDefaultVO searchVO);
    
    //리스트 전체 데이터 조회
	List<?> selectOrderList(ErpMaterialOrderDefaultVO searchVO) throws Exception;
}

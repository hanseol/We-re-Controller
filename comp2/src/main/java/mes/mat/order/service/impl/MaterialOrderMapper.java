package mes.mat.order.service.impl;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import mes.mat.order.service.MaterialOrderVO;

/**
 * @Class Name : ErpMaterialOrderMapper.java
 * @Description : ErpMaterialOrder Mapper Class
 * @Modification Information
 *
 * @author sungwon
 * @since 20210628
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Mapper("erpMaterialOrderMapper")
public interface MaterialOrderMapper {

	/**
	 * ERP_MATERIAL_ORDER을 등록한다.
	 * @param vo - 등록할 정보가 담긴 ErpMaterialOrderVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public void insertErpMaterialOrder(MaterialOrderVO vo) throws Exception;

    /**
	 * ERP_MATERIAL_ORDER을 수정한다.
	 * @param vo - 수정할 정보가 담긴 ErpMaterialOrderVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateErpMaterialOrder(MaterialOrderVO vo) throws Exception;

    /**
	 * ERP_MATERIAL_ORDER을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ErpMaterialOrderVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteErpMaterialOrder(MaterialOrderVO vo) throws Exception;

    /**
	 * ERP_MATERIAL_ORDER을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ErpMaterialOrderVO
	 * @return 조회한 ERP_MATERIAL_ORDER
	 * @exception Exception
	 */
    public MaterialOrderVO selectErpMaterialOrder(MaterialOrderVO vo) throws Exception;

    /**
	 * ERP_MATERIAL_ORDER 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return ERP_MATERIAL_ORDER 목록
	 * @exception Exception
	 */
    public List<?> selectErpMaterialOrderList(MaterialOrderVO searchVO) throws Exception;

    /**
	 * ERP_MATERIAL_ORDER 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return ERP_MATERIAL_ORDER 총 갯수
	 * @exception
	 */
    public int selectMatOrderListTotCnt(MaterialOrderVO searchVO);
    
    //리스트 전체 데이터 출력
    public List<?> selectMatOrderList(MaterialOrderVO searchVO) throws Exception;
}

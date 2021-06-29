package mes.mat.order.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import mes.mat.order.service.ErpMaterialOrderService;
import mes.mat.order.service.ErpMaterialOrderVO;
/**
 * @Class Name : ErpMaterialOrderServiceImpl.java
 * @Description : ErpMaterialOrder Business Implement class
 * @Modification Information
 *
 * @author sungwon
 * @since 20210628
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("erpMaterialOrderService")
public class ErpMaterialOrderServiceImpl extends EgovAbstractServiceImpl implements
        ErpMaterialOrderService {
        
    private static final Logger LOGGER = LoggerFactory.getLogger(ErpMaterialOrderServiceImpl.class);

    @Resource(name="erpMaterialOrderMapper")
    private ErpMaterialOrderMapper erpMaterialOrderDAO;
    
    //@Resource(name="erpMaterialOrderDAO")
    //private ErpMaterialOrderDAO erpMaterialOrderDAO;
    
    /** ID Generation */
    //@Resource(name="{egovErpMaterialOrderIdGnrService}")    
    //private EgovIdGnrService egovIdGnrService;

	/**
	 * ERP_MATERIAL_ORDER을 등록한다.
	 * @param vo - 등록할 정보가 담긴 ErpMaterialOrderVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertErpMaterialOrder(ErpMaterialOrderVO vo) throws Exception {
    	LOGGER.debug(vo.toString());
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	//String id = egovIdGnrService.getNextStringId();
    	//vo.setId(id);
    	LOGGER.debug(vo.toString());
    	
    	erpMaterialOrderDAO.insertErpMaterialOrder(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return null;
    }

    /**
	 * ERP_MATERIAL_ORDER을 수정한다.
	 * @param vo - 수정할 정보가 담긴 ErpMaterialOrderVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateErpMaterialOrder(ErpMaterialOrderVO vo) throws Exception {
        erpMaterialOrderDAO.updateErpMaterialOrder(vo);
    }

    /**
	 * ERP_MATERIAL_ORDER을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ErpMaterialOrderVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteErpMaterialOrder(ErpMaterialOrderVO vo) throws Exception {
        erpMaterialOrderDAO.deleteErpMaterialOrder(vo);
    }

    /**
	 * ERP_MATERIAL_ORDER을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ErpMaterialOrderVO
	 * @return 조회한 ERP_MATERIAL_ORDER
	 * @exception Exception
	 */
    public ErpMaterialOrderVO selectErpMaterialOrder(ErpMaterialOrderVO vo) throws Exception {
        ErpMaterialOrderVO resultVO = erpMaterialOrderDAO.selectErpMaterialOrder(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * ERP_MATERIAL_ORDER 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return ERP_MATERIAL_ORDER 목록
	 * @exception Exception
	 */
    public List<?> selectErpMaterialOrderList(ErpMaterialOrderVO searchVO) throws Exception {
        return erpMaterialOrderDAO.selectErpMaterialOrderList(searchVO);
    }

    /**
	 * ERP_MATERIAL_ORDER 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return ERP_MATERIAL_ORDER 총 갯수
	 * @exception
	 */
    public int selectErpMaterialOrderListTotCnt(ErpMaterialOrderVO searchVO) {
		return erpMaterialOrderDAO.selectErpMaterialOrderListTotCnt(searchVO);
	}
    
    //리스트 전체 조회
	@Override
	public List<?> selectOrderList(ErpMaterialOrderVO searchVO) throws Exception {
		
		return erpMaterialOrderDAO.selectOrderList(searchVO);
	}
    
}

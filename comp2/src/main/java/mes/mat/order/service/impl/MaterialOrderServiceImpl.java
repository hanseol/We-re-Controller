package mes.mat.order.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import mes.mat.order.service.MaterialOrderService;
import mes.mat.order.service.MaterialOrderVO;
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
public class MaterialOrderServiceImpl extends EgovAbstractServiceImpl implements
        MaterialOrderService {
        
    private static final Logger LOGGER = LoggerFactory.getLogger(MaterialOrderServiceImpl.class);

    @Resource(name="erpMaterialOrderMapper")
    private MaterialOrderMapper matOrderDAO;
    
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
    public String insertErpMaterialOrder(MaterialOrderVO vo) throws Exception {
    	LOGGER.debug(vo.toString());
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	//String id = egovIdGnrService.getNextStringId();
    	//vo.setId(id);
    	LOGGER.debug(vo.toString());
    	
    	matOrderDAO.insertErpMaterialOrder(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return null;
    }

    /**
	 * ERP_MATERIAL_ORDER을 수정한다.
	 * @param vo - 수정할 정보가 담긴 ErpMaterialOrderVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateErpMaterialOrder(MaterialOrderVO vo) throws Exception {
    	matOrderDAO.updateErpMaterialOrder(vo);
    }

    /**
	 * ERP_MATERIAL_ORDER을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ErpMaterialOrderVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteErpMaterialOrder(MaterialOrderVO vo) throws Exception {
    	matOrderDAO.deleteErpMaterialOrder(vo);
    }

    /**
	 * ERP_MATERIAL_ORDER을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ErpMaterialOrderVO
	 * @return 조회한 ERP_MATERIAL_ORDER
	 * @exception Exception
	 */
    public MaterialOrderVO selectErpMaterialOrder(MaterialOrderVO vo) throws Exception {
        MaterialOrderVO resultVO = matOrderDAO.selectErpMaterialOrder(vo);
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
    public List<?> selectErpMaterialOrderList(MaterialOrderVO searchVO) throws Exception {
        return matOrderDAO.selectErpMaterialOrderList(searchVO);
    }

    /**
	 * ERP_MATERIAL_ORDER 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return ERP_MATERIAL_ORDER 총 갯수
	 * @exception
	 */
    
    //행 카운트
    public int selectMatOrderListTotCnt(MaterialOrderVO searchVO) {
		return matOrderDAO.selectMatOrderListTotCnt(searchVO);
	}
    
    //리스트 전체 조회
	@Override
	public List<?> selectMatOrderList(MaterialOrderVO searchVO) throws Exception {
		
		return matOrderDAO.selectMatOrderList(searchVO);
	}
    
}

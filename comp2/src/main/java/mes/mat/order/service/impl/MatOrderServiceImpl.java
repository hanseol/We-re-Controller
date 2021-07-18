package mes.mat.order.service.impl;

import java.util.LinkedHashMap;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import mes.mat.order.service.MatOrderService;
import mes.mat.order.service.MatOrderVO;
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

@Service("matOrderService")
public class MatOrderServiceImpl extends EgovAbstractServiceImpl implements
        MatOrderService {
        
    private static final Logger LOGGER = LoggerFactory.getLogger(MatOrderServiceImpl.class);

    @Resource(name="matOrderMapper")
    private MatOrderMapper matOrderMapper;
    
	//등록
    public String insertMatOrder(LinkedHashMap vo) throws Exception {
    	LOGGER.debug(vo.toString());
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	//String id = egovIdGnrService.getNextStringId();
    	//vo.setId(id);
    	LOGGER.debug(vo.toString());
    	
    	matOrderMapper.insertMatOrder(vo);

    	//TODO 해당 테이블 정보에 맞게 수정    	
        return null;
    }

    //수정
    public int updateMatOrder(LinkedHashMap vo) throws Exception {
    	return matOrderMapper.updateMatOrder(vo);
    }

    //삭제
    public int deleteMatOrder(LinkedHashMap vo) throws Exception {
    	return matOrderMapper.deleteMatOrder(vo);
    }
    
    //리스트 전체조회
    public List<?> selectMatOrderList(MatOrderVO searchVO) throws Exception {
    	return matOrderMapper.selectMatOrderList(searchVO);
    }
    
    //발주코드 모달
    public List<?> searchMatOrderCodeList(MatOrderVO searchVO) throws Exception {
    	return matOrderMapper.searchMatOrderCodeList(searchVO);
    }
    
    //순수발주코드 모달
    public List<?> searchMatOrderCodePureList(MatOrderVO searchVO) throws Exception {
    	return matOrderMapper.searchMatOrderCodePureList(searchVO);
    }
}

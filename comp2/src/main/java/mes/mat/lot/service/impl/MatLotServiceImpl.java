package mes.mat.lot.service.impl;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import mes.mat.lot.service.MatLotService;
import mes.mat.lot.service.MatLotVO;
/**
 * @Class Name : MatLotServiceImpl.java
 * @Description : MatLot Business Implement class
 * @Modification Information
 *
 * @author sungwon
 * @since 20210625
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("matLotService")
public class MatLotServiceImpl extends EgovAbstractServiceImpl implements
		MatLotService {
        
    private static final Logger LOGGER = LoggerFactory.getLogger(MatLotServiceImpl.class);

    @Resource(name="matLotMapper")
    private MatLotMapper matLotMapper;
    
	//등록
    public Map<String, Object> insertMatLot(LinkedHashMap vo) throws Exception {
    	Map<String, Object> map = new HashMap<String, Object>();
    	LOGGER.debug(vo.toString());
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	//String id = egovIdGnrService.getNextStringId();
    	//vo.setId(id);
    	LOGGER.debug(vo.toString());
    	
    	matLotMapper.insertMatLot(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return map;
    }

    //수정
    public void updateMatLot(LinkedHashMap vo) throws Exception {
    	matLotMapper.updateMatLot(vo);
    }
    //입출고 수정 추가
    public void updateMatInout(LinkedHashMap vo) throws Exception {
    	matLotMapper.updateMatInout(vo);
    }
    //삭제
    public void deleteMatLot(LinkedHashMap vo) throws Exception {
    	matLotMapper.deleteMatLot(vo);
    }

    //전체 리스트 출력
    public List<?> selectMatLotList(MatLotVO searchVO) throws Exception {
        return matLotMapper.selectMatLotList(searchVO);
    }

    //모달 자재코드 리스트 출력
	public List<?> searchMaterialCodeList(MatLotVO searchVO) throws Exception {
		return matLotMapper.searchMaterialCodeList(searchVO);
	}
	
	//모달 입고업체 리스트 출력
	public List<?> searchVendorCodeList(MatLotVO searchVO) throws Exception {
		return matLotMapper.searchVendorCodeList(searchVO);
	}

    
}

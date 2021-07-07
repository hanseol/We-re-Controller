package mes.mat.inout.service.impl;

import java.util.LinkedHashMap;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import mes.mat.inout.service.MatInoutService;
import mes.mat.inout.service.MatInoutVO;
/**
 * @Class Name : MatInoutServiceImpl.java
 * @Description : MatInout Business Implement class
 * @Modification Information
 *
 * @author sungwon
 * @since 20210625
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("matInoutService")
public class MatInoutServiceImpl extends EgovAbstractServiceImpl implements
        MatInoutService {
        
    private static final Logger LOGGER = LoggerFactory.getLogger(MatInoutServiceImpl.class);

    @Resource(name="matInoutMapper")
    private MatInoutMapper matInoutMapper;
    
	//등록
    public String insertMatInout(LinkedHashMap vo) throws Exception {
    	LOGGER.debug(vo.toString());
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	//String id = egovIdGnrService.getNextStringId();
    	//vo.setId(id);
    	LOGGER.debug(vo.toString());
    	
    	matInoutMapper.insertMatInout(vo);

    	//TODO 해당 테이블 정보에 맞게 수정    	
        return null;
    }

    //수정
    public void updateMatInout(LinkedHashMap vo) throws Exception {
    	matInoutMapper.updateMatInout(vo);
    }

    //삭제
    public void deleteMatInout(LinkedHashMap vo) throws Exception {
    	matInoutMapper.deleteMatInout(vo);
    }
    
    //리스트 전체조회
    public List<?> selectMatInoutList(MatInoutVO searchVO) throws Exception {
    	return matInoutMapper.selectMatInoutList(searchVO);
    }
    
    //모달 자재코드 리스트 출력
	public List<?> searchMaterialCodeList(MatInoutVO searchVO) throws Exception {
		return matInoutMapper.searchMaterialCodeList(searchVO);
	}
	
	//모달 입고업체 리스트 출력
	public List<?> searchVendorCodeList(MatInoutVO searchVO) throws Exception {
		return matInoutMapper.searchVendorCodeList(searchVO);
	}
	
	//모달 자재LOT_NO 리스트 출력
	public List<?> searchMaterialLotList(MatInoutVO searchVO) throws Exception {
		return matInoutMapper.searchMaterialLotList(searchVO);
	}

}

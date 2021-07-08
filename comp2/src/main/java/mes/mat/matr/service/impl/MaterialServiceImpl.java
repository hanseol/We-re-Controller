package mes.mat.matr.service.impl;

import java.util.LinkedHashMap;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import mes.mat.matr.service.MaterialService;
import mes.mat.matr.service.MaterialVO;
/**
 * @Class Name : MaterialServiceImpl.java
 * @Description : Material Business Implement class
 * @Modification Information
 *
 * @author sungwon
 * @since 20210629
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
  
@Service("materialService")
public class MaterialServiceImpl extends EgovAbstractServiceImpl implements
        MaterialService {
         
    private static final Logger LOGGER = LoggerFactory.getLogger(MaterialServiceImpl.class);

    @Resource(name="materialMapper")
    private MaterialMapper materialMapper;
    
	//등록
    public String insertMaterial(LinkedHashMap vo) throws Exception {
    	LOGGER.debug(vo.toString());
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	//String id = egovIdGnrService.getNextStringId();
    	//vo.setId(id);
    	LOGGER.debug(vo.toString());
    	
    	materialMapper.insertMaterial(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return null;
    }
    //수정
    public void updateMaterial(LinkedHashMap vo) throws Exception {
    	materialMapper.updateMaterial(vo);
    }

    //삭제
    public void deleteMaterial(LinkedHashMap vo) throws Exception {
    	materialMapper.deleteMaterial(vo);
    }

    //전체 리스트 출력
    public List<?> selectMaterialList(MaterialVO searchVO) throws Exception {
        return materialMapper.selectMaterialList(searchVO);
    }


}

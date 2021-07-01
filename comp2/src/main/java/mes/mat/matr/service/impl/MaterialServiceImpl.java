package mes.mat.matr.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import mes.mat.matr.service.MaterialService;
import mes.mat.matr.service.MaterialVO;
/**
 * @Class Name : ComMaterialServiceImpl.java
 * @Description : ComMaterial Business Implement class
 * @Modification Information
 *
 * @author sungwon
 * @since 20210629
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
  
@Service("comMaterialService")
public class MaterialServiceImpl extends EgovAbstractServiceImpl implements
        MaterialService {
         
    private static final Logger LOGGER = LoggerFactory.getLogger(MaterialServiceImpl.class);

    @Resource(name="comMaterialMapper")
    private MaterialMapper comMaterialDAO;
    
    //@Resource(name="comMaterialDAO")
    //private ComMaterialDAO comMaterialDAO;
    
    /** ID Generation */
    //@Resource(name="{egovComMaterialIdGnrService}")    
    //private EgovIdGnrService egovIdGnrService;

	/**
	 * COM_MATERIAL을 등록한다.
	 * @param vo - 등록할 정보가 담긴 ComMaterialVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertComMaterial(MaterialVO vo) throws Exception {
    	LOGGER.debug(vo.toString());
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	//String id = egovIdGnrService.getNextStringId();
    	//vo.setId(id);
    	LOGGER.debug(vo.toString());
    	
    	comMaterialDAO.insertComMaterial(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return null;
    }

    /**
	 * COM_MATERIAL을 수정한다.
	 * @param vo - 수정할 정보가 담긴 ComMaterialVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateComMaterial(MaterialVO vo) throws Exception {
        comMaterialDAO.updateComMaterial(vo);
    }

    /**
	 * COM_MATERIAL을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ComMaterialVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteComMaterial(MaterialVO vo) throws Exception {
        comMaterialDAO.deleteComMaterial(vo);
    }

    /**
	 * COM_MATERIAL을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ComMaterialVO
	 * @return 조회한 COM_MATERIAL
	 * @exception Exception
	 */
    public MaterialVO selectComMaterial(MaterialVO vo) throws Exception {
        MaterialVO resultVO = comMaterialDAO.selectComMaterial(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * COM_MATERIAL 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COM_MATERIAL 목록
	 * @exception Exception
	 */
    public List<?> selectComMaterialList(MaterialVO searchVO) throws Exception {
        return comMaterialDAO.selectComMaterialList(searchVO);
    }

    /**
	 * COM_MATERIAL 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COM_MATERIAL 총 갯수
	 * @exception
	 */
    public int selectComMaterialListTotCnt(MaterialVO searchVO) {
		return comMaterialDAO.selectComMaterialListTotCnt(searchVO);
	}
    public List<?> selectMatList(MaterialVO searchVO) throws Exception {
    	
    	return comMaterialDAO.selectMatList(searchVO);
    }
}

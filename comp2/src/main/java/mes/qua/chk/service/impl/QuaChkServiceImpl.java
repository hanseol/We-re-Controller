package mes.qua.chk.service.impl;

import java.util.LinkedHashMap;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import mes.qua.chk.service.QuaChkService;
import mes.qua.chk.service.QuaChkVO;
/**
 * @Class Name : QuaMaterialChkServiceImpl.java
 * @Description : QuaMaterialChk Business Implement class
 * @Modification Information
 *
 * @author sungwon
 * @since 20210629
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("quaChkService")
public class QuaChkServiceImpl extends EgovAbstractServiceImpl implements
        QuaChkService {
        
    private static final Logger LOGGER = LoggerFactory.getLogger(QuaChkServiceImpl.class);

    @Resource(name="quaChkMapper")
    private QuaChkMapper quaChkMapper;
    
    //@Resource(name="quaMaterialChkDAO")
    //private QuaMaterialChkDAO quaMaterialChkDAO;
    
    /** ID Generation */
    //@Resource(name="{egovQuaMaterialChkIdGnrService}")    
    //private EgovIdGnrService egovIdGnrService;

	//등록
    public String insertQuaChk(LinkedHashMap vo) throws Exception {
    	LOGGER.debug(vo.toString());
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	//String id = egovIdGnrService.getNextStringId();
    	//vo.setId(id);
    	LOGGER.debug(vo.toString());
    	
    	quaChkMapper.insertQuaChk(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return null;
    }

    //수정
    public void updateQuaChk(LinkedHashMap vo) throws Exception {
    	quaChkMapper.updateQuaChk(vo);
    }

    //삭제
    public void deleteQuaChk(LinkedHashMap vo) throws Exception {
    	quaChkMapper.deleteQuaChk(vo);
    }


    //전체리스트 조회
    public List<?> selectQuaChkList(QuaChkVO searchVO) throws Exception {
        return quaChkMapper.selectQuaChkList(searchVO);
    }


    
}

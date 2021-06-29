package mes.qua.chk.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import mes.qua.chk.service.QuaMaterialChkDefaultVO;
import mes.qua.chk.service.QuaMaterialChkService;
import mes.qua.chk.service.QuaMaterialChkVO;
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

@Service("quaMaterialChkService")
public class QuaMaterialChkServiceImpl extends EgovAbstractServiceImpl implements
        QuaMaterialChkService {
        
    private static final Logger LOGGER = LoggerFactory.getLogger(QuaMaterialChkServiceImpl.class);

    @Resource(name="quaMaterialChkMapper")
    private QuaMaterialChkMapper quaMaterialChkDAO;
    
    //@Resource(name="quaMaterialChkDAO")
    //private QuaMaterialChkDAO quaMaterialChkDAO;
    
    /** ID Generation */
    //@Resource(name="{egovQuaMaterialChkIdGnrService}")    
    //private EgovIdGnrService egovIdGnrService;

	/**
	 * QUA_MATERIAL_CHK을 등록한다.
	 * @param vo - 등록할 정보가 담긴 QuaMaterialChkVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertQuaMaterialChk(QuaMaterialChkVO vo) throws Exception {
    	LOGGER.debug(vo.toString());
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	//String id = egovIdGnrService.getNextStringId();
    	//vo.setId(id);
    	LOGGER.debug(vo.toString());
    	
    	quaMaterialChkDAO.insertQuaMaterialChk(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return null;
    }

    /**
	 * QUA_MATERIAL_CHK을 수정한다.
	 * @param vo - 수정할 정보가 담긴 QuaMaterialChkVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateQuaMaterialChk(QuaMaterialChkVO vo) throws Exception {
        quaMaterialChkDAO.updateQuaMaterialChk(vo);
    }

    /**
	 * QUA_MATERIAL_CHK을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 QuaMaterialChkVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteQuaMaterialChk(QuaMaterialChkVO vo) throws Exception {
        quaMaterialChkDAO.deleteQuaMaterialChk(vo);
    }

    /**
	 * QUA_MATERIAL_CHK을 조회한다.
	 * @param vo - 조회할 정보가 담긴 QuaMaterialChkVO
	 * @return 조회한 QUA_MATERIAL_CHK
	 * @exception Exception
	 */
    public QuaMaterialChkVO selectQuaMaterialChk(QuaMaterialChkVO vo) throws Exception {
        QuaMaterialChkVO resultVO = quaMaterialChkDAO.selectQuaMaterialChk(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * QUA_MATERIAL_CHK 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return QUA_MATERIAL_CHK 목록
	 * @exception Exception
	 */
    public List<?> selectQuaMaterialChkList(QuaMaterialChkDefaultVO searchVO) throws Exception {
        return quaMaterialChkDAO.selectQuaMaterialChkList(searchVO);
    }

    /**
	 * QUA_MATERIAL_CHK 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return QUA_MATERIAL_CHK 총 갯수
	 * @exception
	 */
    public int selectQuaMaterialChkListTotCnt(QuaMaterialChkDefaultVO searchVO) {
		return quaMaterialChkDAO.selectQuaMaterialChkListTotCnt(searchVO);
	}
    
}

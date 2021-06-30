package mes.com.comCode.service.impl;

import java.util.LinkedHashMap;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import mes.com.comCode.service.ComCodeService;
import mes.com.comCode.service.ComCodeVO;
/**
 * @Class Name : ComCodeServiceImpl.java
 * @Description : ComCode Business Implement class
 * @Modification Information
 *
 * @author 경윤수
 * @since 2021-06-30
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("comCodeService")
public class ComCodeServiceImpl extends EgovAbstractServiceImpl implements
        ComCodeService {
        
    private static final Logger LOGGER = LoggerFactory.getLogger(ComCodeServiceImpl.class);

    @Resource(name="comCodeMapper")
    private ComCodeMapper comCodeDAO;
    
    //@Resource(name="comCodeDAO")
    //private ComCodeDAO comCodeDAO;
    
    /** ID Generation */
    //@Resource(name="{egovComCodeIdGnrService}")    
    //private EgovIdGnrService egovIdGnrService;

	/**
	 * COM_CODE을 등록한다.
	 * @param vo - 등록할 정보가 담긴 ComCodeVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertComCode(LinkedHashMap vo) throws Exception {
    	LOGGER.debug(vo.toString());
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	//String id = egovIdGnrService.getNextStringId();
    	//vo.setId(id);
    	LOGGER.debug(vo.toString());
    	
    	comCodeDAO.insertComCode(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return null;	
    }

    /**
	 * COM_CODE을 수정한다.
	 * @param vo - 수정할 정보가 담긴 ComCodeVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateComCode(LinkedHashMap vo) throws Exception {
        comCodeDAO.updateComCode(vo);
    }

    /**
	 * COM_CODE을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ComCodeVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteComCode(LinkedHashMap vo) throws Exception {
        comCodeDAO.deleteComCode(vo);
    }

    /**
	 * COM_CODE을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ComCodeVO
	 * @return 조회한 COM_CODE
	 * @exception Exception
	 */
    public ComCodeVO selectComCode(ComCodeVO vo) throws Exception {
        ComCodeVO resultVO = comCodeDAO.selectComCode(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * COM_CODE 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COM_CODE 목록
	 * @exception Exception
	 */
    public List<?> selectComCodeList(ComCodeVO searchVO) throws Exception {
        return comCodeDAO.selectComCodeList(searchVO);
    }

    /**
	 * COM_CODE 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COM_CODE 총 갯수
	 * @exception
	 */
    public int selectComCodeListTotCnt(ComCodeVO searchVO) {
		return comCodeDAO.selectComCodeListTotCnt(searchVO);
	}
    
}

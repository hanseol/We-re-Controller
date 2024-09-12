package mes.mac.service.impl;

import java.util.LinkedHashMap;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import mes.mac.service.MacDateResultVO;
import mes.mac.service.MacService;
import mes.mac.service.MacVO;
import mes.pro.proc.service.ProProcessVO;
/**
 * @Class Name : MacServiceImpl.java
 * @Description : Mac Business Implement class
 * @Modification Information
 *
 * @author hanseol
 * @since 20210708
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("macService")
public class MacServiceImpl extends EgovAbstractServiceImpl implements
        MacService {
        
    private static final Logger LOGGER = LoggerFactory.getLogger(MacServiceImpl.class);

    @Resource(name="macMapper")
    private MacMapper macDAO;
    
    //@Resource(name="macDAO")
    //private MacDAO macDAO;
    
    /** ID Generation */
    //@Resource(name="{egovMacIdGnrService}")    
    //private EgovIdGnrService egovIdGnrService;

	/**
	 * MAC을 등록한다.
	 * @param vo - 등록할 정보가 담긴 MacVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertMac(MacVO vo) throws Exception {
    	LOGGER.debug(vo.toString());
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	//String id = egovIdGnrService.getNextStringId();
    	//vo.setId(id);
    	LOGGER.debug(vo.toString());
    	
    	macDAO.insertMac(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return null;
    }

    /**
	 * MAC을 수정한다.
	 * @param vo - 수정할 정보가 담긴 MacVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateMac(LinkedHashMap vo) throws Exception {
        macDAO.updateMac(vo);
    }

    /**
	 * MAC을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 MacVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteMac(LinkedHashMap vo) throws Exception {
        macDAO.deleteMac(vo);
    }

    /**
	 * MAC을 조회한다.
	 * @param vo - 조회할 정보가 담긴 MacVO
	 * @return 조회한 MAC
	 * @exception Exception
	 */
    public MacVO selectMac(MacVO vo) throws Exception {
        MacVO resultVO = macDAO.selectMac(vo);
        if (resultVO == null) {
        	resultVO = new MacVO();
        	//throw processException("info.nodata.msg");
        }
        return resultVO;
    }

    /**
	 * MAC 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return MAC 목록
	 * @exception Exception
	 */
    public List<MacVO> selectMacList(MacVO searchVO) throws Exception {
        return macDAO.selectMacList(searchVO);
    }

    public List<MacDateResultVO> selectLeftDate() throws Exception {
    	return macDAO.selectLeftDate();
    }

	@Override
	public String selectNextMacCode() throws Exception {
		return macDAO.selectNextMacCode();
	}

	@Override
	public List<String> selectMacSize() {
		return macDAO.selectMacSize();
	}

	@Override
	public List<String> selectMacUsePurpose() {
		return macDAO.selectMacUsePurpose();
	}

	@Override
	public List<String> selectMacModel() {
		return macDAO.selectMacModel();
	}

   
}

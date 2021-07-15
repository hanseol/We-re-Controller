package mes.pro.proc.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import mes.pro.proc.service.ProProcessService;
import mes.pro.proc.service.ProProcessVO;
import mes.pro.proc.service.impl.ProProcessMapper;
/**
 * @Class Name : ProProcessServiceImpl.java
 * @Description : ProProcess Business Implement class
 * @Modification Information
 *
 * @author dahee
 * @since 20210707
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("proProcessService")
public class ProProcessServiceImpl extends EgovAbstractServiceImpl implements
        ProProcessService {
        
    private static final Logger LOGGER = LoggerFactory.getLogger(ProProcessServiceImpl.class);

    @Resource(name="proProcessMapper")
    private ProProcessMapper proProcessDAO;
    
    //@Resource(name="proProcessDAO")
    //private ProProcessDAO proProcessDAO;
    
    /** ID Generation */
    //@Resource(name="{egovProProcessIdGnrService}")    
    //private EgovIdGnrService egovIdGnrService;

	/**
	 * PRO_PROCESS을 등록한다.
	 * @param vo - 등록할 정보가 담긴 ProProcessVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertProProcess(ProProcessVO vo) throws Exception {
    	LOGGER.debug(vo.toString());
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	//String id = egovIdGnrService.getNextStringId();
    	//vo.setId(id);
    	LOGGER.debug(vo.toString());
    	
    	proProcessDAO.insertProProcess(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return null;
    }

    /**
	 * PRO_PROCESS을 수정한다.
	 * @param vo - 수정할 정보가 담긴 ProProcessVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateProProcess(ProProcessVO vo) throws Exception {
        proProcessDAO.updateProProcess(vo);
    }

    /**
	 * PRO_PROCESS을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ProProcessVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteProProcess(ProProcessVO vo) throws Exception {
        proProcessDAO.deleteProProcess(vo);
    }

    /**
	 * PRO_PROCESS을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ProProcessVO
	 * @return 조회한 PRO_PROCESS
	 * @exception Exception
	 */
    public ProProcessVO selectProProcess(ProProcessVO vo) throws Exception {
        ProProcessVO resultVO = proProcessDAO.selectProProcess(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * PRO_PROCESS 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return PRO_PROCESS 목록
	 * @exception Exception
	 */
    public List<?> selectProProcessList(ProProcessVO searchVO) throws Exception {
        return proProcessDAO.selectProProcessList(searchVO);
    }

    /**
	 * PRO_PROCESS 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return PRO_PROCESS 총 갯수
	 * @exception
	 */
    public int selectProProcessListTotCnt(ProProcessVO searchVO) {
		return proProcessDAO.selectProProcessListTotCnt(searchVO);
	}

    
    //공정흐름 관리시 필요한 지시코드 조회
	@Override
	public List<String> selectProOrderDetailCode(ProProcessVO vo) {
		return proProcessDAO.selectProOrderDetailCode(vo);
	}

	//선택된 지시에 사용되도록 설정된 자재 LOT 조회
	@Override
	public List<ProProcessVO> selectMatrLot(ProProcessVO vo) {
		return proProcessDAO.selectMatrLot(vo);
	}

	//공정흐름관리 페이지에 넘겨줄 공정이름 조회
	@Override
	public List<ProProcessVO> selectProProcessName() {
		return proProcessDAO.selectProProcessName();
	}
	
	//생산 공정 시작 시간 & 공정 작업 상태 업데이트
	@Override
	public void updateStartTime(ProProcessVO vo) throws Exception {
		proProcessDAO.updateStartTime(vo);
	}

	@Override
	public String selectProdName(ProProcessVO vo) {
		return proProcessDAO.selectProdName(vo);
	}

    
}

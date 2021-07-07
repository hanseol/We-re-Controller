package mes.member.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.com.utl.sim.service.EgovFileScrty;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import mes.member.service.ErpEmpService;
import mes.member.service.ErpEmpVO;
/**
 * @Class Name : ErpEmpServiceImpl.java
 * @Description : ErpEmp Business Implement class
 * @Modification Information
 *
 * @author hanseol
 * @since 20210706
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("erpEmpService")
public class ErpEmpServiceImpl extends EgovAbstractServiceImpl implements
        ErpEmpService {
        
    private static final Logger LOGGER = LoggerFactory.getLogger(ErpEmpServiceImpl.class);

    @Resource(name="erpEmpMapper")
    private ErpEmpMapper erpEmpDAO;
    
    //@Resource(name="erpEmpDAO")
    //private ErpEmpDAO erpEmpDAO;
    
    /** ID Generation */
    //@Resource(name="{egovErpEmpIdGnrService}")    
    //private EgovIdGnrService egovIdGnrService;

	/**
	 * ERP_EMP을 등록한다.
	 * @param vo - 등록할 정보가 담긴 ErpEmpVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertErpEmp(ErpEmpVO vo) throws Exception {
    	LOGGER.debug(vo.toString());
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	//String id = egovIdGnrService.getNextStringId();
    	//vo.setId(id);
    	LOGGER.debug(vo.toString());
    	
    	erpEmpDAO.insertErpEmp(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return null;
    }

    /**
	 * ERP_EMP을 수정한다.
	 * @param vo - 수정할 정보가 담긴 ErpEmpVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateErpEmp(ErpEmpVO vo) throws Exception {
        erpEmpDAO.updateErpEmp(vo);
    }

    /**
	 * ERP_EMP을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ErpEmpVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteErpEmp(ErpEmpVO vo) throws Exception {
        erpEmpDAO.deleteErpEmp(vo);
    }

    /**
	 * ERP_EMP을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ErpEmpVO
	 * @return 조회한 ERP_EMP
	 * @exception Exception
	 */
    public ErpEmpVO selectErpEmp(ErpEmpVO vo) throws Exception { 
    	return erpEmpDAO.selectErpEmp(vo);
    }

    /**
	 * ERP_EMP 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return ERP_EMP 목록
	 * @exception Exception
	 */
    public List<?> selectErpEmpList(ErpEmpVO searchVO) throws Exception {
        return erpEmpDAO.selectErpEmpList(searchVO);
    }

    /**
	 * ERP_EMP 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return ERP_EMP 총 갯수
	 * @exception
	 */
    public int selectErpEmpListTotCnt(ErpEmpVO searchVO) {
		return erpEmpDAO.selectErpEmpListTotCnt(searchVO);
	}

	@Override
	public ErpEmpVO login(ErpEmpVO vo) throws Exception {
		// 1. 입력한 비밀번호를 암호화한다.
		String enpassword = EgovFileScrty.encryptPassword(vo.getErpEmployeePassword(), vo.getErpEmployeeId());
		vo.setErpEmployeePassword(enpassword);
    	
    	// 2. 아이디와 암호화된 비밀번호가 DB와 일치하는지 확인한다.
    	ErpEmpVO erpEmpVO = erpEmpDAO.selectErpEmp(vo);
    	
    	// 3. 결과를 리턴한다.
    	if (erpEmpVO != null && !erpEmpVO.getErpEmployeeName().equals("")) {
    		return erpEmpVO;
    	}else {
    		erpEmpVO = new ErpEmpVO();
    	}
    		
    	return erpEmpVO;
	}
    
}

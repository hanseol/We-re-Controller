package mes.mac.service;

import java.util.LinkedHashMap;
import java.util.List;

import mes.member.service.MacDateResultVO;

/**
 * @Class Name : MacService.java
 * @Description : Mac Business class
 * @Modification Information
 *
 * @author hanseol
 * @since 20210708
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface MacService {
	
	/**
	 * MAC을 등록한다.
	 * @param vo - 등록할 정보가 담긴 MacVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertMac(MacVO vo) throws Exception;
    
    /**
	 * MAC을 수정한다.
	 * @param vo - 수정할 정보가 담긴 MacVO
	 * @return void형
	 * @exception Exception
	 */
    void updateMac(LinkedHashMap vo) throws Exception;
    
    /**
	 * MAC을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 MacVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteMac(LinkedHashMap vo) throws Exception;
    
    /**
	 * MAC을 조회한다.
	 * @param vo - 조회할 정보가 담긴 MacVO
	 * @return 조회한 MAC
	 * @exception Exception
	 */
    MacVO selectMac(MacVO vo) throws Exception;
    
    /**
	 * MAC 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return MAC 목록
	 * @exception Exception
	 */
    List<MacVO> selectMacList(MacVO searchVO) throws Exception;
    
    List<MacDateResultVO> selectLeftDate() throws Exception;
    
}

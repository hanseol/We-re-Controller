package mes.pro.proc.service;

import java.util.List;
import mes.pro.proc.service.ProProcessDefaultVO;
import mes.pro.proc.service.ProProcessVO;

/**
 * @Class Name : ProProcessService.java
 * @Description : ProProcess Business class
 * @Modification Information
 *
 * @author dahee
 * @since 20210707
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface ProProcessService {
	
	/**
	 * PRO_PROCESS을 등록한다.
	 * @param vo - 등록할 정보가 담긴 ProProcessVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertProProcess(ProProcessVO vo) throws Exception;
    
    /**
	 * PRO_PROCESS을 수정한다.
	 * @param vo - 수정할 정보가 담긴 ProProcessVO
	 * @return void형
	 * @exception Exception
	 */
    void updateProProcess(ProProcessVO vo) throws Exception;
    
    /**
	 * PRO_PROCESS을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ProProcessVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteProProcess(ProProcessVO vo) throws Exception;
    
    /**
	 * PRO_PROCESS을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ProProcessVO
	 * @return 조회한 PRO_PROCESS
	 * @exception Exception
	 */
    ProProcessVO selectProProcess(ProProcessVO vo) throws Exception;
    
    /**
	 * PRO_PROCESS 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return PRO_PROCESS 목록
	 * @exception Exception
	 */
    List selectProProcessList(ProProcessDefaultVO searchVO) throws Exception;
    
    /**
	 * PRO_PROCESS 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return PRO_PROCESS 총 갯수
	 * @exception
	 */
    int selectProProcessListTotCnt(ProProcessDefaultVO searchVO);
    
}

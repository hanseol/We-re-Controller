package mes.pro.proc.service;

import java.util.List;
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
    List selectProProcessList(ProProcessVO searchVO) throws Exception;
    
    /**
	 * PRO_PROCESS 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return PRO_PROCESS 총 갯수
	 * @exception
	 */
    int selectProProcessListTotCnt(ProProcessVO searchVO);
    
    //공정흐름관리 페이지에 넘겨줄 공정이름 조회
    List<ProProcessVO> selectProProcessName();
    
    //공정흐름관리시 필요한 지시코드 조회
    List<String> selectProOrderDetailCode(ProProcessVO vo);
    
    //선택된 지시에 사용되도록 설정된 자재 LOT 조회
    List<ProProcessVO> selectMatrLot(ProProcessVO vo);
    
    //생산 공정 시작 시간 & 공정 작업 상태 업데이트
    void updateStartTime(ProProcessVO vo) throws Exception;

    String selectProdName(ProProcessVO vo);
    
}

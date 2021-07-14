package mes.pro.proc.service.impl;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import mes.pro.proc.service.ProProcessVO;

/**
 * @Class Name : ProProcessMapper.java
 * @Description : ProProcess Mapper Class
 * @Modification Information
 *
 * @author dahee
 * @since 20210707
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Mapper("proProcessMapper")
public interface ProProcessMapper {

	/**
	 * PRO_PROCESS을 등록한다.
	 * @param vo - 등록할 정보가 담긴 ProProcessVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public void insertProProcess(ProProcessVO vo) throws Exception;

    /**
	 * PRO_PROCESS을 수정한다.
	 * @param vo - 수정할 정보가 담긴 ProProcessVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateProProcess(ProProcessVO vo) throws Exception;

    /**
	 * PRO_PROCESS을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ProProcessVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteProProcess(ProProcessVO vo) throws Exception;

    /**
	 * PRO_PROCESS을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ProProcessVO
	 * @return 조회한 PRO_PROCESS
	 * @exception Exception
	 */
    public ProProcessVO selectProProcess(ProProcessVO vo) throws Exception;

    /**
	 * PRO_PROCESS 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return PRO_PROCESS 목록
	 * @exception Exception
	 */
    public List<?> selectProProcessList(ProProcessVO searchVO) throws Exception;

    /**
	 * PRO_PROCESS 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return PRO_PROCESS 총 갯수
	 * @exception
	 */
    public int selectProProcessListTotCnt(ProProcessVO searchVO);
    
    //공정흐름관리 페이지에 넘겨줄 공정이름 조회
    public List<ProProcessVO> selectProProcessName();
    
    //공정흐름관리 시 필요한 지시코드 조회
    public List<String> selectProOrderDetailCode(ProProcessVO vo);
    
    //선택된 지시에 사용되도록 설정된 자재 LOT 조회
    public List<ProProcessVO> selectMatrLot(ProProcessVO vo);
    
    //생산 공정 상태 업데이트
    public void updateStartTime(ProProcessVO vo) throws Exception;
}

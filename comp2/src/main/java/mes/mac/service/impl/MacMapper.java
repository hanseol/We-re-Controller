package mes.mac.service.impl;

import java.util.LinkedHashMap;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import mes.mac.service.MacVO;
import mes.member.service.MacDateResultVO;
import mes.pro.proc.service.ProProcessVO;

/**
 * @Class Name : MacMapper.java
 * @Description : Mac Mapper Class
 * @Modification Information
 *
 * @author hanseol
 * @since 20210708
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Mapper("macMapper")
public interface MacMapper {

	/**
	 * MAC을 등록한다.
	 * @param vo - 등록할 정보가 담긴 MacVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public void insertMac(MacVO vo) throws Exception;

    /**
	 * MAC을 수정한다.
	 * @param vo - 수정할 정보가 담긴 MacVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateMac(LinkedHashMap vo) throws Exception;

    /**
	 * MAC을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 MacVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteMac(LinkedHashMap vo) throws Exception;

    /**
	 * MAC을 조회한다.
	 * @param vo - 조회할 정보가 담긴 MacVO
	 * @return 조회한 MAC
	 * @exception Exception
	 */
    public MacVO selectMac(MacVO vo) throws Exception;

    /**
	 * MAC 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return MAC 목록
	 * @exception Exception
	 */
    public List<MacVO> selectMacList(MacVO searchVO) throws Exception;


    //점검일 D-DAY
    public List<MacDateResultVO> selectLeftDate() throws Exception;

    //다음 설비코드 가져오기
    public String selectNextMacCode() throws Exception;
    //설비 규격
    public List<String> selectMacSize();
    //설비 용도
    public List<String> selectMacUsePurpose();
    //설비 이름
    public List<String> selectMacModel();
}

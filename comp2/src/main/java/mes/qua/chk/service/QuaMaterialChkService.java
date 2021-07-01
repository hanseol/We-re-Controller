package mes.qua.chk.service;

import java.util.List;

/**
 * @Class Name : QuaMaterialChkService.java
 * @Description : QuaMaterialChk Business class
 * @Modification Information
 *
 * @author sungwon
 * @since 20210629
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface QuaMaterialChkService {
	
	/**
	 * QUA_MATERIAL_CHK을 등록한다.
	 * @param vo - 등록할 정보가 담긴 QuaMaterialChkVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertQuaMaterialChk(QuaMaterialChkVO vo) throws Exception;
    
    /**
	 * QUA_MATERIAL_CHK을 수정한다.
	 * @param vo - 수정할 정보가 담긴 QuaMaterialChkVO
	 * @return void형
	 * @exception Exception
	 */
    void updateQuaMaterialChk(QuaMaterialChkVO vo) throws Exception;
    
    /**
	 * QUA_MATERIAL_CHK을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 QuaMaterialChkVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteQuaMaterialChk(QuaMaterialChkVO vo) throws Exception;
    
    /**
	 * QUA_MATERIAL_CHK을 조회한다.
	 * @param vo - 조회할 정보가 담긴 QuaMaterialChkVO
	 * @return 조회한 QUA_MATERIAL_CHK
	 * @exception Exception
	 */
    QuaMaterialChkVO selectQuaMaterialChk(QuaMaterialChkVO vo) throws Exception;
    
    /**
	 * QUA_MATERIAL_CHK 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return QUA_MATERIAL_CHK 목록
	 * @exception Exception
	 */
    List selectQuaMaterialChkList(QuaMaterialChkVO searchVO) throws Exception;
    
    /**
	 * QUA_MATERIAL_CHK 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return QUA_MATERIAL_CHK 총 갯수
	 * @exception
	 */
    int selectQuaMaterialChkListTotCnt(QuaMaterialChkVO searchVO);
    
}

package mes.qua.chk.service;

import java.util.LinkedHashMap;
import java.util.List;

import mes.main.service.GridDataVO;

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
public interface QuaChkService {
	
    //등록
    String insertQuaChk(GridDataVO vo) throws Exception;
    
    //자재입출고로 등록
    String insertQuaChkMatIn(LinkedHashMap vo) throws Exception;
    
    //수정
    int updateQuaChk(LinkedHashMap vo) throws Exception;
    
    //삭제
    int deleteQuaChk(LinkedHashMap vo) throws Exception;
    
    //전체 리스트 출력
    List<?> selectQuaChkList(QuaChkVO searchVO) throws Exception;
    
    //합격 리스트 조회
    List<?> selectQuaChkPassList(QuaChkVO searchVO) throws Exception;
    
    //자재불량 모달
    List<?> searchMatFltyCodeList(QuaChkVO searchVO) throws Exception;
    //자재합격량불량량 모달
    List<?> searchMatFltyCodeQtyList(QuaChkVO searchVO) throws Exception;
}

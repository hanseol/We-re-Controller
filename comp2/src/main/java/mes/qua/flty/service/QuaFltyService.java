package mes.qua.flty.service;

import java.util.LinkedHashMap;
import java.util.List;

import mes.main.service.GridDataVO;

/**
 * @Class Name : QuaMaterialFltyService.java
 * @Description : QuaMaterialFlty Business class
 * @Modification Information
 *
 * @author sungwon
 * @since 20210629
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface QuaFltyService {
	
    //등록
    String insertQuaFlty(GridDataVO vo) throws Exception;
    
    //자재입출고로 등록
    String insertQuaFltyMatIn(LinkedHashMap vo) throws Exception;
    
    //수정
    void updateQuaFlty(LinkedHashMap vo) throws Exception;
    
    //삭제
    void deleteQuaFlty(LinkedHashMap vo) throws Exception;
    
    //검사완료 목록 중 불량이 있는 리스트 출력
    List<?> selectQuaFltyList(QuaFltyVO searchVO) throws Exception;
    
    //불량 리스트 조회
    List<?> selectQuaFltyDetailList(QuaFltyVO searchVO) throws Exception;
}

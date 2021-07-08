package mes.qua.chk.service;

import java.util.LinkedHashMap;
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
public interface QuaChkService {
	
    //등록
    String insertQuaChk(LinkedHashMap vo) throws Exception;
    
    //수정
    void updateQuaChk(LinkedHashMap vo) throws Exception;
    
    //삭제
    void deleteQuaChk(LinkedHashMap vo) throws Exception;
    
    //전체 리스트 출력
    List<?> selectQuaChkList(QuaChkVO searchVO) throws Exception;

}

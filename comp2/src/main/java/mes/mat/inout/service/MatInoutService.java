package mes.mat.inout.service;

import java.util.LinkedHashMap;
import java.util.List;

/**
 * @Class Name : MatInoutService.java
 * @Description : MatInout Business class
 * @Modification Information
 *
 * @author sungwon
 * @since 20210625
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface MatInoutService {
	
	//등록
	String insertMatInout(LinkedHashMap vo) throws Exception;
    
	//수정
    void updateMatInout(LinkedHashMap vo) throws Exception;
    
    //삭제
    void deleteMatInout(LinkedHashMap vo) throws Exception;
    
    //전체  리스트 출력
    List<?> selectMatInoutList(MatInoutVO searchVO) throws Exception;
    
    //모달 자재코드 리스트 출력
    List<?> searchMaterialCodeList(MatInoutVO searchVO) throws Exception;
    
    //모달 입고업체 리스트 출력
    List<?> searchVendorCodeList(MatInoutVO searchVO) throws Exception;
    
    
}

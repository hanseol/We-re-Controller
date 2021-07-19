package mes.mat.inout.service;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

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
	Map<String, Object> insertMatInout(LinkedHashMap vo) throws Exception;
    
	//수정
    void updateMatInout(LinkedHashMap vo) throws Exception;
    
    //삭제
    void deleteMatInout(LinkedHashMap vo) throws Exception;
    
    //입고  리스트 출력
    List<?> selectMatInoutList(MatInoutVO searchVO) throws Exception;
    
    //출고 리스트 출력
    List<?> selectMatInoutPassList(MatInoutVO searchVO) throws Exception;
    
    //모달 자재코드 리스트 출력
    List<?> searchMaterialCodeList(MatInoutVO searchVO) throws Exception;
    
    //모달 입고업체 리스트 출력
    List<?> searchVendorCodeList(MatInoutVO searchVO) throws Exception;
    
    //모달 자재LOT_NO 리스트 출력
    List<?> searchMaterialLotList(MatInoutVO searchVO) throws Exception;
    
    //모달 자재LOT_NO 리스트 출력
    List<?> searchMaterialLotSecondList(MatInoutVO searchVO) throws Exception;
}

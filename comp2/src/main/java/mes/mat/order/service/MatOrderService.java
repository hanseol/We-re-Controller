package mes.mat.order.service;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;


/**
 * @Class Name : ErpMaterialOrderService.java
 * @Description : ErpMaterialOrder Business class
 * @Modification Information
 *
 * @author sungwon
 * @since 20210628
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface MatOrderService {
	
	//등록
	Map<String, Object> insertMatOrder(LinkedHashMap vo) throws Exception;
    
	//수정
    void updateMatOrder(LinkedHashMap vo) throws Exception;
    
    //삭제
    void deleteMatOrder(LinkedHashMap vo) throws Exception;
    
    //전체  리스트 출력
    List<?> selectMatOrderList(MatOrderVO searchVO) throws Exception;
    
    //발주코드 모달
    List<?> searchMatOrderCodeList(MatOrderVO searchVO) throws Exception;
    
    //순수발주코드 모달
    List<?> searchMatOrderCodePureList(MatOrderVO searchVO) throws Exception;
    
    //불량이 있는 발주코드 모달
    List<?> searchMatOrderCodeFltyList(MatOrderVO searchVO) throws Exception;
    
    
}

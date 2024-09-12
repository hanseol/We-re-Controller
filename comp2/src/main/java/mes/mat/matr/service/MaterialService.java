package mes.mat.matr.service;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * @Class Name : ComMaterialService.java
 * @Description : ComMaterial Business class
 * @Modification Information
 *
 * @author sungwon
 * @since 20210629
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface MaterialService {
	
	//등록
	Map<String, Object> insertMaterial(LinkedHashMap vo) throws Exception;
    
    //수정
    void updateMaterial(LinkedHashMap vo) throws Exception;
    
    //삭제
    void deleteMaterial(LinkedHashMap vo) throws Exception;
	
    //전체 리스트 출력
	List<?> selectMaterialList(MaterialVO searchVO) throws Exception;
}

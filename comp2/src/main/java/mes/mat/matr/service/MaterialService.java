package mes.mat.matr.service;

import java.util.LinkedHashMap;
import java.util.List;

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
	String insertMaterial(LinkedHashMap vo) throws Exception;
    
    //수정
    int updateMaterial(LinkedHashMap vo) throws Exception;
    
    //삭제
    int deleteMaterial(LinkedHashMap vo) throws Exception;
	
    //전체 리스트 출력
	List<?> selectMaterialList(MaterialVO searchVO) throws Exception;
}

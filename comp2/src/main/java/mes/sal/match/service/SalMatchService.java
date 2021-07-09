package mes.sal.match.service;

import java.util.LinkedHashMap;
import java.util.List;

import mes.sal.match.service.SalMatchVO;

/**
 * @Class Name : SalMatchService.java
 * @Description : SalMatch Business class
 * @Modification Information
 *
 * @author hk
 * @since 2021-06-29
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface SalMatchService {
	
    //조회
    SalMatchVO selectSalMatch(SalMatchVO vo) throws Exception;
    List selectSalMatchList(SalMatchVO searchVO) throws Exception;
    
    //CRUD
    String insertSalMatch(LinkedHashMap vo) throws Exception;
    void updateSalMatch(LinkedHashMap vo) throws Exception;
    void deleteSalMatch(LinkedHashMap vo) throws Exception;
    
//---------------------- 모달 -----------------------
    
    //완제품 LOT_NO
	List<?> searchProductLotNoList(SalMatchVO searchVO) throws Exception;
	int searchProductLotNoListTotCnt(SalMatchVO searchVO);
	
	//제품코드
	List<?> searchProductList(SalMatchVO searchVO) throws Exception;
	int searchProductListTotCnt(SalMatchVO searchVO);
	
}

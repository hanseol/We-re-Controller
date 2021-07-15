package mes.sal.inout.service;

import java.util.LinkedHashMap;
import java.util.List;

/**
 * @Class Name : SalInoutService.java
 * @Description : SalInout Business class
 * @Modification Information
 *
 * @author hk
 * @since 2021-06-28
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface SalInoutService {

	SalInoutVO selectSalInout(SalInoutVO vo) throws Exception;

    //주문 목록 조회 페이지    
    List selectSalInoutList(SalInoutVO searchVO) throws Exception;
    

    //입출고 조회 페이지
    List selectSalProductInoutList(SalInoutVO searchVO) throws Exception;
    int selectSalProductInoutListTotCnt(SalInoutVO searchVO);
    
    //입출고 관리 페이지
    String insertSalInout(LinkedHashMap vo) throws Exception;    
    void updateSalInout(LinkedHashMap vo) throws Exception;
    void deleteSalInout(LinkedHashMap vo) throws Exception;
    
    //반품 조회 페이지
    List selectSalReturnList(SalInoutVO vo) throws Exception;
    
    //반품 관리 페이지
    String insertSalReturn(LinkedHashMap vo) throws Exception;
    void updateSalReturn(LinkedHashMap vo) throws Exception;
    void deleteSalReturn(LinkedHashMap vo) throws Exception;
    
    
    //모달 : 제품코드 조회
    List<?> searchProductList(SalInoutVO searchVO) throws Exception;
    int searchProductListTotCnt(SalInoutVO searchVO);
    
    //모달 : 고객코드 조회
    List<?> searchCustomerList(SalInoutVO searchVO) throws Exception;
    int searchCustomerListTotCnt(SalInoutVO searchVO);
    
    //모달 : 완제품 LOT_NO 조회
	List<?> searchProductLotNoList(SalInoutVO searchVO) throws Exception;
	int searchProductLotNoListTotCnt(SalInoutVO searchVO);
	
	//모달 : 출고시 완제품 LOT_NO 조회
	List<?> searchModProductLotNoList(SalInoutVO searchVO) throws Exception;
	int searchModProductLotNoListTotCnt(SalInoutVO searchVO);


	//모달 : 생산 지시 디테일 코드 조회
	List<?> searchProductCodeList(SalInoutVO searchVO) throws Exception;
	int searchProductCodeListTotCnt(SalInoutVO searchVO);
	
	//모달 : 전표번호 조회(반품페이지)
	List<?> searchInoutStatement(SalInoutVO searchVO) throws Exception;
	int searchInoutStatementListTotCnt(SalInoutVO searchVO);

    
    
}

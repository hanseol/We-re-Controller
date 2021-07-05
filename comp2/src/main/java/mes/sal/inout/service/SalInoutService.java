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
	
	/**
	 * SAL_INOUT을 등록한다.
	 * @param vo - 등록할 정보가 담긴 SalInoutVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertSalInout(LinkedHashMap vo) throws Exception;
    
    /**
	 * SAL_INOUT을 수정한다.
	 * @param vo - 수정할 정보가 담긴 SalInoutVO
	 * @return void형
	 * @exception Exception
	 */
    void updateSalInout(LinkedHashMap vo) throws Exception;
    
    /**
	 * SAL_INOUT을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 SalInoutVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteSalInout(LinkedHashMap vo) throws Exception;
    
    /**
	 * SAL_INOUT을 조회한다.
	 * @param vo - 조회할 정보가 담긴 SalInoutVO
	 * @return 조회한 SAL_INOUT
	 * @exception Exception
	 */
    SalInoutVO selectSalInout(SalInoutVO vo) throws Exception;
    
    /**
	 * SAL_INOUT 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return SAL_INOUT 목록
	 * @exception Exception
	 */
    List selectSalInoutList(SalInoutVO searchVO) throws Exception;
    
    /**
	 * SAL_INOUT 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return SAL_INOUT 총 갯수
	 * @exception
	 */

  //입출고 조회 페이지
    List selectSalProductInoutList(SalInoutVO searchVO) throws Exception;
    int selectSalProductInoutListTotCnt(SalInoutVO searchVO);

    
    
    //모달 : 제품코드 조회
    List<?> searchProductList(SalInoutVO searchVO) throws Exception;
    int searchProductListTotCnt(SalInoutVO searchVO);
    
    //모달 : 고객코드 조회
    List<?> searchCustomerList(SalInoutVO searchVO) throws Exception;
    int searchCustomerListTotCnt(SalInoutVO searchVO);
    
    //모달 : 완제품 LOT_NO 조회
	List<?> searchProductLotNoList(SalInoutVO searchVO) throws Exception;
	int searchProductLotNoListTotCnt(SalInoutVO searchVO);


	//모달 : 생산 지시 디테일 코드 조회
	List<?> searchProductCodeList(SalInoutVO searchVO) throws Exception;
	int searchProductCodeListTotCnt(SalInoutVO searchVO);
    
    
    
}

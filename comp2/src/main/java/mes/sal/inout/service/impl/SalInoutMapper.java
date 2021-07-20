package mes.sal.inout.service.impl;

import java.util.LinkedHashMap;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import mes.sal.inout.service.SalInoutVO;

/**
 * @Class Name : SalInoutMapper.java
 * @Description : SalInout Mapper Class
 * @Modification Information
 *
 * @author hk
 * @since 2021-06-28
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Mapper("salInoutMapper")
public interface SalInoutMapper {

	/**
	 * SAL_INOUT을 등록한다.
	 * @param vo - 등록할 정보가 담긴 SalInoutVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public void insertSalInout(LinkedHashMap vo) throws Exception;

    /**
	 * SAL_INOUT을 수정한다.
	 * @param vo - 수정할 정보가 담긴 SalInoutVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateSalInout(LinkedHashMap vo) throws Exception;

    /**
	 * SAL_INOUT을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 SalInoutVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteSalInout(LinkedHashMap vo) throws Exception;

    /**
	 * SAL_INOUT을 조회한다.
	 * @param vo - 조회할 정보가 담긴 SalInoutVO
	 * @return 조회한 SAL_INOUT
	 * @exception Exception
	 */
    public SalInoutVO selectSalInout(SalInoutVO vo) throws Exception;

    /**
	 * SAL_INOUT 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return SAL_INOUT 목록
	 * @exception Exception
	 */
    public List<?> selectSalInoutList(SalInoutVO searchVO) throws Exception;

    /**
	 * SAL_INOUT 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return SAL_INOUT 총 갯수
	 * @exception
	 */
    public int selectSalInoutListTotCnt(SalInoutVO searchVO);

    //완제품입출고목록 조회
    public List<?> selectSalProductInOutList(SalInoutVO searchVO) throws Exception;
    
    //완제품입고목록 조회
    public List<?> selectSalProductInList(SalInoutVO searchVO) throws Exception;
    public int selectSalProductInListTotCnt(SalInoutVO searchVO);
    
    //완제품출고목록 조회
    public List selectSalProductOutList(SalInoutVO searchVO) throws Exception;
    
	//입고 완제품 목록 조회
	
    
    //반품목록 조회
    public List selectSalReturnList(SalInoutVO vo) throws Exception;
    
    //반품목록 관리
    public void insertSalReturn(LinkedHashMap vo) throws Exception;
    public void updateSalReturn(LinkedHashMap vo) throws Exception;
    public void deleteSalReturn(LinkedHashMap vo) throws Exception;
    
    
    //모달 : 제품코드 조회
  	public List<?> searchProductList(SalInoutVO searchVO) throws Exception;
  	public int searchProductListTotCnt(SalInoutVO searchVO);
  	
  	//모달 : 고객코드 조회
  	public List<?> searchCustomerList(SalInoutVO searchVO) throws Exception;
  	public int searchCustomerListTotCnt(SalInoutVO searchVO);
  	
  	//모달 : 완제품 LOT_NO 조회
	public List<?> searchProductLotNoList(SalInoutVO searchVO) throws Exception;
	public int searchProductLotNoListTotCnt(SalInoutVO searchVO);
	
	//모달 : 출고시 완제품 LOT_NO 조회
	public List<?> searchModProductLotNoList(SalInoutVO searchVO) throws Exception;
	public int searchModProductLotNoListTotCnt(SalInoutVO searchVO);

	//모달 : 생산지시디테일코드 조회
	public List<?> searchProductCodeList(SalInoutVO searchVO) throws Exception;
	public int searchProductCodeListTotCnt(SalInoutVO searchVO);

	//모달 : 전표번호(반품) 조회
	public List<?> searchInoutStatementList(SalInoutVO searchVO) throws Exception;
	public int searchInoutStatementListTotCnt(SalInoutVO searchVO);
	
	//모달 : 제품주문서 목록 조회
	public List<?> searchOrderList(SalInoutVO searchVO) throws Exception;

}

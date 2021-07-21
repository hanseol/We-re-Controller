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

   

    public SalInoutVO selectSalInout(SalInoutVO vo) throws Exception;

    //제품주문서 조회
    public List<?> selectSalInoutList(SalInoutVO searchVO) throws Exception;
    public int selectSalInoutListTotCnt(SalInoutVO searchVO);

    //완제품입출고목록 조회
    public List<?> selectSalProductInOutList(SalInoutVO searchVO) throws Exception;
    
    //완제품입고목록 조회
    public List<?> selectSalProductInList(SalInoutVO searchVO) throws Exception;
    public int selectSalProductInListTotCnt(SalInoutVO searchVO);
    
    //입고 CRUD
    public void insertSalIn(LinkedHashMap vo) throws Exception;
    public void updateSalIn(LinkedHashMap vo) throws Exception;
    public void deleteSalIn(LinkedHashMap vo) throws Exception;
    
	//출고 CRUD
    public List<?> selectSalProductOutList(SalInoutVO searchVO) throws Exception;
    public void insertSalOut(LinkedHashMap vo) throws Exception;
    public void updateSalOut(LinkedHashMap vo) throws Exception;
    public void deleteSalOut(LinkedHashMap vo) throws Exception;
    
    //출고 세부 내역
    public List selectSalOutDetail(SalInoutVO searchVO) throws Exception;
    public void updateSalModify(LinkedHashMap vo) throws Exception;
    
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

package mes.sal.inout.service.impl;

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
    public void insertSalInout(SalInoutVO vo) throws Exception;

    /**
	 * SAL_INOUT을 수정한다.
	 * @param vo - 수정할 정보가 담긴 SalInoutVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateSalInout(SalInoutVO vo) throws Exception;

    /**
	 * SAL_INOUT을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 SalInoutVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteSalInout(SalInoutVO vo) throws Exception;

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

    //완제품 웅엥
    public List<?> selectSalProductInoutList(SalInoutVO searchVO) throws Exception;

    
    
    //모달 : 제품코드 조회
  	public List<?> searchProductList(SalInoutVO searchVO) throws Exception;
  	public int searchProductListTotCnt(SalInoutVO searchVO);
  	
  	//모달 : 고객코드 조회
  	public List<?> searchCustomerList(SalInoutVO searchVO) throws Exception;
  	public int searchCustomerListTotCnt(SalInoutVO searchVO);
  	
  	//모달 : 완제품 LOT_NO 조회
	public List<?> searchProductLotNoList(SalInoutVO searchVO) throws Exception;
	public int searchProductLotNoListTotCnt(SalInoutVO searchVO);

}

package mes.sal.match.service.impl;

import java.util.LinkedHashMap;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import mes.sal.match.service.SalMatchVO;

/**
 * @Class Name : SalMatchMapper.java
 * @Description : SalMatch Mapper Class
 * @Modification Information
 *
 * @author hk
 * @since 2021-06-29
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Mapper("salMatchMapper")
public interface SalMatchMapper {

	//View
    public SalMatchVO selectSalMatch(SalMatchVO vo) throws Exception;
    public List<?> selectSalMatchList(SalMatchVO searchVO) throws Exception;

	//CRUD
    public void insertSalMatch(LinkedHashMap vo) throws Exception;
    public void updateSalMatch(LinkedHashMap vo) throws Exception;
    public void deleteSalMatch(LinkedHashMap vo) throws Exception;
    
    
    //모달
	public List<?> searchProductMatchList(SalMatchVO searchVO) throws Exception;
	public int searchProductMatchListTotCnt(SalMatchVO searchVO);
	public List<?> searchProductList(SalMatchVO searchVO) throws Exception;
	public int searchProductListTotCnt(SalMatchVO searchVO);

    
	//
	public void updateSalInout(LinkedHashMap vo) throws Exception;
    

}

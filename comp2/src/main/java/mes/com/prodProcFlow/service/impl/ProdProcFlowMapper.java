package mes.com.prodProcFlow.service.impl;

import java.util.LinkedHashMap;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import mes.com.prodProcFlow.service.ProdProcFlowVO;

/**
 * @Class Name : MatrDtaListMapper.java
 * @Description : MatrDtaList Mapper Class
 * @Modification Information
 *
 * @author 경윤수
 * @since 2021-06-30
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Mapper("prodProcFlowMapper")
public interface ProdProcFlowMapper {
	
	// 마스터테이블 조회
    public List<?> selectComProdList(ProdProcFlowVO searchVO) throws Exception;

    //디테일 코드 조회
    public List<?> selectProdProcList(ProdProcFlowVO searchVO) throws Exception;
    
    //공정전개
    public List<?> selectProcFlowList(ProdProcFlowVO searchVO) throws Exception;
    
    //모달
    public List<?> selectProcFlowModal(ProdProcFlowVO searchVO) throws Exception;

    //디테일코드 삽입
    public void insertProcFlow(LinkedHashMap searchVO) throws Exception;
    
    //디테일코드 삭제
    public void deleteProcFlow(LinkedHashMap searchVO) throws Exception;
    
    //디테일코드 수정
    public void updateProcFlow(LinkedHashMap searchVO) throws Exception;

}

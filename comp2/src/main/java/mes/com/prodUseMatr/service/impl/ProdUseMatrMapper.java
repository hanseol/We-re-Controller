package mes.com.prodUseMatr.service.impl;

import java.util.LinkedHashMap;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import mes.com.prodUseMatr.service.ProdUseMatrVO;

/**
 * @Class Name : ComCodeMapper.java
 * @Description : ComCode Mapper Class
 * @Modification Information
 *
 * @author 경윤수
 * @since 2021-06-30
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Mapper("prodUseMatrMapper")
public interface ProdUseMatrMapper {

	// 마스터테이블 조회
	public List<?> selectProudUseHead(ProdUseMatrVO searchVO) throws Exception;
	
	// 디테일코드 조회
    public List<?> selectProdUseMatrList(ProdUseMatrVO searchVO) throws Exception;

    // 모달(제품)
    public List<?> selectBomModal(ProdUseMatrVO searchVO) throws Exception;
    
    // 모달(공정)
    public List<?> selectProcessModal(ProdUseMatrVO searchVO) throws Exception;
    
    //디테일코드 삽입
    public void insertProdUseMatrDetail(LinkedHashMap searchVO) throws Exception;
    
    //디테일코드 삭제
    public void deleteProdUseMatrDetail(LinkedHashMap searchVO) throws Exception;
    
    //디테일코드 수정
    public void updateProdUseMatrDetail(LinkedHashMap searchVO) throws Exception;
    
}

package mes.com.prodUseMatr.service;

import java.util.LinkedHashMap;
import java.util.List;

/**
 * @Class Name : ProdUseMatrService.java
 * @Description : ProdUseMatr Business class
 * @Modification Information
 *
 * @author 경윤수
 * @since 2021-06-30
 * @version 1.0
 * @see
 * 
 *      Copyright (C) All right reserved.
 */
public interface ProdUseMatrService {

	//마스터테이블 조회
	List selectProudUseHead(ProdUseMatrVO searchVO) throws Exception;
	
    //디테일 코드 조회
	List selectProdUseMatrList(ProdUseMatrVO searchVO) throws Exception;

	//모달
	List selectBomModal(ProdUseMatrVO searchVO) throws Exception;
	
	//모달(공정)
	List selectProcessModal(ProdUseMatrVO searchVO) throws Exception;
	
	//디테일코드 삽입
	String insertProdUseMatrDetail(LinkedHashMap searchVO) throws Exception;
	
	//디테일코드 수정
	void updateProdUseMatrDetail(LinkedHashMap searchVO) throws Exception;

	//디테일코드 삭제
	void deleteProdUseMatrDetail(LinkedHashMap searchVO) throws Exception;

}

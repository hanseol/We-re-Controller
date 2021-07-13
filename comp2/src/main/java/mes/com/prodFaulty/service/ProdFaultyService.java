package mes.com.prodFaulty.service;

import java.util.LinkedHashMap;
import java.util.List;



public interface ProdFaultyService {

	// 마스터 테이블 조회
	List selectProdFaulty(ProdFaultyVO searchVO) throws Exception;
	
	//공정흐름 삽입
	String insertProdFaulty(LinkedHashMap searchVO) throws Exception;
	
	//공정흐름 수정
	void updateProdFault(LinkedHashMap searchVO) throws Exception;

	//공정흐름 삭제
	void deleteProdFault(LinkedHashMap searchVO) throws Exception;
	
}

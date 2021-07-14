package mes.com.matrFaulty.service;

import java.util.LinkedHashMap;
import java.util.List;



public interface MatrFaultyService {

	// 마스터 테이블 조회
	List selectMatrFaulty(MatrFaultyVO searchVO) throws Exception;
	
	//공정흐름 삽입
	String insertMatrFaulty(LinkedHashMap searchVO) throws Exception;
	
	//공정흐름 수정
	void deleteMatrFaulty(LinkedHashMap searchVO) throws Exception;

	//공정흐름 삭제
	void updateMatrFaulty(LinkedHashMap searchVO) throws Exception;
	
}

package mes.com.prodFaulty.service;

import java.util.List;



public interface ProdFaultyService {

	// 마스터 테이블 조회
	List selectProdFaulty(ProdFaultyVO searchVO) throws Exception;
	
}

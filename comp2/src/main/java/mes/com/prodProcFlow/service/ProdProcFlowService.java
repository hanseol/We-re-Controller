package mes.com.prodProcFlow.service;

import java.util.List;

public interface ProdProcFlowService {

	// 마스터 테이블 조회
		List selectComProdList(ProdProcFlowVO searchVO) throws Exception;

		// 디테일 코드 조회
		List selectProdProcList(ProdProcFlowVO searchVO) throws Exception;
		
		// 공정전개
		List selectProcFlowList(ProdProcFlowVO searchVO) throws Exception;
}

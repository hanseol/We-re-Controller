package mes.com.prodProcFlow.service;

import java.util.LinkedHashMap;
import java.util.List;

public interface ProdProcFlowService {

	// 마스터 테이블 조회
		List selectComProdList(ProdProcFlowVO searchVO) throws Exception;

		// 디테일 코드 조회
		List selectProdProcList(ProdProcFlowVO searchVO) throws Exception;
		
		// 공정전개
		List selectProcFlowList(ProdProcFlowVO searchVO) throws Exception;
		
		// 모달
		List selectProcFlowModal(ProdProcFlowVO searchVO) throws Exception;
		
		//공정흐름 삽입
		String insertProcFlow(LinkedHashMap searchVO) throws Exception;
		
		//공정흐름 수정
		void updateProcFlow(LinkedHashMap searchVO) throws Exception;

		//공정흐름 삭제
		void deleteProcFlow(LinkedHashMap searchVO) throws Exception;
}

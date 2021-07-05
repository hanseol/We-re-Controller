package mes.com.matrDtaList.service;

import java.util.List;

public interface MatrDtaListService {

	// 마스터 테이블 조회
		List selectMatrDtaList(MatrDtaListVO searchVO) throws Exception;

		// 디테일 코드 조회
		List selectMatrDtaListDetailList(MatrDtaListVO searchVO) throws Exception;
}

package mes.com.matrDtaList.service;

import java.util.List;

public interface MatrDtaListService {

		
		public List<MatrDtaListVO> selectMatrDtaList();

		
		public MatrDtaListVO selectMatrDtaListDetailList(MatrDtaListVO vo);
}

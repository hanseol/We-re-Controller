package mes.com.comModal.service;

import java.util.List;

import mes.com.comCode.service.ComCodeVO;

public interface ComModalService {

	// 모달 불량코드
	List modalProdFault(ComCodeVO searchVO) throws Exception;

}

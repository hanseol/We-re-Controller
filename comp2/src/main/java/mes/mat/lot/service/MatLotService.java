package mes.mat.lot.service;

import java.util.LinkedHashMap;
import java.util.List;

import mes.mat.inout.service.MatInoutVO;


public interface MatLotService {
	
	
	//등록
	String insertMatLot(LinkedHashMap vo) throws Exception;
    
    //수정
    void updateMatLot(LinkedHashMap vo) throws Exception;
    void updateMatInout(LinkedHashMap vo) throws Exception;
    //삭제
    void deleteMatLot(LinkedHashMap vo) throws Exception;
	
    //전체 리스트 출력
	List<?> selectMatLotList(MatLotVO searchVO) throws Exception;
	    
    //모달 자재코드 리스트 출력
    List<?> searchMaterialCodeList(MatLotVO searchVO) throws Exception;
    
    //모달 입고업체 리스트 출력
    List<?> searchVendorCodeList(MatLotVO searchVO) throws Exception;
    
    
}

package mes.mat.lot.service;

import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.stereotype.Service;

import mes.main.map.ResultMapVO;
import mes.mat.inout.service.MatInoutVO;

@Service("matLotService")
public interface MatLotService {
	
	//전체 리스트 출력
	List<?> selectMatLotList(ResultMapVO searchVO) throws Exception;
	
	//행 카운트
    int selectMatLotListTotCnt(ResultMapVO searchVO);
	
	//등록
	String insertMatLot(LinkedHashMap vo) throws Exception;
    
    //수정
    void updateMatLot(LinkedHashMap vo) throws Exception;
    
    //삭제
    void deleteMatLot(LinkedHashMap vo) throws Exception;
	
    
}

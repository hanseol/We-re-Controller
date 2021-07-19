package mes.mat.lot.service.impl;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import mes.mat.lot.service.MatLotVO;

@Mapper("matLotMapper")
public interface MatLotMapper {
	
	
	//등록
    public Map<String, Object> insertMatLot(LinkedHashMap vo) throws Exception;

    //수정
    public void updateMatLot(LinkedHashMap vo) throws Exception;
    
    //입출고 추가
    public void updateMatInout(LinkedHashMap vo) throws Exception;
    
    //삭제
    public void deleteMatLot(LinkedHashMap vo) throws Exception;

    //전체 리스트 출력
	public List<?> selectMatLotList(MatLotVO searchVO) throws Exception;		

    //모달 자재코드 리스트
    public List<?> searchMaterialCodeList(MatLotVO searchVO) throws Exception;
    
    //모달 입고업체 리스트
    public List<?> searchVendorCodeList(MatLotVO searchVO) throws Exception;

}

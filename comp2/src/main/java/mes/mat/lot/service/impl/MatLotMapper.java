package mes.mat.lot.service.impl;

import java.util.LinkedHashMap;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import mes.main.map.ResultMapVO;

@Mapper("matLotMapper")
public interface MatLotMapper {
	
	//전체 리스트 출력
	public List<?> selectMatLotList(ResultMapVO searchVO) throws Exception;
		
	//행 카운트
	public int selectMatLotListTotCnt(ResultMapVO searchVO) throws Exception;
	
	//등록
    public void insertMatLot(LinkedHashMap vo) throws Exception;

    //수정
    public void updateMatLot(LinkedHashMap vo) throws Exception;

    //삭제
    public void deleteMatLot(LinkedHashMap vo) throws Exception;

	
}

package mes.com.matrFaulty.service.impl;

import java.util.LinkedHashMap;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import mes.com.matrFaulty.service.MatrFaultyVO;


@Mapper("matrFaultyMapper")
public interface MatrFaultyMapper {

	// 마스터테이블 조회
    public List<?> selectMatrFaulty(MatrFaultyVO searchVO) throws Exception;
    
    //디테일코드 삽입
    public void insertMatrFaulty(LinkedHashMap searchVO) throws Exception;
    
    //디테일코드 삭제
    public void deleteMatrFaulty(LinkedHashMap searchVO) throws Exception;
    
    //디테일코드 수정
    public void updateMatrFaulty(LinkedHashMap searchVO) throws Exception;
}
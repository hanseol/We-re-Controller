package mes.com.prodFaulty.service.impl;

import java.util.LinkedHashMap;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import mes.com.prodFaulty.service.ProdFaultyVO;


@Mapper("prodFaultyMapper")
public interface ProdFaultyMapper {

	// 마스터테이블 조회
    public List<?> selectProdFaulty(ProdFaultyVO searchVO) throws Exception;
    
    //디테일코드 삽입
    public void insertProdFaulty(LinkedHashMap searchVO) throws Exception;
    
    //디테일코드 삭제
    public void deleteProdFault(LinkedHashMap searchVO) throws Exception;
    
    //디테일코드 수정
    public void updateProdFault(LinkedHashMap searchVO) throws Exception;
}
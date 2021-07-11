package mes.com.prodFaulty.service.impl;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import mes.com.prodFaulty.service.ProdFaultyVO;


@Mapper("prodFaultyMapper")
public interface ProdFaultyMapper {

	// 마스터테이블 조회
    public List<?> selectProdFaulty(ProdFaultyVO searchVO) throws Exception;
    
}
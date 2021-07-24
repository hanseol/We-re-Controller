package mes.com.matrDtaList.service.impl;

import java.util.LinkedHashMap;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import mes.com.matrDtaList.service.MatrDtaListVO;

/**
 * @Class Name : MatrDtaListMapper.java
 * @Description : MatrDtaList Mapper Class
 * @Modification Information
 *
 * @author 경윤수
 * @since 2021-06-30
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Mapper("matrDtaListMapper")
public interface MatrDtaListMapper {
	
	// 마스터테이블 조회
    public List<?> selectMatrDtaList(MatrDtaListVO searchVO) throws Exception;

    //디테일 코드 조회
    public List<?> selectMatrDtaListDetailList(MatrDtaListVO searchVO) throws Exception;

	public void updateMatrDtaListDetail(LinkedHashMap linkedHashMap);


}

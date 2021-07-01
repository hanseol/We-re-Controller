package mes.com.comCode.service.impl;

import java.util.LinkedHashMap;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import mes.com.comCode.service.ComCodeVO;

/**
 * @Class Name : ComCodeMapper.java
 * @Description : ComCode Mapper Class
 * @Modification Information
 *
 * @author 경윤수
 * @since 2021-06-30
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Mapper("comCodeMapper")
public interface ComCodeMapper {

	// 마스터테이블 조회
    public List<?> selectComCodeList(ComCodeVO searchVO) throws Exception;
    
    //디테일 코드 조회
    public List<?> selectComCodeDetailList(ComCodeVO searchVO) throws Exception;
    
    //디테일코드 삽입
    public void insertComCodeDetail(LinkedHashMap vo) throws Exception;
    
    //디테일코드 삭제
    public void deleteComCodeDetail(LinkedHashMap vo) throws Exception;
    
    //디테일코드 수정
    public void updateComCodeDetail(LinkedHashMap vo) throws Exception;

}

package mes.qua.flty.service.impl;

import java.util.LinkedHashMap;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import mes.qua.flty.service.QuaFltyVO;

/**
 * @Class Name : QuaMaterialFltyMapper.java
 * @Description : QuaMaterialFlty Mapper Class
 * @Modification Information
 *
 * @author sungwon
 * @since 20210629
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Mapper("quaFltyMapper")
public interface QuaFltyMapper {

	//등록
    public String insertQuaFlty(LinkedHashMap vo) throws Exception;
    
    //자재입출고로 등록
    public void insertQuaFltyMatIn(LinkedHashMap vo) throws Exception;
    
    //수정
    public void updateQuaFlty(LinkedHashMap vo) throws Exception;

    //삭제
    public void deleteQuaFlty(LinkedHashMap vo) throws Exception;


    //검사완료 목록 중 불량이 있는 리스트 조회
    public List<?> selectQuaFltyList(QuaFltyVO searchVO) throws Exception;

    //불량 리스트 조회
    public List<?> selectQuaFltyDetailList(QuaFltyVO searchVO) throws Exception;
}

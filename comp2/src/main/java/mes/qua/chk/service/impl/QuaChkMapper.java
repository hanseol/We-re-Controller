package mes.qua.chk.service.impl;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import mes.qua.chk.service.QuaChkVO;

/**
 * @Class Name : QuaMaterialChkMapper.java
 * @Description : QuaMaterialChk Mapper Class
 * @Modification Information
 *
 * @author sungwon
 * @since 20210629
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Mapper("quaChkMapper")
public interface QuaChkMapper {

	//등록
    public void insertQuaChk(LinkedHashMap vo) throws Exception;
    
    //자재입출고로 등록
    public void insertQuaChkMatIn(LinkedHashMap vo) throws Exception;
    
    //자재불량으로 등록
    public void insertMatFlty(LinkedHashMap vo) throws Exception;
    
    //수정
    public void updateQuaChk(LinkedHashMap vo) throws Exception;

    //삭제
    public void deleteQuaChk(LinkedHashMap vo) throws Exception;

    //전체리스트 조회
    public List<?> selectQuaChkList(QuaChkVO searchVO) throws Exception;

    //합격 리스트 조회
    public List<?> selectQuaChkPassList(QuaChkVO searchVO) throws Exception;
    
    //자재불량 모달
    public List<?> searchMatFltyCodeList(QuaChkVO searchVO) throws Exception;
    
    //자재합격량불량량 모달
    public List<?> searchMatFltyCodeQtyList(QuaChkVO searchVO) throws Exception;
}

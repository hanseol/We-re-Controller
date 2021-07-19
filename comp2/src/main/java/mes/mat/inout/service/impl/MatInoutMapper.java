package mes.mat.inout.service.impl;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import mes.mat.inout.service.MatInoutVO;

/**
 * @Class Name : MatInoutMapper.java
 * @Description : MatInout Mapper Class
 * @Modification Information
 *
 * @author sungwon
 * @since 20210625
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Mapper("matInoutMapper")
public interface MatInoutMapper {

	//등록
    public Map<String, Object> insertMatInout(LinkedHashMap vo) throws Exception;
    
    //수정
    public void updateMatInout(LinkedHashMap vo) throws Exception;

    //삭제
    public void deleteMatInout(LinkedHashMap vo) throws Exception;
    
    //입고 리스트
    public List<?> selectMatInoutList(MatInoutVO searchVO) throws Exception;
    
    //출고 리스트
    public List<?> selectMatInoutPassList(MatInoutVO searchVO) throws Exception;
    
    
    //모달 자재코드 리스트
    public List<?> searchMaterialCodeList(MatInoutVO searchVO) throws Exception;
    
    //모달 입고업체 리스트
    public List<?> searchVendorCodeList(MatInoutVO searchVO) throws Exception;
    
    //모달 자재LOT_NO 리스트 
    public List<?> searchMaterialLotList(MatInoutVO searchVO) throws Exception;

    
}

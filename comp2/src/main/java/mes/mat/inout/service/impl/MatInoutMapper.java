package mes.mat.inout.service.impl;

import java.util.LinkedHashMap;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import mes.mat.inout.service.MatInoutVO;
import mes.pro.plan.service.ProPlanVO;

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
    public void insertMatInout(LinkedHashMap vo) throws Exception;

    //수정
    public void updateMatInout(LinkedHashMap vo) throws Exception;

    //삭제
    public void deleteMatInout(LinkedHashMap vo) throws Exception;

    //행 카운트
    public int selectMatInoutListTotCnt(MatInoutVO searchVO);
    
    //입출고조회페이지 리스트 조회
    public List<?> selectMatInoutList(MatInoutVO searchVO) throws Exception;
    
    /*
     * 목록 조회
     * 모달창에서 사용
     * 김한설
     * */
    public List<?> searchFormList(MatInoutVO searchVO) throws Exception;
    /*
     * 총 갯수 조회
     * 모달창에서 사용
     * 김한설
     * */
    public int searchVendorFormListCnt(MatInoutVO vo);
    
}

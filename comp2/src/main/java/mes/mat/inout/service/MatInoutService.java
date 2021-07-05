package mes.mat.inout.service;

import java.util.LinkedHashMap;
import java.util.List;

/**
 * @Class Name : MatInoutService.java
 * @Description : MatInout Business class
 * @Modification Information
 *
 * @author sungwon
 * @since 20210625
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface MatInoutService {
	
	/**
	 * MAT_INOUT을 등록한다.
	 * @param vo - 등록할 정보가 담긴 MatInoutVO
	 * @return 등록 결과
	 * @exception Exception
	 */
	String insertMatInout(LinkedHashMap vo) throws Exception;
    
    /**
	 * MAT_INOUT을 수정한다.
	 * @param vo - 수정할 정보가 담긴 MatInoutVO
	 * @return void형
	 * @exception Exception
	 */
    void updateMatInout(LinkedHashMap vo) throws Exception;
    
    /**
	 * MAT_INOUT을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 MatInoutVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteMatInout(LinkedHashMap vo) throws Exception;
    
    /**
	 * MAT_INOUT을 조회한다.
	 * @param vo - 조회할 정보가 담긴 MatInoutVO
	 * @return 조회한 MAT_INOUT
	 * @exception Exception
	 */
    //행 카운트
    int selectMatInoutListTotCnt(MatInoutVO searchVO);
    
    //전체  리스트 출력
    List<?> selectMatInoutList(MatInoutVO searchVO) throws Exception;
    
    //모달 자재코드 리스트 출력
    List<?> searchMaterialCodeList(MatInoutVO searchVO) throws Exception;
    
    //모달 입고업체 리스트 출력
    List<?> searchVendorCodeList(MatInoutVO searchVO) throws Exception;
    
    
}

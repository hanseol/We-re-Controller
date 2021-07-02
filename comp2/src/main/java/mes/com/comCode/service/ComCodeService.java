package mes.com.comCode.service;

import java.util.LinkedHashMap;
import java.util.List;

/**
 * @Class Name : ComCodeService.java
 * @Description : ComCode Business class
 * @Modification Information
 *
 * @author 경윤수
 * @since 2021-06-30
 * @version 1.0
 * @see
 * 
 *      Copyright (C) All right reserved.
 */
public interface ComCodeService {
	
	// 마스터 테이블 조회
	List selectComCodeList(ComCodeVO searchVO) throws Exception;

	// 디테일 코드 조회
	List selectComCodeDetailList(ComCodeVO searchVO) throws Exception;

	//디테일코드 삽입
	String insertComCodeDetail(LinkedHashMap searchVO) throws Exception;
	
	//디테일코드 수정
	void updateComCodeDetail(LinkedHashMap searchVO) throws Exception;

	//디테일코드 삭제
	void deleteComCodeDetail(LinkedHashMap searchVO) throws Exception;
}

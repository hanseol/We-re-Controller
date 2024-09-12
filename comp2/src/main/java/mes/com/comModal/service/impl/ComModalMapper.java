package mes.com.comModal.service.impl;

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

@Mapper("comModalMapper")
public interface ComModalMapper {

	// 모달 불량코드
	public List<?> modalProdFault(ComCodeVO searchVO) throws Exception;
    
}

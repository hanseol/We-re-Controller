package mes.com.comCode.service.impl;

import java.util.LinkedHashMap;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import mes.com.comCode.service.ComCodeService;
import mes.com.comCode.service.ComCodeVO;

/**
 * @Class Name : ComCodeServiceImpl.java
 * @Description : ComCode Business Implement class
 * @Modification Information
 *
 * @author 경윤수
 * @since 2021-06-30
 * @version 1.0
 * @see
 * 
 *      Copyright (C) All right reserved.
 */

@Service("comCodeService")
public class ComCodeServiceImpl extends EgovAbstractServiceImpl implements ComCodeService {

	private static final Logger LOGGER = LoggerFactory.getLogger(ComCodeServiceImpl.class);

	@Resource(name = "comCodeMapper")
	private ComCodeMapper comCodeDAO;

	public List<?> selectComCodeList(ComCodeVO searchVO) throws Exception {
		return comCodeDAO.selectComCodeList(searchVO);
	}

	// 디테일 코드 조회
	public List<?> selectComCodeDetailList(ComCodeVO searchVO) throws Exception {
		return comCodeDAO.selectComCodeDetailList(searchVO);
	}

	// 디테일코드 수정
	public void updateComCodeDetail(LinkedHashMap vo) throws Exception {
		comCodeDAO.updateComCodeDetail(vo);
	}

	// 디테일코드 삭제
	public void deleteComCodeDetail(LinkedHashMap vo) throws Exception {
		comCodeDAO.deleteComCodeDetail(vo);
	}

	// 디테일코드 삽입
	public String insertComCodeDetail(LinkedHashMap vo) throws Exception {

		comCodeDAO.insertComCodeDetail(vo);

		return null;
	}

}

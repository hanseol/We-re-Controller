package mes.com.matrDtaList.service.impl;

import java.util.LinkedHashMap;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import mes.com.matrDtaList.service.MatrDtaListService;
import mes.com.matrDtaList.service.MatrDtaListVO;

/**
 * @Class Name : MatrDtaListServiceImpl.java
 * @Description : MatrDtaList Business Implement class
 * @Modification Information
 *
 * @author 경윤수
 * @since 2021-06-30
 * @version 1.0
 * @see
 * 
 *      Copyright (C) All right reserved.
 */

@Service("matrDtaListService")
public class MatrDtaListServiceImpl extends EgovAbstractServiceImpl implements MatrDtaListService {

	private static final Logger LOGGER = LoggerFactory.getLogger(MatrDtaListServiceImpl.class);

	@Resource(name = "matrDtaListMapper")
	private MatrDtaListMapper matrDtaListDAO;
	
	// 마스터테이블 조회
	public List<?> selectMatrDtaList(MatrDtaListVO searchVO) throws Exception {
		return matrDtaListDAO.selectMatrDtaList(searchVO);
	}

	// 디테일 코드 조회
	public List<?> selectMatrDtaListDetailList(MatrDtaListVO searchVO) throws Exception {
		return matrDtaListDAO.selectMatrDtaListDetailList(searchVO);
	}

	// 안전재고 수정 (김한설)
	@Override
	public void updateMatrDtaListDetail(LinkedHashMap linkedHashMap) {
		matrDtaListDAO.updateMatrDtaListDetail(linkedHashMap);
	}

}

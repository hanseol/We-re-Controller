package mes.com.prodUseMatr.service.impl;

import java.util.LinkedHashMap;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import mes.com.prodUseMatr.service.ProdUseMatrService;
import mes.com.prodUseMatr.service.ProdUseMatrVO;

/**
 * @Class Name : ProdUseMatrServiceImpl.java
 * @Description : ProdUseMatr Business Implement class
 * @Modification Information
 *
 * @author 경윤수
 * @since 2021-06-30
 * @version 1.0
 * @see
 * 
 *      Copyright (C) All right reserved.
 */

@Service("prodUseMatrService")
public class ProdUseMatrServiceImpl extends EgovAbstractServiceImpl implements ProdUseMatrService {

	private static final Logger LOGGER = LoggerFactory.getLogger(ProdUseMatrServiceImpl.class);

	@Resource(name = "prodUseMatrMapper")
	private ProdUseMatrMapper prodUseMatrDAO;

	// 디테일 코드 조회
	public List<?> selectProudUseHead(ProdUseMatrVO searchVO) throws Exception {
		return prodUseMatrDAO.selectProudUseHead(searchVO);
	}
	
	// 디테일 코드 조회
	public List<?> selectProdUseMatrList(ProdUseMatrVO searchVO) throws Exception {
		return prodUseMatrDAO.selectProdUseMatrList(searchVO);
	}

	// 모달
	public List<?> selectBomModal(ProdUseMatrVO searchVO) throws Exception {
		return prodUseMatrDAO.selectBomModal(searchVO);
	}
	
	// 모달(공정)
	public List<?> selectProcessModal(ProdUseMatrVO searchVO) throws Exception {
		return prodUseMatrDAO.selectProcessModal(searchVO);
	}
	
	// 디테일코드 수정
	public void updateProdUseMatrDetail(LinkedHashMap searchVO) throws Exception {
		prodUseMatrDAO.updateProdUseMatrDetail(searchVO);
	}

	// 디테일코드 삭제
	public void deleteProdUseMatrDetail(LinkedHashMap searchVO) throws Exception {
		prodUseMatrDAO.deleteProdUseMatrDetail(searchVO);
	}

	// 디테일코드 삽입
	public String insertProdUseMatrDetail(LinkedHashMap searchVO) throws Exception {

		prodUseMatrDAO.insertProdUseMatrDetail(searchVO);

		return null;
	}

}

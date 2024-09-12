package mes.com.prodProcFlow.service.impl;

import java.util.LinkedHashMap;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import mes.com.prodProcFlow.service.ProdProcFlowService;
import mes.com.prodProcFlow.service.ProdProcFlowVO;

/**
 * @Class Name : ProdProcFlowServiceImpl.java
 * @Description : ProdProcFlow Business Implement class
 * @Modification Information
 *
 * @author 경윤수
 * @since 2021-06-30
 * @version 1.0
 * @see
 * 
 *      Copyright (C) All right reserved.
 */

@Service("prodProcFlowService")
public class ProdProcFlowServiceImpl extends EgovAbstractServiceImpl implements ProdProcFlowService {

	private static final Logger LOGGER = LoggerFactory.getLogger(ProdProcFlowServiceImpl.class);

	@Resource(name = "prodProcFlowMapper")
	private ProdProcFlowMapper prodProcFlowDAO;

	// 마스터테이블 조회
	public List<?> selectComProdList(ProdProcFlowVO searchVO) throws Exception {
		return prodProcFlowDAO.selectComProdList(searchVO);
	}

	// 디테일 코드 조회
	public List<?> selectProdProcList(ProdProcFlowVO searchVO) throws Exception {
		return prodProcFlowDAO.selectProdProcList(searchVO);
	}

	// 공정전개
	public List<?> selectProcFlowList(ProdProcFlowVO searchVO) throws Exception {
		return prodProcFlowDAO.selectProcFlowList(searchVO);
	}
	
	// 모달
	public List<?> selectProcFlowModal(ProdProcFlowVO searchVO) throws Exception {
		return prodProcFlowDAO.selectProcFlowModal(searchVO);
	}
	
	// 공정흐름 수정
	public void updateProcFlow(LinkedHashMap searchVO) throws Exception {
		prodProcFlowDAO.updateProcFlow(searchVO);
	}

	// 공정흐름 삭제
	public void deleteProcFlow(LinkedHashMap searchVO) throws Exception {
		prodProcFlowDAO.deleteProcFlow(searchVO);
	}

	// 공정흐름 삽입
	public String insertProcFlow(LinkedHashMap searchVO) throws Exception {

		prodProcFlowDAO.insertProcFlow(searchVO);

		return null;
	}

}

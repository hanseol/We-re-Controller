package mes.com.prodFaulty.service.impl;

import java.util.LinkedHashMap;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import mes.com.prodFaulty.service.ProdFaultyService;
import mes.com.prodFaulty.service.ProdFaultyVO;


@Service("prodFaultyService")
public class ProdFaultyServiceImpl extends EgovAbstractServiceImpl implements ProdFaultyService {

	private static final Logger LOGGER = LoggerFactory.getLogger(ProdFaultyServiceImpl.class);

	@Resource(name = "prodFaultyMapper")
	private ProdFaultyMapper prodFaultyDAO;
	
	// 마스터테이블 조회
	public List<?> selectProdFaulty(ProdFaultyVO searchVO) throws Exception {
		return prodFaultyDAO.selectProdFaulty(searchVO);
	}
	
	// 공정흐름 수정
	public void updateProdFault(LinkedHashMap searchVO) throws Exception {
		prodFaultyDAO.updateProdFault(searchVO);
	}

	// 공정흐름 삭제
	public void deleteProdFault(LinkedHashMap searchVO) throws Exception {
		prodFaultyDAO.deleteProdFault(searchVO);
	}

	// 공정흐름 삽입
	public String insertProdFaulty(LinkedHashMap searchVO) throws Exception {

		prodFaultyDAO.insertProdFaulty(searchVO);

		return null;
	}
	
}

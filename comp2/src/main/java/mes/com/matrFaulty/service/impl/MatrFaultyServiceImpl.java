package mes.com.matrFaulty.service.impl;

import java.util.LinkedHashMap;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import mes.com.matrFaulty.service.MatrFaultyService;
import mes.com.matrFaulty.service.MatrFaultyVO;


@Service("matrFaultyService")
public class MatrFaultyServiceImpl extends EgovAbstractServiceImpl implements MatrFaultyService {

	private static final Logger LOGGER = LoggerFactory.getLogger(MatrFaultyServiceImpl.class);

	@Resource(name = "matrFaultyMapper")
	private MatrFaultyMapper matrFaultyDAO;
	
	// 마스터테이블 조회
	public List<?> selectMatrFaulty(MatrFaultyVO searchVO) throws Exception {
		return matrFaultyDAO.selectMatrFaulty(searchVO);
	}
	
	// 공정흐름 수정
	public void updateMatrFaulty(LinkedHashMap searchVO) throws Exception {
		matrFaultyDAO.updateMatrFaulty(searchVO);
	}

	// 공정흐름 삭제
	public void deleteMatrFaulty(LinkedHashMap searchVO) throws Exception {
		matrFaultyDAO.deleteMatrFaulty(searchVO);
	}

	// 공정흐름 삽입
	public String insertMatrFaulty(LinkedHashMap searchVO) throws Exception {

		matrFaultyDAO.insertMatrFaulty(searchVO);

		return null;
	}
	
}

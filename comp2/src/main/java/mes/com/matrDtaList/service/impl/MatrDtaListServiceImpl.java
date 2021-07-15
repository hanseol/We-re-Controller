package mes.com.matrDtaList.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
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
	
	@Autowired
	MatrDtaListMapper mapper;
	
	@Override
	public List<MatrDtaListVO> selectMatrDtaList() {
		return mapper.selectMatrDtaList();
	}

	@Override
	public MatrDtaListVO selectMatrDtaListDetailList(MatrDtaListVO vo) {
		return mapper.selectMatrDtaListDetailList(vo);
	}

}

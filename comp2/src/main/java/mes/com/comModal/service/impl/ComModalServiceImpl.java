package mes.com.comModal.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import mes.com.comCode.service.ComCodeVO;
import mes.com.comModal.service.ComModalService;


@Service("comModalService")
public class ComModalServiceImpl extends EgovAbstractServiceImpl implements ComModalService {

	private static final Logger LOGGER = LoggerFactory.getLogger(ComModalServiceImpl.class);

	@Resource(name = "comModalMapper")
	private ComModalMapper comModalDAO;

	// 모달 불량코드
	public List<?> modalProdFault(ComCodeVO searchVO) throws Exception {
		return comModalDAO.modalProdFault(searchVO);
	}

}

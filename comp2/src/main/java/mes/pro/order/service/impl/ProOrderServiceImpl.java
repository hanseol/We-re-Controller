package mes.pro.order.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import mes.pro.order.service.ProOrderService;
import mes.main.service.SearchVO;
import mes.pro.order.service.ProOrderDefaultVO;
import mes.pro.order.service.ProOrderVO;
/**
 * @Class Name : ProOrderServiceImpl.java
 * @Description : ProOrder Business Implement class
 * @Modification Information
 *
 * @author dahee
 * @since 20210628
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("proOrderService")
public class ProOrderServiceImpl extends EgovAbstractServiceImpl implements
        ProOrderService {
        
    private static final Logger LOGGER = LoggerFactory.getLogger(ProOrderServiceImpl.class);

    @Resource(name="proOrderMapper")
    private ProOrderMapper proOrderDAO;
    
    //@Resource(name="proOrderDAO")
    //private ProOrderDAO proOrderDAO;
    
    /** ID Generation */
    //@Resource(name="{egovProOrderIdGnrService}")    
    //private EgovIdGnrService egovIdGnrService;

	/**
	 * PRO_ORDER을 등록한다.
	 * @param vo - 등록할 정보가 담긴 ProOrderVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertProOrder(ProOrderVO vo) throws Exception {
    	LOGGER.debug(vo.toString());
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	//String id = egovIdGnrService.getNextStringId();
    	//vo.setId(id);
    	LOGGER.debug(vo.toString());
    	
    	proOrderDAO.insertProOrder(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return null;
    }

    /**
	 * PRO_ORDER을 수정한다.
	 * @param vo - 수정할 정보가 담긴 ProOrderVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateProOrder(ProOrderVO vo) throws Exception {
        proOrderDAO.updateProOrder(vo);
    }

    /**
	 * PRO_ORDER을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ProOrderVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteProOrder(ProOrderVO vo) throws Exception {
        proOrderDAO.deleteProOrder(vo);
    }

    /**
	 * PRO_ORDER을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ProOrderVO
	 * @return 조회한 PRO_ORDER
	 * @exception Exception
	 */
    public ProOrderVO selectProOrder(ProOrderVO vo) throws Exception {
        ProOrderVO resultVO = proOrderDAO.selectProOrder(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * PRO_ORDER 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return PRO_ORDER 목록
	 * @exception Exception
	 */
    public List<?> selectProOrderList(SearchVO searchVO) throws Exception {
        return proOrderDAO.selectProOrderList(searchVO);
    }

    /**
	 * PRO_ORDER 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return PRO_ORDER 총 갯수
	 * @exception
	 */
    public int selectProOrderListTotCnt(SearchVO searchVO) {
		return proOrderDAO.selectProOrderListTotCnt(searchVO);
	}
    
}

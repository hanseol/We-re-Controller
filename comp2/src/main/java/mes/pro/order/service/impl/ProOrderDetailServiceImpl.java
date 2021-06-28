package mes.pro.order.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import mes.pro.order.service.ProOrderDetailService;
import mes.pro.order.service.ProOrderDetailDefaultVO;
import mes.pro.order.service.ProOrderDetailVO;
/**
 * @Class Name : ProOrderDetailServiceImpl.java
 * @Description : ProOrderDetail Business Implement class
 * @Modification Information
 *
 * @author dahee
 * @since 20210628
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("proOrderDetailService")
public class ProOrderDetailServiceImpl extends EgovAbstractServiceImpl implements
        ProOrderDetailService {
        
    private static final Logger LOGGER = LoggerFactory.getLogger(ProOrderDetailServiceImpl.class);

    @Resource(name="proOrderDetailMapper")
    private ProOrderDetailMapper proOrderDetailDAO;
    
    //@Resource(name="proOrderDetailDAO")
    //private ProOrderDetailDAO proOrderDetailDAO;
    
    /** ID Generation */
    //@Resource(name="{egovProOrderDetailIdGnrService}")    
    //private EgovIdGnrService egovIdGnrService;

	/**
	 * PRO_ORDER_DETAIL을 등록한다.
	 * @param vo - 등록할 정보가 담긴 ProOrderDetailVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertProOrderDetail(ProOrderDetailVO vo) throws Exception {
    	LOGGER.debug(vo.toString());
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	//String id = egovIdGnrService.getNextStringId();
    	//vo.setId(id);
    	LOGGER.debug(vo.toString());
    	
    	proOrderDetailDAO.insertProOrderDetail(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return null;
    }

    /**
	 * PRO_ORDER_DETAIL을 수정한다.
	 * @param vo - 수정할 정보가 담긴 ProOrderDetailVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateProOrderDetail(ProOrderDetailVO vo) throws Exception {
        proOrderDetailDAO.updateProOrderDetail(vo);
    }

    /**
	 * PRO_ORDER_DETAIL을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ProOrderDetailVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteProOrderDetail(ProOrderDetailVO vo) throws Exception {
        proOrderDetailDAO.deleteProOrderDetail(vo);
    }

    /**
	 * PRO_ORDER_DETAIL을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ProOrderDetailVO
	 * @return 조회한 PRO_ORDER_DETAIL
	 * @exception Exception
	 */
    public ProOrderDetailVO selectProOrderDetail(ProOrderDetailVO vo) throws Exception {
        ProOrderDetailVO resultVO = proOrderDetailDAO.selectProOrderDetail(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * PRO_ORDER_DETAIL 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return PRO_ORDER_DETAIL 목록
	 * @exception Exception
	 */
    public List<?> selectProOrderDetailList(ProOrderDetailDefaultVO searchVO) throws Exception {
        return proOrderDetailDAO.selectProOrderDetailList(searchVO);
    }

    /**
	 * PRO_ORDER_DETAIL 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return PRO_ORDER_DETAIL 총 갯수
	 * @exception
	 */
    public int selectProOrderDetailListTotCnt(ProOrderDetailDefaultVO searchVO) {
		return proOrderDetailDAO.selectProOrderDetailListTotCnt(searchVO);
	}
    
}

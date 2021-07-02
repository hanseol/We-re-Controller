package mes.sal.inout.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import mes.sal.inout.service.SalInoutService;
import mes.sal.inout.service.SalInoutVO;
import mes.sal.inout.service.impl.SalInoutMapper;
/**
 * @Class Name : SalInoutServiceImpl.java
 * @Description : SalInout Business Implement class
 * @Modification Information
 *
 * @author hk
 * @since 2021-06-28
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("salInoutService")
public class SalInoutServiceImpl extends EgovAbstractServiceImpl implements
        SalInoutService {
        
    private static final Logger LOGGER = LoggerFactory.getLogger(SalInoutServiceImpl.class);

    @Resource(name="salInoutMapper")
    private SalInoutMapper salInoutDAO;
    
    //@Resource(name="salInoutDAO")
    //private SalInoutDAO salInoutDAO;
    
    /** ID Generation */
    //@Resource(name="{egovSalInoutIdGnrService}")    
    //private EgovIdGnrService egovIdGnrService;

	/**
	 * SAL_INOUT을 등록한다.
	 * @param vo - 등록할 정보가 담긴 SalInoutVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertSalInout(SalInoutVO vo) throws Exception {
    	LOGGER.debug(vo.toString());
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	//String id = egovIdGnrService.getNextStringId();
    	//vo.setId(id);
    	LOGGER.debug(vo.toString());
    	
    	salInoutDAO.insertSalInout(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return null;
    }

    /**
	 * SAL_INOUT을 수정한다.
	 * @param vo - 수정할 정보가 담긴 SalInoutVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateSalInout(SalInoutVO vo) throws Exception {
        salInoutDAO.updateSalInout(vo);
    }

    /**
	 * SAL_INOUT을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 SalInoutVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteSalInout(SalInoutVO vo) throws Exception {
        salInoutDAO.deleteSalInout(vo);
    }

    /**
	 * SAL_INOUT을 조회한다.
	 * @param vo - 조회할 정보가 담긴 SalInoutVO
	 * @return 조회한 SAL_INOUT
	 * @exception Exception
	 */
    public SalInoutVO selectSalInout(SalInoutVO vo) throws Exception {
        SalInoutVO resultVO = salInoutDAO.selectSalInout(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * SAL_INOUT 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return SAL_INOUT 목록
	 * @exception Exception
	 */
    public List<?> selectSalInoutList(SalInoutVO searchVO) throws Exception {
        return salInoutDAO.selectSalInoutList(searchVO);
    }

    /**
	 * SAL_INOUT 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return SAL_INOUT 총 갯수
	 * @exception
	 */
    
    //입출고목록 조회
	public List<?> selectSalProductInoutList(SalInoutVO searchVO) throws Exception {
		return salInoutDAO.selectSalProductInoutList(searchVO);
	}
    
    
    public int selectSalInoutListTotCnt(SalInoutVO searchVO) {
		return salInoutDAO.selectSalInoutListTotCnt(searchVO);
	}

    //모달 : 제품코드 조회
	@Override
	public List<?> searchProductList(SalInoutVO searchVO) throws Exception {
		return salInoutDAO.searchProductList(searchVO);
	}

	@Override
	public int searchProductListTotCnt(SalInoutVO searchVO) {
		return salInoutDAO.searchProductListTotCnt(searchVO);
	}

	//모달 : 고객코드 조회
	@Override
	public List<?> searchCustomerList(SalInoutVO searchVO) throws Exception {
		return salInoutDAO.searchCustomerList(searchVO);
	}

	@Override
	public int searchCustomerListTotCnt(SalInoutVO searchVO) {
		return salInoutDAO.searchCustomerListTotCnt(searchVO);
	}

	//모달 : 완제품 LOT_NO 조회
	@Override
	public List<?> searchProductLotNoList(SalInoutVO searchVO) throws Exception {
		return salInoutDAO.searchProductLotNoList(searchVO);
	}

	@Override
	public int searchProductLotNoListTotCnt(SalInoutVO searchVO) {
		return salInoutDAO.searchProductLotNoListTotCnt(searchVO);
	}

	
}

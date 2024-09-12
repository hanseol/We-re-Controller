package mes.sal.inout.service.impl;

import java.util.LinkedHashMap;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import mes.sal.inout.service.SalInoutService;
import mes.sal.inout.service.SalInoutVO;
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
    
    
    

    //주문 조회
    public SalInoutVO selectSalInout(SalInoutVO vo) throws Exception {
        SalInoutVO resultVO = salInoutDAO.selectSalInout(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

   
    public List<?> selectSalInoutList(SalInoutVO searchVO) throws Exception {
        return salInoutDAO.selectSalInoutList(searchVO);
    }
    

//-----------------------입/출고목록-------------------------    
    
    //입출고목록 조회
    public List<?> selectSalProductInOutList(SalInoutVO searchVO) throws Exception {
    	return salInoutDAO.selectSalProductInOutList(searchVO);
    }
    
    
    //입고목록 조회
	public List<?> selectSalProductInList(SalInoutVO searchVO) throws Exception {
		return salInoutDAO.selectSalProductInList(searchVO);
	}
     
    public int selectSalProductInListTotCnt(SalInoutVO searchVO) {
		return salInoutDAO.selectSalProductInListTotCnt(searchVO);
	}
    
    //출고목록 조회
    public List<?> selectSalProductOutList(SalInoutVO searchVO) throws Exception {
    	return salInoutDAO.selectSalProductOutList(searchVO);
    }
    
    //출고시 세부 LOT_NO 조회
    @Override
	public List selectSalOutDetail(SalInoutVO searchVO) throws Exception {
		return salInoutDAO.selectSalOutDetail(searchVO);
	}
    
    //입고목록 CRUD
    public String insertSalIn(LinkedHashMap vo) throws Exception {
    	LOGGER.debug(vo.toString());
    	LOGGER.debug(vo.toString());
    	
    	salInoutDAO.insertSalIn(vo);
        return null;
    }

    public void updateSalIn(LinkedHashMap vo) throws Exception {
        salInoutDAO.updateSalIn(vo);
    }

    public void deleteSalIn(LinkedHashMap vo) throws Exception {
        salInoutDAO.deleteSalIn(vo);
    }
    
    
    //출고목록 CRUD
    public String insertSalOut(LinkedHashMap vo) throws Exception {
    	LOGGER.debug(vo.toString());
    	LOGGER.debug(vo.toString());
    	
    	salInoutDAO.insertSalOut(vo);
        return null;
    }

    public void updateSalOut(LinkedHashMap vo) throws Exception {
        salInoutDAO.updateSalOut(vo);
    }

    public void deleteSalOut(LinkedHashMap vo) throws Exception {
        salInoutDAO.deleteSalOut(vo);
    }
    
    //출고목록 세부 U
    @Override
	public void updateUnderSal(LinkedHashMap vo) throws Exception {
		salInoutDAO.updateSalModify(vo);
	}
    
//-----------------------------반품------------------------------   
   
    //반품목록 조회
    @Override
	public List selectSalReturnList(SalInoutVO vo) throws Exception {
    	return salInoutDAO.selectSalReturnList(vo);
	}
    
    //반품목록 CRUD
    @Override
	public String insertSalReturn(LinkedHashMap vo) throws Exception {
			LOGGER.debug(vo.toString());
			LOGGER.debug(vo.toString());
			    	
			salInoutDAO.insertSalReturn(vo);
			
			return null;
	}

	@Override
	public void updateSalReturn(LinkedHashMap vo) throws Exception {
		salInoutDAO.updateSalReturn(vo);
	}

	@Override
	public void deleteSalReturn(LinkedHashMap vo) throws Exception {
		salInoutDAO.deleteSalReturn(vo);
	}

    
//--------------------------------모달-----------------------------------
	
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
	
	//모달 : 출고시 완제품 LOT_NO 조회
	@Override
	public List<?> searchModProductLotNoList(SalInoutVO searchVO) throws Exception {
		return salInoutDAO.searchModProductLotNoList(searchVO);
	}

	@Override
	public int searchModProductLotNoListTotCnt(SalInoutVO searchVO) {
		return salInoutDAO.searchModProductLotNoListTotCnt(searchVO);
	}
	
	//모달 : 생산지시디테일코드 조회
	@Override
	public List<?> searchProductCodeList(SalInoutVO searchVO) throws Exception {
		return salInoutDAO.searchProductCodeList(searchVO);
	}

	@Override
	public int searchProductCodeListTotCnt(SalInoutVO searchVO) {
		return salInoutDAO.searchProductCodeListTotCnt(searchVO);
	}

	
	//모달 : 전표번호(x)
	@Override
	public List<?> searchInoutStatement(SalInoutVO searchVO) throws Exception {
		return salInoutDAO.searchInoutStatementList(searchVO);
	}

	@Override
	public int searchInoutStatementListTotCnt(SalInoutVO searchVO) {
		return salInoutDAO.searchInoutStatementListTotCnt(searchVO);
	}

	
	//모달 : 제품주문서 목록 조회 
	@Override
	public List<?> searchOrderList(SalInoutVO searchVO) throws Exception {
		return salInoutDAO.searchOrderList(searchVO);
	}

	//모달 : 반품 가능한 출고 목록 조회
	@Override
	public List<?> searchReturnList(SalInoutVO searchVO) throws Exception {
		return salInoutDAO.searchReturnList(searchVO);
	}


	


	


	
	
}

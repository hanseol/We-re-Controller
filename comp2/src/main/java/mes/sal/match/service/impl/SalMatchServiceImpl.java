package mes.sal.match.service.impl;

import java.util.LinkedHashMap;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import mes.sal.match.service.SalMatchService;
import mes.sal.match.service.SalMatchVO;
/**
 * @Class Name : SalMatchServiceImpl.java
 * @Description : SalMatch Business Implement class
 * @Modification Information
 *
 * @author hk
 * @since 2021-06-29
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("salMatchService")
public class SalMatchServiceImpl extends EgovAbstractServiceImpl implements
        SalMatchService {
        
    private static final Logger LOGGER = LoggerFactory.getLogger(SalMatchServiceImpl.class);

    @Resource(name="salMatchMapper")
    private SalMatchMapper salMatchDAO;
    
    //조회
    public SalMatchVO selectSalMatch(SalMatchVO vo) throws Exception {
        SalMatchVO resultVO = salMatchDAO.selectSalMatch(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    public List<?> selectSalMatchList(SalMatchVO searchVO) throws Exception {
        return salMatchDAO.selectSalMatchList(searchVO);
    }

    
    //관리 CRUD
    public String insertSalMatch(LinkedHashMap vo) throws Exception {
    	LOGGER.debug(vo.toString());
    	LOGGER.debug(vo.toString());
    	
    	salMatchDAO.insertSalMatch(vo);

        return null;
    }

    
    public void updateSalMatch(LinkedHashMap vo) throws Exception {
        salMatchDAO.updateSalMatch(vo);
    }

    
    public void deleteSalMatch(LinkedHashMap vo) throws Exception {
        salMatchDAO.deleteSalMatch(vo);
    }

    
    
//--------------------------모달-----------------------------    
	
    //완제품 LOT_NO
    @Override
	public List<?> searchProductMatchList(SalMatchVO searchVO) throws Exception {		
    	return salMatchDAO.searchProductMatchList(searchVO);
	}

	@Override
	public int searchProductMatchListTotCnt(SalMatchVO searchVO) {
		return salMatchDAO.searchProductMatchListTotCnt(searchVO);
	}
	
	//제품코드
	@Override
	public List<?> searchProductList(SalMatchVO searchVO) throws Exception {
		return salMatchDAO.searchProductList(searchVO);
	}

	@Override
	public int searchProductListTotCnt(SalMatchVO searchVO) {
		return salMatchDAO.searchProductListTotCnt(searchVO);
	}
	
	//
	@Override
	public void updateSalInout(LinkedHashMap vo) throws Exception {
		salMatchDAO.updateSalInout(vo);		
	}
    
}

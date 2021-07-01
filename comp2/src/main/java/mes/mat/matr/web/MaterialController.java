package mes.mat.matr.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.rte.fdl.property.EgovPropertyService;
import mes.mat.matr.service.MaterialService;
import mes.mat.matr.service.MaterialVO;

/**
 * @Class Name : ComMaterialController.java
 * @Description : ComMaterial Controller class
 * @Modification Information
 *
 * @author sungwon
 * @since 20210629
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
public class MaterialController {

    @Resource(name = "comMaterialService")
    private MaterialService service;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	
    /**
	 * COM_MATERIAL 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 ComMaterialDefaultVO
	 * @return "/comMaterial/ComMaterialList"
	 * @exception Exception
	 */
    @RequestMapping(value="/mat/order/readMatMatr")
    @ResponseBody
    public Map<String, Object> comMatr(Model model, 
    		 @ModelAttribute("searchVO") MaterialVO searchVO) throws Exception{

    	int rowSize = 0;
    	List<?> list = new ArrayList<>();
    	
    	//검색조건이 있을 경우
    	if(!searchVO.getSearchKeyword().equals("")) {
    	
    		//mapper 조건에 따라 condition 설정 필요함.
        	//searchVO.setSearchCondition("0");
    		
    		rowSize = service.selectComMaterialListTotCnt(searchVO);
        	searchVO.setLastIndex(rowSize);
        	
        	list = service.selectMatList(searchVO);
        //검색조건이 없을 경우
    	}else {
    		rowSize = service.selectComMaterialListTotCnt(searchVO);
        	searchVO.setLastIndex(rowSize);
        	
        	list = service.selectMatList(searchVO);
    	}
    	
    	Map<String, Object> paging = new HashMap<>();
    	paging.put("page", searchVO.getPageIndex());
    	paging.put("totalCount", rowSize);
    	
    	Map<String,Object> data = new HashMap<>();
    	data.put("contents", list);
    	data.put("pagination", paging);
    	
    	Map<String,Object> map = new HashMap<>();
    	map.put("result", true);
    	map.put("data", data);
        
    	return map;
    }
    
    //뷰페이지만 넘겨준다.
    @RequestMapping(value="/matMatr/matMatrView.do")
    public String selectComMaterialList(@ModelAttribute("searchVO") MaterialVO searchVO, 
    		ModelMap model){
    	
        return "mes/matMatr/matrView.page";
    } 
}

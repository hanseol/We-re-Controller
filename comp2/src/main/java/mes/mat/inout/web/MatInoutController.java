package mes.mat.inout.web;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import mes.mat.inout.service.MatInoutService;
import mes.mat.inout.service.MatInoutVO;

/**
 * @Class Name : MatInoutController.java
 * @Description : MatInout Controller class
 * @Modification Information
 *
 * @author sungwon  
 * @since 20210625
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
public class MatInoutController {

    @Resource(name = "matInoutService")
    private MatInoutService service;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
    
    
    
    @RequestMapping(value="/mat/inout/readMatInoutOrder")
    @ResponseBody
    public Map<String, Object> matOrder(Model model, 
    		 @ModelAttribute("searchVO") MatInoutVO searchVO) throws Exception{

    	int rowSize = 0;
    	List<?> list = new ArrayList<>();
    	
    	//검색조건이 있을 경우
    	if(!searchVO.getSearchKeyword().equals("")) {
    	
    		//mapper 조건에 따라 condition 설정 필요함.
        	searchVO.setSearchCondition("0");
    		
    		rowSize = service.selectMatInoutListTotCnt(searchVO);
        	searchVO.setLastIndex(rowSize);
        	
        	list = service.selectMatInoutList(searchVO);
        //검색조건이 없을 경우
    	}else {
    		rowSize = service.selectMatInoutListTotCnt(searchVO);
        	searchVO.setLastIndex(rowSize);
        	
        	list = service.selectMatInoutList(searchVO);
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
    @RequestMapping(value="/matInout/matrInoutView.do")
    public String selectMatInoutList(@ModelAttribute("searchVO") MatInoutVO searchVO, 
    		ModelMap model) {

        return "mes/matInout/matrInoutView.page";
    } 


    
    

}

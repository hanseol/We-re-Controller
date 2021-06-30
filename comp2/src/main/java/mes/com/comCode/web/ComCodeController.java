package mes.com.comCode.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.rte.fdl.property.EgovPropertyService;
import mes.board.service.BoardVO;
import mes.com.comCode.service.ComCodeService;
import mes.com.comCode.service.ComCodeVO;
import mes.main.service.GridDataVO;

/**
 * @Class Name : ComCodeController.java
 * @Description : ComCode Controller class
 * @Modification Information
 *
 * @author 경윤수
 * @since 2021-06-30
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
public class ComCodeController {

    @Resource(name = "comCodeService")
    private ComCodeService service;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	
    /**
	 * COM_CODE 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 ComCodeVO
	 * @return "/comCode/ComCodeList"
	 * @exception Exception
	 */
    @RequestMapping(value="/comCode/ComCodeList")
    @ResponseBody
    public Map<String, Object> readComeCode(Model model, 
   		 @ModelAttribute("searchVO") ComCodeVO searchVO) throws Exception{


    	int rowSize = 0;
    	List<?> list = new ArrayList<>();
    	
    	//검색조건이 있을 경우
    	if(!searchVO.getSearchKeyword().equals("")) {
    	
    		//mapper 조건에 따라 condition 설정 필요함.
        	searchVO.setSearchCondition("0");
    		
    		rowSize = service.selectComCodeListTotCnt(searchVO);
        	searchVO.setLastIndex(rowSize);
        	
        	list = service.selectComCodeList(searchVO);
        //검색조건이 없을 경우
    	}else {
    		rowSize = service.selectComCodeListTotCnt(searchVO);
        	searchVO.setLastIndex(rowSize);
        	
        	list = service.selectComCodeList(searchVO);
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
    
    /*
 	 * 테이블 행 추가.
 	 * @return "map"
 	 * @exception Exception
 	 */
     @PostMapping("/ajax/insertComeCode")
     @ResponseBody
     public Map<String,Object> insertComeCode(@RequestBody GridDataVO gd) throws Exception {
     
     	List<?> list = gd.getCreatedRows();
     	
     	for(int i=0;i<list.size();i++) {
     		service.insertComCode((LinkedHashMap) list.get(i));
     	}
     	
     	Map<String, Object> data = new HashMap<>();
     	data.put("result", true);
     	data.put("data", list);
     	
     	return data;
     }
    
    
    /*
	 * 테이블 행 삭제.
	 * @return "map"
	 * @exception Exception
	 */
    @PostMapping("/ajax/deleteComeCode")
    @ResponseBody
    public Map<String,Object> deleteComeCode(@RequestBody GridDataVO gd) throws Exception {
    	
    	List<?> list = gd.getDeletedRows();
    	for(int i=0; i<list.size(); i++) {
    		service.deleteComCode( (LinkedHashMap) list.get(i));
    	}
    	
    	Map<String, Object> data = new HashMap<>();
    	data.put("result", true);
    	data.put("data", list);
    	
    	return data;
    }
    
    //뷰페이지만 넘겨준다.
    @RequestMapping(value="comCode/ComCodeList.do")
    public String selectErpMaterialOrderList(@ModelAttribute("searchVO") ComCodeVO searchVO, 
    		ModelMap model) {
    
        return "mes/com/comCode/ComCodeList.page";
    } 
    
    /*
	 * 테이블 행 업데이트.
	 * @return "map"
	 * @exception Exception
	 */
    @PutMapping("/ajax/updateComeCode")
    @ResponseBody
    public Map<String,Object> updateComeCode(@RequestBody GridDataVO gd) throws Exception {
    	
    	List<?> list = gd.getUpdatedRows();
    	//전달받은 데이터 수 만큼.
    	for(int i=0; i<list.size(); i++) {
    		service.updateComCode( (LinkedHashMap) list.get(i));
    	}
    	
    	Map<String, Object> data = new HashMap<>();
    	data.put("result", true);
    	data.put("data", list);
    	
    	return data;
    }

}

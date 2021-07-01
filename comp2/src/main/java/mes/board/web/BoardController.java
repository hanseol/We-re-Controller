package mes.board.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.rte.fdl.property.EgovPropertyService;
import mes.board.service.BoardService;
import mes.board.service.BoardVO;
import mes.main.service.ComFunc;
import mes.main.service.GridDataVO;

/**
 * @Class Name : BoardController.java
 * @Description : Board Controller class
 * @Modification Information
 *
 * @author hanseol
 * @since 20210629
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
//@SessionAttributes(types=BoardVO.class)
public class BoardController {

    @Resource(name = "boardService")
    private BoardService service;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	
    
    ComFunc comFunc = new ComFunc();
    /*
	 * 테이블 목록 조회.
	 * @param searchVO - 조회할 정보가 담긴 BoardDefaultVO
	 * @return "map"
	 * @exception Exception
	 */
    @RequestMapping(value="/mes/readBoard")
    @ResponseBody
    public Map<String, Object> readBoard(Model model, 
    		 @ModelAttribute("searchVO") BoardVO searchVO) throws Exception{

    	int rowSize = 0;
    	List<?> list = new ArrayList<>();
    	
    	//검색조건이 있을 경우
    	if(!searchVO.getSearchKeyword().equals("")) {
    	
    		//mapper 조건에 따라 condition 설정 필요함.
        	searchVO.setSearchCondition("0");
        	list = service.selectBoardList(searchVO);
        	
        //검색조건이 없을 경우
    	}else {
        	list = service.selectBoardList(searchVO);
    	}
    	
    	return comFunc.sendResult(list, "select");
    }
    
    /*
	 * 테이블 행 추가.
	 * @return "map"
	 * @exception Exception
	 */
	@PostMapping("/ajax/insertBoard")
    @ResponseBody
    public Map<String,Object> insertBoard(@RequestBody GridDataVO gd) throws Exception {
    
    	List<?> list = gd.getCreatedRows();
    	
    	for(int i=0;i<list.size();i++) {
    		service.insertBoard( (LinkedHashMap) list.get(i));
    	}
    	
    	return comFunc.sendResult(list, "insert");
    }
    
    
    /*
	 * 테이블 행 삭제.
	 * @return "map"
	 * @exception Exception
	 */
    @PostMapping("/ajax/deleteBoard")
    @ResponseBody
    public Map<String,Object> deleteBoard(@RequestBody GridDataVO gd) throws Exception {
    	
    	List<?> list = gd.getDeletedRows();
    	for(int i=0; i<list.size(); i++) {
    		service.deleteBoard((LinkedHashMap) list.get(i));
    	}
    	
    	return comFunc.sendResult(list, "delete");
    }
    
    /*
	 * 테이블 행 업데이트.
	 * @return "map"
	 * @exception Exception
	 */
    @PutMapping("/ajax/updateBoard")
    @ResponseBody
    public Map<String,Object> updateBoard(@RequestBody GridDataVO gd) throws Exception {
    	
    	List<?> list = gd.getUpdatedRows();
    	//전달받은 데이터 수 만큼.
    	for(int i=0; i<list.size(); i++) {
    		service.updateBoard((LinkedHashMap) list.get(i));
    	}
    	
    	return comFunc.sendResult(list, "update");
    }
}

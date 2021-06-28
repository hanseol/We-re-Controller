package mes.board.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import egovframework.rte.fdl.property.EgovPropertyService;
import mes.board.service.BoardDefaultVO;
import mes.board.service.BoardService;
import mes.board.service.BoardVO;
import mes.board.service.GridDataVO;

/**
 * @Class Name : BoardController.java
 * @Description : Board Controller class
 * @Modification Information
 *
 * @author kym
 * @since 20210621
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
@SessionAttributes(types=BoardVO.class)
public class BoardController {

    @Resource(name = "boardService")
    private BoardService boardService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	
    /*
	 * 테이블 목록 조회.
	 * @param searchVO - 조회할 정보가 담긴 BoardDefaultVO
	 * @return "map"
	 * @exception Exception
	 */
    @RequestMapping(value="/mes/readBoard")
    @ResponseBody
    public Map<String, Object> readBoard(Model model, 
    		 @ModelAttribute("searchVO") BoardDefaultVO searchVO) throws Exception{

    	int rowSize = boardService.selectBoardListTotCnt(searchVO);
    	searchVO.setLastIndex(rowSize);
    	List<?> boardList = boardService.selectBoardList(searchVO);
    	
    	Map<String, Object> paging = new HashMap<>();
    	paging.put("page", searchVO.getPageIndex());
    	paging.put("totalCount", rowSize);
    	System.out.println("============================="+rowSize);
    	
    	Map<String,Object> data = new HashMap<>();
    	data.put("contents", boardList);
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
    @PostMapping("/ajax/insertBoard")
    @ResponseBody
    public Map<String,Object> insertBoard(@RequestBody GridDataVO gd) throws Exception {
    
    	List<BoardVO> list = new ArrayList<>();
    	list = gd.getCreatedRows();
    	
    	for(int i=0;i<list.size();i++) {
    		boardService.insertBoard(list.get(i));
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
    @DeleteMapping("/ajax/deleteBoard")
    @ResponseBody
    public Map<String,Object> deleteBoard(@RequestBody GridDataVO gd) throws Exception {
    	
    	List<BoardVO> list = gd.getDeltedRows();
    	for(int i=0; i<list.size(); i++) {
    		boardService.deleteBoard(list.get(i));
    	}
    	
    	Map<String, Object> data = new HashMap<>();
    	data.put("result", true);
    	data.put("data", list.size());
    	
    	return data;
    }
    
    /*
	 * 테이블 행 업데이트.
	 * @return "map"
	 * @exception Exception
	 */
    @PutMapping("/ajax/updateBoard")
    @ResponseBody
    public Map<String,Object> updateBoard(@RequestBody GridDataVO gd) throws Exception {
    	
    	List<BoardVO> list = gd.getUpdatedRows();
    	for(int i=0; i<list.size(); i++) {
    		boardService.updateBoard(list.get(i));
    	}
    	
    	Map<String, Object> data = new HashMap<>();
    	data.put("result", true);
    	data.put("data", list);
    	
    	return data;
    }
}

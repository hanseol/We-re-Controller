package mes.board.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
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
	
    /**
	 * BOARD 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 BoardDefaultVO
	 * @return "/board/BoardList"
	 * @exception Exception
	 */
    @RequestMapping(value="/board/BoardList.do")
    public String selectBoardList(@ModelAttribute("searchVO") BoardDefaultVO searchVO, 
    		ModelMap model)
            throws Exception {
    	
    	/** EgovPropertyService.sample */
    	searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	searchVO.setPageSize(propertiesService.getInt("pageSize"));
    	
    	/** pageing */
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
        List<?> boardList = boardService.selectBoardList(searchVO);
        model.addAttribute("resultList", boardList);
        
        int totCnt = boardService.selectBoardListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "mes/board/BoardList.page";
    } 
    
    @RequestMapping("/board/addBoardView.do")
    public String addBoardView(
            @ModelAttribute("searchVO") BoardDefaultVO searchVO, Model model)
            throws Exception {
        model.addAttribute("boardVO", new BoardVO());
        return "/mes/board/BoardRegister";
    }
    
    @RequestMapping("/board/addBoard.do")
    public String addBoard(
            BoardVO boardVO,
            @ModelAttribute("searchVO") BoardDefaultVO searchVO, SessionStatus status)
            throws Exception {
        boardService.insertBoard(boardVO);
        status.setComplete();
        return "forward:/board/BoardList.do";
    }
    
    @RequestMapping("/board/updateBoardView.do")
    public String updateBoardView(
            @RequestParam("no") java.math.BigDecimal no ,
            @ModelAttribute("searchVO") BoardDefaultVO searchVO, Model model)
            throws Exception {
        BoardVO boardVO = new BoardVO();
        boardVO.setNo(no);
        // 변수명은 CoC 에 따라 boardVO
        model.addAttribute(selectBoard(boardVO, searchVO));
        return "/mes/board/BoardRegister";
    }

    @RequestMapping("/board/selectBoard.do")
    public @ModelAttribute("boardVO")
    BoardVO selectBoard(
            BoardVO boardVO,
            @ModelAttribute("searchVO") BoardDefaultVO searchVO) throws Exception {
        return boardService.selectBoard(boardVO);
    }

    @RequestMapping("/board/updateBoard.do")
    public String updateBoard(
            BoardVO boardVO,
            @ModelAttribute("searchVO") BoardDefaultVO searchVO, SessionStatus status)
            throws Exception {
        boardService.updateBoard(boardVO);
        status.setComplete();
        return "forward:/board/BoardList.do";
    }
    
    @RequestMapping("/board/deleteBoard.do")
    public String deleteBoard(
            BoardVO boardVO,
            @ModelAttribute("searchVO") BoardDefaultVO searchVO, SessionStatus status)
            throws Exception {
        boardService.deleteBoard(boardVO);
        status.setComplete();
        return "forward:/board/BoardList.do";
    }

    
    //조회.
    @RequestMapping(value="/mes/readBoard")
    @ResponseBody
    public Map<String, Object> readBoard(Model model, 
    		 @ModelAttribute("searchVO") BoardDefaultVO searchVO) throws Exception{

    	List<?> boardList = boardService.selectBoardList(searchVO);
    	
    	Map<String, Object> paging = new HashMap<>();
    	paging.put("page", searchVO.getPageIndex());
    	paging.put("totalCount", boardList.size());
    	
    	Map<String,Object> data = new HashMap<>();
    	data.put("contents", boardList);
    	data.put("pagination", paging);
    	
    	Map<String,Object> map = new HashMap<>();
    	map.put("result", true);
    	map.put("data", data);
        
    	return map;
    }
    
    @PutMapping("/ajax/updateBoard")
    @ResponseBody
    public Map updateBoard(@RequestBody GridDataVO gd){
    
    	//업데이트
    	Map<String, Object> data = new HashMap<>();
    	data.put("result", true);
    	data.put("data", gd.getUpdatedRows());
    	return data;
    	
    }
}

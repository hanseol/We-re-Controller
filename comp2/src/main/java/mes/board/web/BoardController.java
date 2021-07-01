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
 *      Copyright (C) All right reserved.
 */

@Controller
//@SessionAttributes(types=BoardVO.class)
public class BoardController {

	@Resource(name = "boardService")
	private BoardService service;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/** 공통 함수 */
	ComFunc comFunc = new ComFunc();

	/*
	 * 테이블 목록 조회.
	 * 
	 * @param searchVO - 조회할 정보가 담긴 BoardDefaultVO
	 * 
	 * @return "map"
	 * 
	 * @exception Exception
	 */
	@RequestMapping(value = "/ajax/readBoard")
	@ResponseBody
	public Map<String, Object> readBoard(Model model, @ModelAttribute("searchVO") BoardVO searchVO) throws Exception {

		List<?> list = new ArrayList<>();

		// 검색조건이 있을 경우
		if (!searchVO.getSearchKeyword().equals("")) {
			searchVO.setSearchCondition("0");
			list = service.selectBoardList(searchVO);
		// 검색조건이 없을 경우
		} else {
			list = service.selectBoardList(searchVO);
		}

		return comFunc.sendResult(list);
	}

	/*
	 * 테이블 행 추가 수정 삭제.
	 * 
	 * @exception Exception
	 */
	@PutMapping("/ajax/modifyBoard")
	@ResponseBody
	public void modifyBoard(@RequestBody GridDataVO gd) throws Exception {

		List<?> updatedList = gd.getUpdatedRows();
		List<?> createdList = gd.getCreatedRows();
		List<?> deletedList = gd.getDeletedRows();

		if (updatedList.size() != 0) {
			for (int i = 0; i < updatedList.size(); i++) {
				service.updateBoard((LinkedHashMap) updatedList.get(i));
			}
		}

		if (createdList.size() != 0) {
			for (int i = 0; i < createdList.size(); i++) {
				service.insertBoard((LinkedHashMap) createdList.get(i));
			}
		}

		if (deletedList.size() != 0)
		{
			for (int i = 0; i < deletedList.size(); i++) {
				service.deleteBoard((LinkedHashMap) deletedList.get(i));
			}
		}
	}
}

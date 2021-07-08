package mes.board.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.rte.fdl.idgnr.EgovIdGnrService;
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

	@Resource(name = "mesNoIdGnrService")
	protected EgovIdGnrService mesNoIdGnrService;
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
	public Map<String, Object> readBoard(@ModelAttribute("searchVO") BoardVO searchVO) throws Exception {

		List<?> list = new ArrayList<>();

		list = service.selectBoardList(searchVO);

		return comFunc.sendResult(list);
	}

	/*
	 * 테이블 행 추가 수정 삭제.
	 * 
	 * @exception Exception
	 */
	@PutMapping("/ajax/modifyBoard")
	@ResponseBody
	public Map<String, Object> modifyBoard( @RequestBody GridDataVO gd) throws Exception{

		
    	Map<String,Object> map = new HashMap<>();
		
		List<?> updatedList = gd.getUpdatedRows();
		List<?> createdList = gd.getCreatedRows();
		List<?> deletedList = gd.getDeletedRows();

		if (updatedList.size() != 0) {
			for (int i = 0; i < updatedList.size(); i++) {
				service.updateBoard((LinkedHashMap) updatedList.get(i));
			}
		}

		//시퀀스 포맷팅
		//각 전표번호랑 LOT번호 부여할 때 필요한 기능.
		//월요일에 공유 필요.
		//EgovIdGnrStrategyImpl, resources/egovframework/spring/com/idgn/context-idgn-*.xml
		if (createdList.size() != 0) {
			for (int i = 0; i < createdList.size(); i++) {
				((LinkedHashMap)createdList.get(i)).put("no", mesNoIdGnrService.getNextStringId());
				service.insertBoard((LinkedHashMap) createdList.get(i));
			}
		}
		
		//페이지에서 값 넘겨주는 방법.
		//관리 페이지에서 계획이나 지시 입력할 때 필요한 기능.
		//월요일에 공유 필요.
		//GridDataVO.
//		if (createdList.size() != 0) {
//			for (int i = 0; i < createdList.size(); i++) {
//				//시퀀스 번호 requestParam 가져오기 -> GridDataVO에 변수 선언
//		//		System.out.println("=======requestParam" + gd.getVo().getNo());
//				((LinkedHashMap)createdList.get(i)).put("no", gd.getNo());
//				service.insertBoard((LinkedHashMap) createdList.get(i));
//			}
//		}

		if (deletedList.size() != 0)
		{
			for (int i = 0; i < deletedList.size(); i++) {
				service.deleteBoard((LinkedHashMap) deletedList.get(i));
			}
		}
		
    	map.put("result", true);
		
		return map;
	}
}

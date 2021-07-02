package mes.com.comCode.web;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.rte.fdl.property.EgovPropertyService;
import mes.com.comCode.service.ComCodeService;
import mes.com.comCode.service.ComCodeVO;
import mes.main.service.ComFunc;
import mes.main.service.GridDataVO;
import mes.pro.plan.service.ProPlanVO;

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
 *      Copyright (C) All right reserved.
 */

@Controller
public class ComCodeController {

	@Resource(name = "comCodeService")
	private ComCodeService service;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	ComFunc comFunc = new ComFunc();

	// 마스터코드 조회
	@RequestMapping(value = "/comCode/ComCodeList")
	@ResponseBody
	public Map<String, Object> readComeCode(Model model, @ModelAttribute("searchVO") ComCodeVO searchVO)
			throws Exception {

		int rowSize = 0;
		List<?> list = new ArrayList<>();

		// 검색조건이 있을 경우
		if (!searchVO.getSearchKeyword().equals("")) {

			// mapper 조건에 따라 condition 설정 필요함.
			searchVO.setSearchCondition("0");
			list = service.selectComCodeList(searchVO);

			// 검색조건이 없을 경우
		} else {
			list = service.selectComCodeList(searchVO);
		}

		return comFunc.sendResult(list);
	}

	// 디테일코드 조회
	@RequestMapping(value = "/comCode/ComCodeDetailList")
	@ResponseBody
	public Map<String, Object> readComeCodeDetail(Model model, @ModelAttribute("searchVO") ComCodeVO searchVO)
			throws Exception {

		List<?> list = new ArrayList<>();

		list = service.selectComCodeDetailList(searchVO);

		return comFunc.sendResult(list);
	}

	//모디파이
	@PutMapping("/ajax/modifyComCodeDetail")
	@ResponseBody
	public void modifyComCodeDetail(@RequestBody GridDataVO gd) throws Exception {

		List<?> updatedList = gd.getUpdatedRows();
		List<?> createdList = gd.getCreatedRows();
		List<?> deletedList = gd.getDeletedRows();

		if (updatedList.size() != 0) {
			for (int i = 0; i < updatedList.size(); i++) {
				service.updateComCodeDetail((LinkedHashMap) updatedList.get(i));
			}
		}

		if (createdList.size() != 0) {
			for (int i = 0; i < createdList.size(); i++) {
				service.insertComCodeDetail((LinkedHashMap) createdList.get(i));
			}
		}

		if (deletedList.size() != 0) {
			for (int i = 0; i < deletedList.size(); i++) {
				service.deleteComCodeDetail((LinkedHashMap) deletedList.get(i));
			}
		}
	}
	
	//	모달
	//모달 창을 여는 버튼을 눌렀을 때 동작
	@GetMapping("comCodeModal.do")
	public String comCodeModal() {
		
		//모달창에 띄워줄 view페이지 전달.
		return "mes/com/comCode/ComCodeModal";
	}
	
	//모달창에 결과 값 전달
	@RequestMapping("mes/com/comCode/ComCodeModal")
	@ResponseBody
	public Map<String, Object> searchComeCode(Model model, 
   		@ModelAttribute("searchVO") ComCodeVO searchVO) throws Exception {
		

    	List<?> list = service.selectComCodeList(searchVO);
    	
    	ComFunc comFunc = new ComFunc();
    	return comFunc.sendResult(list);
	}
	
	
	// 뷰페이지만 넘겨준다.
	@RequestMapping(value = "comCode/ComCodeList.do")
	public String selectErpMaterialOrderList(@ModelAttribute("searchVO") ComCodeVO searchVO, ModelMap model) {

		return "mes/com/comCode/ComCodeList.page";
	}

}

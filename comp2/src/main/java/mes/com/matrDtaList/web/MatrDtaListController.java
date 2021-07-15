package mes.com.matrDtaList.web;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.rte.fdl.property.EgovPropertyService;
import mes.com.matrDtaList.service.MatrDtaListService;
import mes.com.matrDtaList.service.MatrDtaListVO;
import mes.com.matrDtaList.service.impl.MatrDtaListMapper;
import mes.main.service.ComFunc;

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
public class MatrDtaListController {

	@Autowired MatrDtaListMapper matrDtaListMapper;
		
	@Resource(name = "matrDtaListService")
	private MatrDtaListService service;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	ComFunc comFunc = new ComFunc();
	
	// 마스터코드 조회
	@RequestMapping(value = "/matrDta/MatrDtaList")
	@ResponseBody
	public Map<String, Object> readMatrDtaList(Model model, @ModelAttribute("searchVO") MatrDtaListVO searchVO)
			throws Exception {
		
    	List<?> list = service.selectMatrDtaList(searchVO);
    	
    	
    	return comFunc.sendResult(list);
	}
	
	// 디테일코드 조회
	@RequestMapping(value = "/matrDta/MatrDtaDetailList")
	@ResponseBody
	public Map<String, Object> readMatrDtaListDetail(Model model, @ModelAttribute("searchVO") MatrDtaListVO searchVO)
			throws Exception {

		List<?> list = new ArrayList<>();

		list = service.selectMatrDtaListDetailList(searchVO);

		model.addAttribute("MatrDta", matrDtaListMapper.selectMatrDtaListDetailList(searchVO));
		
		return comFunc.sendResult(list);
	}
	
	// 뷰페이지만 넘겨준다.
	@RequestMapping(value = "com/matrDta/MatrDtaList.do")
	public String MatrDtaList(@ModelAttribute("searchVO") MatrDtaListVO searchVO, ModelMap model) {

		return "mes/com/matrDta/matrDtaList.page";
	}

}

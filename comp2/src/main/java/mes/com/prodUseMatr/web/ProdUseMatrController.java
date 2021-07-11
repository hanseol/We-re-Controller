package mes.com.prodUseMatr.web;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.rte.fdl.property.EgovPropertyService;
import mes.com.comCode.service.ComCodeVO;
import mes.com.prodUseMatr.service.ProdUseMatrService;
import mes.com.prodUseMatr.service.ProdUseMatrVO;
import mes.main.service.ComFunc;
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
 *      Copyright (C) All right reserved.
 */

@Controller
public class ProdUseMatrController {

	@Resource(name = "prodUseMatrService")
	private ProdUseMatrService service;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	ComFunc comFunc = new ComFunc();
	
	// 디테일 조회
	@RequestMapping(value = "/prodUseMatr/ProdUseMatrHead")
	@ResponseBody
	public Map<String, Object> readProudUseHead(Model model, @ModelAttribute("searchVO") ProdUseMatrVO searchVO)
			throws Exception {

		
    	List<?> list = service.selectProudUseHead(searchVO);
    	
    	return comFunc.sendResult(list);
	}

	// 디테일 조회
	@RequestMapping(value = "/prodUseMatr/ProdUseMatrList")
	@ResponseBody
	public Map<String, Object> readProdUseMatr(Model model, @ModelAttribute("searchVO") ProdUseMatrVO searchVO)
			throws Exception {

		
    	List<?> list = service.selectProdUseMatrList(searchVO);
    	
    	return comFunc.sendResult(list);
	}
	
	//모달 제품코드
	//모달 창을 여는 버튼을 눌렀을 때 동작
	@GetMapping("/prodUseMatr/ProdUseMatrModal.do")
	public String ProdUseMatrModal() {
		
		//모달창에 띄워줄 view페이지 전달.
		return "mes/com/comModal/prodUseMatrModal";
	}
	
	//모달창에 결과 값 전달
	@RequestMapping("mes/com/prodUseMatr/ProdUseMatrModal")
	@ResponseBody
	public Map<String, Object> selectBomModal(Model model, 
   		@ModelAttribute("searchVO") ProdUseMatrVO searchVO) throws Exception {
		
    	List<?> list = service.selectBomModal(searchVO);
    	
    	return comFunc.sendResult(list);
	}
	
	//모달 공정코드
	//모달 창을 여는 버튼을 눌렀을 때 동작
	@GetMapping("/prodUseMatr/ProCodeSearchModal.do")
	public String ProcessModal() {
		
		//모달창에 띄워줄 view페이지 전달.
		return "mes/com/comModal/proCodeSearchModal";
	}
	
	//모달창에 결과 값 전달
	@RequestMapping("mes/com/prodUseMatr/ProCodeSearchModal")
	@ResponseBody
	public Map<String, Object> selectProcessModal(Model model, 
   		@ModelAttribute("searchVO") ProdUseMatrVO searchVO) throws Exception {
		
    	List<?> list = service.selectProcessModal(searchVO);
    	
    	return comFunc.sendResult(list);
	}
	
	//CRUD
	@PutMapping("/ajax/modifyProdUseMatr")
	@ResponseBody
	public void modifyProdUseMatr(@RequestBody GridDataVO gd) throws Exception {

		List<?> updatedList = gd.getUpdatedRows();
		List<?> createdList = gd.getCreatedRows();
		List<?> deletedList = gd.getDeletedRows();

		if (updatedList.size() != 0) {
			for (int i = 0; i < updatedList.size(); i++) {
				service.updateProdUseMatrDetail((LinkedHashMap) updatedList.get(i));
			}
		}

		if (createdList.size() != 0) {
			for (int i = 0; i < createdList.size(); i++) {
				service.insertProdUseMatrDetail((LinkedHashMap) createdList.get(i));
			}
		}

		if (deletedList.size() != 0) {
			for (int i = 0; i < deletedList.size(); i++) {
				service.deleteProdUseMatrDetail((LinkedHashMap) deletedList.get(i));
			}
		}
	}
	
	// 뷰페이지만 넘겨준다.
	@RequestMapping(value = "prodUseMatr/ProdUseMatrForm.do")
	public String viewProdUseMatr(@ModelAttribute("searchVO") ProdUseMatrVO searchVO, ModelMap model) {

		return "mes/com/prodUseMatr/prodUseMatrForm.page";
	}

}

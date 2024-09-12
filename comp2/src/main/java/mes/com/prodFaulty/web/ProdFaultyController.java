package mes.com.prodFaulty.web;

import java.util.LinkedHashMap;
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
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.rte.fdl.property.EgovPropertyService;
import mes.com.prodFaulty.service.ProdFaultyService;
import mes.com.prodFaulty.service.ProdFaultyVO;
import mes.main.service.ComFunc;
import mes.main.service.GridDataVO;


@Controller
public class ProdFaultyController {

	@Resource(name = "prodFaultyService")
	private ProdFaultyService service;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	ComFunc comFunc = new ComFunc();
	
	// 테이블 조회
	@RequestMapping(value = "/prodFaulty/prodFaultyList")
	@ResponseBody
	public Map<String, Object> selectProdFaulty(Model model, @ModelAttribute("searchVO") ProdFaultyVO searchVO)
			throws Exception {

		
    	List<?> list = service.selectProdFaulty(searchVO);
    	
    	return comFunc.sendResult(list);
	}
	
	//모디파이
	@PutMapping("/ajax/modifyProdFaulty")
	@ResponseBody
	public void modifyProdFaulty(@RequestBody GridDataVO gd) throws Exception {

		List<?> updatedList = gd.getUpdatedRows();
		List<?> createdList = gd.getCreatedRows();
		List<?> deletedList = gd.getDeletedRows();

		if (updatedList.size() != 0) {
			for (int i = 0; i < updatedList.size(); i++) {
				service.updateProdFault((LinkedHashMap) updatedList.get(i));
			}
		}

		if (createdList.size() != 0) {
			for (int i = 0; i < createdList.size(); i++) {
				service.insertProdFaulty((LinkedHashMap) createdList.get(i));
			}
		}

		if (deletedList.size() != 0) {
			for (int i = 0; i < deletedList.size(); i++) {
				service.deleteProdFault((LinkedHashMap) deletedList.get(i));
			}
		}
	}
	
	// 뷰페이지만 넘겨준다.
	@RequestMapping(value = "com/prodFaulty/prodFaultyForm.do")
	public String viewProdFaulty(@ModelAttribute("searchVO") ProdFaultyVO searchVO, ModelMap model) {

		return "mes/com/prodFaulty/prodFaultyForm.page";
	}

}

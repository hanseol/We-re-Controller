package mes.com.matrFaulty.web;

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
import mes.com.matrFaulty.service.MatrFaultyService;
import mes.com.matrFaulty.service.MatrFaultyVO;
import mes.main.service.ComFunc;
import mes.main.service.GridDataVO;


@Controller
public class MatrFaultyController {

	@Resource(name = "matrFaultyService")
	private MatrFaultyService service;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	ComFunc comFunc = new ComFunc();
	
	// 테이블 조회
	@RequestMapping(value = "/matrFaulty/matrFaultyList")
	@ResponseBody
	public Map<String, Object> selectMatrFaulty(Model model, @ModelAttribute("searchVO") MatrFaultyVO searchVO)
			throws Exception {

		
    	List<?> list = service.selectMatrFaulty(searchVO);
    	
    	return comFunc.sendResult(list);
	}
	
	//모디파이
	@PutMapping("/ajax/modifyMatrFaulty")
	@ResponseBody
	public void modifyMatrFaulty(@RequestBody GridDataVO gd) throws Exception {

		List<?> updatedList = gd.getUpdatedRows();
		List<?> createdList = gd.getCreatedRows();
		List<?> deletedList = gd.getDeletedRows();

		if (updatedList.size() != 0) {
			for (int i = 0; i < updatedList.size(); i++) {
				service.updateMatrFaulty((LinkedHashMap) updatedList.get(i));
			}
		}

		if (createdList.size() != 0) {
			for (int i = 0; i < createdList.size(); i++) {
				service.insertMatrFaulty((LinkedHashMap) createdList.get(i));
			}
		}

		if (deletedList.size() != 0) {
			for (int i = 0; i < deletedList.size(); i++) {
				service.deleteMatrFaulty((LinkedHashMap) deletedList.get(i));
			}
		}
	}
	
	// 뷰페이지만 넘겨준다.
	@RequestMapping(value = "matrFaulty/matrFaultyForm.do")
	public String viewMatrFaulty(@ModelAttribute("searchVO") MatrFaultyVO searchVO, ModelMap model) {

		return "mes/com/matrFaulty/matrFaultyForm.page";
	}

}

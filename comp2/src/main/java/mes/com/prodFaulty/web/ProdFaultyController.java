package mes.com.prodFaulty.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.rte.fdl.property.EgovPropertyService;
import mes.com.prodFaulty.service.ProdFaultyService;
import mes.com.prodFaulty.service.ProdFaultyVO;
import mes.main.service.ComFunc;


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
	

	
	
	// 뷰페이지만 넘겨준다.
	@RequestMapping(value = "prodFaulty/prodFaultyForm.do")
	public String viewProdFaulty(@ModelAttribute("searchVO") ProdFaultyVO searchVO, ModelMap model) {

		return "mes/com/prodFaulty/prodFaultyForm.page";
	}

}

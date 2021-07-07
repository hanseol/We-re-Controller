package mes.com.prodProcFlow.web;

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
import mes.com.prodProcFlow.service.ProdProcFlowService;
import mes.com.prodProcFlow.service.ProdProcFlowVO;
import mes.main.service.ComFunc;

@Controller
public class ProdProcFlowController {

	@Resource(name = "prodProcFlowService")
	private ProdProcFlowService service;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	ComFunc comFunc = new ComFunc();
	
	// 마스터코드 조회
	@RequestMapping(value = "/prodProc/ComProdList")
	@ResponseBody
	public Map<String, Object> selectComProdList(Model model, @ModelAttribute("searchVO") ProdProcFlowVO searchVO)
			throws Exception {
		
    	List<?> list = service.selectComProdList(searchVO);
    	
    	
    	return comFunc.sendResult(list);
	}
	
	// 디테일코드 조회
	@RequestMapping(value = "/prodProc/ProdProcList")
	@ResponseBody
	public Map<String, Object> selectProdProcList(Model model, @ModelAttribute("searchVO") ProdProcFlowVO searchVO)
			throws Exception {

		List<?> list = service.selectProdProcList(searchVO);

		return comFunc.sendResult(list);
	}
	
	// 공정전개 조회
	@RequestMapping(value = "/prodProc/ProcFlowList")
	@ResponseBody
	public Map<String, Object> selectProcFlowList(Model model, @ModelAttribute("searchVO") ProdProcFlowVO searchVO)
			throws Exception {
		
		List<?> list = service.selectProcFlowList(searchVO);
		
		return comFunc.sendResult(list);
	}
	
	// 뷰페이지만 넘겨준다.
	@RequestMapping(value = "prodProc/prodProcFlowForm.do")
	public String prodProcFlow(@ModelAttribute("searchVO") ProdProcFlowVO searchVO, ModelMap model) {

		return "mes/com/prodProc/prodProcFlowForm.page";
	}

}

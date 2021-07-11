package mes.com.comModal.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.rte.fdl.property.EgovPropertyService;
import mes.com.comCode.service.ComCodeVO;
import mes.com.comModal.service.ComModalService;
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
public class ComModalController {

	@Resource(name = "comModalService")
	private ComModalService service;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	ComFunc comFunc = new ComFunc();
	
	//모달 불량코드
	//모달 창을 여는 버튼을 눌렀을 때 동작
	@GetMapping("/comModal/ProdFaultModal.do")
	public String prodFaultModal() {
		
		//모달창에 띄워줄 view페이지 전달.
		return "mes/com/comModal/prodFaultModal";
	}
	
	//모달창에 결과 값 전달
	@RequestMapping("mes/com/comModal/ProdFaultModal")
	@ResponseBody
	public Map<String, Object> modalProdFault(Model model, 
   		@ModelAttribute("searchVO") ComCodeVO searchVO) throws Exception {
		
    	List<?> list = service.modalProdFault(searchVO);
    	
    	return comFunc.sendResult(list);
	}

}

package mes.main.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.rte.fdl.property.EgovPropertyService;
import mes.main.service.ComFunc;
import mes.pro.plan.service.ProPlanService;
import mes.pro.plan.service.ProPlanVO;

/*
 *  작성자 : hanseol
 *  작성일자 : 2021-06-28
 *  설명 : 시작화면
 *  수정일자 : 2021-06-30 뷰페이지에 모달창 출력.
 */

@Controller
public class HomeController {

	@Resource
	private ProPlanService service;
	
	@Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	
	@RequestMapping("home.do")
	public String home(HttpSession session) {
	
		//세션체크 //나중에 aop적용하기...
		if(session.getAttribute("session")==null) {
			return "mes/member/loginForm";
		}
		return "tiles/home.page";
	}
	
	//모달 창을 여는 버튼을 눌렀을 때 동작
	@GetMapping("testModal.do")
	public String testModal() {
		
		//모달창에 띄워줄 view페이지 전달.
		return "mes/modalTest/test";
	}
	
	//모달창에 결과 값 전달
	@RequestMapping("mes/modalTest/test")
	@ResponseBody
	public Map<String, Object> searchProduct( 
   		@ModelAttribute("searchVO") ProPlanVO searchVO) throws Exception {
		

    	List<?> list = service.selectProductList(searchVO);
    	
    	ComFunc comFunc = new ComFunc();
    	return comFunc.sendResult(list);
    	
	}
	
	//모달 창을 여는 버튼을 눌렀을 때 동작
		@GetMapping("test2Modal.do")
		public String test2Modal() {
			
			//모달창에 띄워줄 view페이지 전달.
			return "mes/modalTest/test2";
		}
	

}

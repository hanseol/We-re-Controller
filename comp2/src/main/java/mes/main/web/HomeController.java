package mes.main.web;



import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.rte.fdl.property.EgovPropertyService;
import mes.pro.plan.service.ProPlanService;

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
	
	/**
	 * 홈 
	 * 
	 * */
	
	@RequestMapping("/home.do")
	public String home(HttpSession session) {

		return "tiles/home.page";
	}
	
	/**
     * security check.
     * 
     * */
    @RequestMapping("/loginForm.do")
  	public String loginForm(Model model) {
  		return "mes/member/loginForm";
  	}
    
    @RequestMapping("/accessDenied.do")
  	public String accessDenied(Model model) {
  		return "mes/member/denied";
  	}

}

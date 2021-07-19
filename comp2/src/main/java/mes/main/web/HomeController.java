package mes.main.web;



import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.sym.mnu.mpm.service.EgovMenuManageService;
import egovframework.com.sym.mnu.mpm.service.MenuManageVO;
import egovframework.com.utl.fcc.service.EgovStringUtil;
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
	
	//메뉴 목록 조회
	/** EgovMenuManageService */
	@Resource(name = "meunManageService")
    private EgovMenuManageService menuManageService;
	
	/**
	 * 홈 
	 * 
	 * */
	@RequestMapping("/mes/getMenuLeft.do")
	@ResponseBody
	public Map<String,Object> getMenuLeft(ModelMap model,
			@ModelAttribute("menuManageVO") MenuManageVO menuManageVO) throws Exception {
		
		LoginVO user =
				(LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();

	    	menuManageVO.setTmpId(user == null ? "" : EgovStringUtil.isNullToString(user.getId()));
	    	menuManageVO.setTmpPassword(user == null ? "" : EgovStringUtil.isNullToString(user.getPassword()));
	    	menuManageVO.setTmpUserSe(user == null ? "" : EgovStringUtil.isNullToString(user.getUserSe()));
	    	menuManageVO.setTmpName(user == null ? "" : EgovStringUtil.isNullToString(user.getName()));
	    	menuManageVO.setTmpEmail(user == null ? "" : EgovStringUtil.isNullToString(user.getEmail()));
	    	menuManageVO.setTmpOrgnztId(user == null ? "" : EgovStringUtil.isNullToString(user.getOrgnztId()));
	    	menuManageVO.setTmpUniqId(user == null ? "" : EgovStringUtil.isNullToString(user.getUniqId()));
		
		
		List<?> list = menuManageService.selectMainMenuLeft(menuManageVO);
		System.out.println("=============="+list.toString());
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("menuList",list);
		
		return map;
	}
	
	@RequestMapping("/home.do")
	public String setContent(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {

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
  		return "mes/member/denied.page";
  	}

}

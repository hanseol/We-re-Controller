package mes.member.web;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import mes.mac.service.MacService;
import mes.member.service.ErpEmpService;
import mes.member.service.ErpEmpVO;
import mes.member.service.MacDateResultVO;
import mes.member.service.SessionVO;

/**
 * @Class Name : ErpEmpController.java
 * @Description : ErpEmp Controller class
 * @Modification Information
 *
 * @author hanseol
 * @since 20210706
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
public class ErpEmpController {

    @Resource(name = "erpEmpService")
    private ErpEmpService erpEmpService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	
    @Resource(name = "macService")
	private MacService macService;
    
    
    /*
     * 로그아웃 시 세션 정보를 삭제하고 로그인 페이지로 이동.
     * 
     */
    @RequestMapping("logout.do")
    public String logout(HttpSession session) {
    	
    	System.out.println("==============="+session.getAttribute("session").toString());
    	session.invalidate();
    	
    	return "mes/member/loginForm";
    }
    


}

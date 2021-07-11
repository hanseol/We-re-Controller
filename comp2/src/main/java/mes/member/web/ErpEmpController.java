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
     * 홈페이지에 접속하면 로그인 폼 화면이 보여진다.
     * 
     * */
    @RequestMapping("loginForm.do")
  	public String loginForm(Model model) {
  		return "mes/member/loginForm";
  	}
    
    /* 
     * 아이디와 비밀번호가 일치하는지 확인하여
     * 상황에 맞는 뷰 페이지를 전달한다.
     * */
    @RequestMapping("login.do")
    public ModelAndView login(ErpEmpVO empVO,
    						ModelAndView mv, HttpSession session) throws Exception {
    	
    	
    	SessionVO sessionVO = new SessionVO();
    	
    	empVO = erpEmpService.login(empVO);
    	
    	//해당 사원이 있는지 체크
    	if(!empVO.getErpEmployeeName().equals("")){
    		//로그인 성공 시 세션에 해당사원 정보 담아주기.
    		sessionVO.setErpEmployeeId(empVO.getErpEmployeeId());
    		sessionVO.setErpEmployeeName(empVO.getErpEmployeeName());
    		sessionVO.setErpEmployeePosition(empVO.getErpEmployeePosition());
    		sessionVO.setErpDepartmentName(empVO.getErpDepartmentName());
    		
    		List<MacDateResultVO> list = macService.selectLeftDate();
    		List<MacDateResultVO> fList = new ArrayList<>();
    		for(int i=0; i<list.size(); i++) {
    			if(list.get(i).getDday() <= 10) {
    				fList.add(list.get(i));
    			}
    		}
    		sessionVO.setMacDateResultList(fList); 
    		
    		session.setAttribute("session", sessionVO);
    		
    		mv.setViewName("redirect:home.do");
    		
    	}else {
    		mv.addObject("loginFailMsg", "아이디 또는 비밀번호 불일치");
    	    mv.setViewName("mes/member/loginForm");
    	}
    	return mv;
    }
    
    
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
    
    /**
	 * ERP_EMP 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 ErpEmpDefaultVO
	 * @return "/erpEmp/ErpEmpList"
	 * @exception Exception
	 */
    @RequestMapping(value="/erpEmp/ErpEmpList.do")
    public String selectErpEmpList(@ModelAttribute("searchVO") ErpEmpVO searchVO, 
    		ModelMap model)
            throws Exception {
    	
    	/** EgovPropertyService.sample */
    	searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	searchVO.setPageSize(propertiesService.getInt("pageSize"));
    	
    	/** pageing */
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
        List<?> erpEmpList = erpEmpService.selectErpEmpList(searchVO);
        model.addAttribute("resultList", erpEmpList);
        
        int totCnt = erpEmpService.selectErpEmpListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "/erpEmp/ErpEmpList";
    } 
    
    @RequestMapping("/erpEmp/addErpEmpView.do")
    public String addErpEmpView(
            @ModelAttribute("searchVO") ErpEmpVO searchVO, Model model)
            throws Exception {
        model.addAttribute("erpEmpVO", new ErpEmpVO());
        return "/erpEmp/ErpEmpRegister";
    }
    
    @RequestMapping("/erpEmp/addErpEmp.do")
    public String addErpEmp(
            ErpEmpVO erpEmpVO,
            @ModelAttribute("searchVO") ErpEmpVO searchVO, SessionStatus status)
            throws Exception {
        erpEmpService.insertErpEmp(erpEmpVO);
        status.setComplete();
        return "forward:/erpEmp/ErpEmpList.do";
    }
    

    @RequestMapping("/erpEmp/updateErpEmp.do")
    public String updateErpEmp(
            ErpEmpVO erpEmpVO,
            @ModelAttribute("searchVO") ErpEmpVO searchVO, SessionStatus status)
            throws Exception {
        erpEmpService.updateErpEmp(erpEmpVO);
        status.setComplete();
        return "forward:/erpEmp/ErpEmpList.do";
    }
    
    @RequestMapping("/erpEmp/deleteErpEmp.do")
    public String deleteErpEmp(
            ErpEmpVO erpEmpVO,
            @ModelAttribute("searchVO") ErpEmpVO searchVO, SessionStatus status)
            throws Exception {
        erpEmpService.deleteErpEmp(erpEmpVO);
        status.setComplete();
        return "forward:/erpEmp/ErpEmpList.do";
    }

}

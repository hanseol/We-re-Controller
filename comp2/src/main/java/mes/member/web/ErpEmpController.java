package mes.member.web;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import mes.member.service.ErpEmpService;
import mes.member.service.ErpEmpVO;

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
    
    @RequestMapping("/erpEmp/updateErpEmpView.do")
    public String updateErpEmpView(
            @RequestParam("erpEmployeeId") java.math.BigDecimal erpEmployeeId ,
            @ModelAttribute("searchVO") ErpEmpVO searchVO, Model model)
            throws Exception {
        ErpEmpVO erpEmpVO = new ErpEmpVO();
        erpEmpVO.setErpEmployeeId(erpEmployeeId);
        // 변수명은 CoC 에 따라 erpEmpVO
        model.addAttribute(selectErpEmp(erpEmpVO, searchVO));
        return "/erpEmp/ErpEmpRegister";
    }

    @RequestMapping("/erpEmp/selectErpEmp.do")
    public @ModelAttribute("erpEmpVO")
    ErpEmpVO selectErpEmp(
            ErpEmpVO erpEmpVO,
            @ModelAttribute("searchVO") ErpEmpVO searchVO) throws Exception {
        return erpEmpService.selectErpEmp(erpEmpVO);
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

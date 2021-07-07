package mes.pro.proc.web;

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

import mes.pro.proc.service.ProProcessService;
import mes.pro.proc.service.ProProcessDefaultVO;
import mes.pro.proc.service.ProProcessVO;

/**
 * @Class Name : ProProcessController.java
 * @Description : ProProcess Controller class
 * @Modification Information
 *
 * @author dahee
 * @since 20210707
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
@SessionAttributes(types=ProProcessVO.class)
public class ProProcessController {

    @Resource(name = "proProcessService")
    private ProProcessService proProcessService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	
    /**
	 * PRO_PROCESS 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 ProProcessDefaultVO
	 * @return "/proProcess/ProProcessList"
	 * @exception Exception
	 */
    @RequestMapping(value="/proProcess/ProProcessList.do")
    public String selectProProcessList(@ModelAttribute("searchVO") ProProcessDefaultVO searchVO, 
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
		
        List<?> proProcessList = proProcessService.selectProProcessList(searchVO);
        model.addAttribute("resultList", proProcessList);
        
        int totCnt = proProcessService.selectProProcessListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "/proProcess/ProProcessList";
    } 
    
    @RequestMapping("/proProcess/addProProcessView.do")
    public String addProProcessView(
            @ModelAttribute("searchVO") ProProcessDefaultVO searchVO, Model model)
            throws Exception {
        model.addAttribute("proProcessVO", new ProProcessVO());
        return "/proProcess/ProProcessRegister";
    }
    
    @RequestMapping("/proProcess/addProProcess.do")
    public String addProProcess(
            ProProcessVO proProcessVO,
            @ModelAttribute("searchVO") ProProcessDefaultVO searchVO, SessionStatus status)
            throws Exception {
        proProcessService.insertProProcess(proProcessVO);
        status.setComplete();
        return "forward:/proProcess/ProProcessList.do";
    }
    
    @RequestMapping("/proProcess/updateProProcessView.do")
    public String updateProProcessView(
            @RequestParam("comProcessCode") java.lang.String comProcessCode ,
            @RequestParam("proOrderDetailCode") java.lang.String proOrderDetailCode ,
            @ModelAttribute("searchVO") ProProcessDefaultVO searchVO, Model model)
            throws Exception {
        ProProcessVO proProcessVO = new ProProcessVO();
        proProcessVO.setComProcessCode(comProcessCode);
        proProcessVO.setProOrderDetailCode(proOrderDetailCode);
        // 변수명은 CoC 에 따라 proProcessVO
        model.addAttribute(selectProProcess(proProcessVO, searchVO));
        return "/proProcess/ProProcessRegister";
    }

    @RequestMapping("/proProcess/selectProProcess.do")
    public @ModelAttribute("proProcessVO")
    ProProcessVO selectProProcess(
            ProProcessVO proProcessVO,
            @ModelAttribute("searchVO") ProProcessDefaultVO searchVO) throws Exception {
        return proProcessService.selectProProcess(proProcessVO);
    }

    @RequestMapping("/proProcess/updateProProcess.do")
    public String updateProProcess(
            ProProcessVO proProcessVO,
            @ModelAttribute("searchVO") ProProcessDefaultVO searchVO, SessionStatus status)
            throws Exception {
        proProcessService.updateProProcess(proProcessVO);
        status.setComplete();
        return "forward:/proProcess/ProProcessList.do";
    }
    
    @RequestMapping("/proProcess/deleteProProcess.do")
    public String deleteProProcess(
            ProProcessVO proProcessVO,
            @ModelAttribute("searchVO") ProProcessDefaultVO searchVO, SessionStatus status)
            throws Exception {
        proProcessService.deleteProProcess(proProcessVO);
        status.setComplete();
        return "forward:/proProcess/ProProcessList.do";
    }

}

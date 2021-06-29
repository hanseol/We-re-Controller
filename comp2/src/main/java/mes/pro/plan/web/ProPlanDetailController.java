package mes.pro.plan.web;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import mes.pro.plan.service.ProPlanDetailService;
import mes.pro.plan.service.ProPlanDetailVO;

/**
 * @Class Name : ProPlanDetailController.java
 * @Description : ProPlanDetail Controller class
 * @Modification Information
 *
 * @author dahee
 * @since 20210628
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
public class ProPlanDetailController {

    @Resource(name = "proPlanDetailService")
    private ProPlanDetailService proPlanDetailService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	
    /**
	 * PRO_PLAN_DETAIL 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 ProPlanDetailDefaultVO
	 * @return "/proPlanDetail/ProPlanDetailList"
	 * @exception Exception
	 */
    @RequestMapping(value="proPlanDetail/ProPlanDetailList.do")
    public String selectProPlanDetailList(@ModelAttribute("searchVO") ProPlanDetailVO searchVO, 
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
		
        List<?> proPlanDetailList = proPlanDetailService.selectProPlanDetailList(searchVO);
        model.addAttribute("resultList", proPlanDetailList);
        
        int totCnt = proPlanDetailService.selectProPlanDetailListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "mes/proPlanDetail/ProPlanDetailList.page";
    } 
    
    @RequestMapping("proPlanDetail/addProPlanDetailView.do")
    public String addProPlanDetailView(
            @ModelAttribute("searchVO") ProPlanDetailVO searchVO, Model model)
            throws Exception {
        model.addAttribute("proPlanDetailVO", new ProPlanDetailVO());
        return "mes/proPlanDetail/ProPlanDetailRegister.page";
    }
    
    @RequestMapping("proPlanDetail/addProPlanDetail.do")
    public String addProPlanDetail(
            ProPlanDetailVO proPlanDetailVO,
            @ModelAttribute("searchVO") ProPlanDetailVO searchVO, SessionStatus status)
            throws Exception {
        proPlanDetailService.insertProPlanDetail(proPlanDetailVO);
        status.setComplete();
        return "forward:/proPlanDetail/ProPlanDetailList.do";
    }
    
    @RequestMapping("proPlanDetail/updateProPlanDetailView.do")
    public String updateProPlanDetailView(
            @RequestParam("proPlanDetailCode") java.lang.String proPlanDetailCode ,
            @ModelAttribute("searchVO") ProPlanDetailVO searchVO, Model model)
            throws Exception {
        ProPlanDetailVO proPlanDetailVO = new ProPlanDetailVO();
        proPlanDetailVO.setProPlanDetailCode(proPlanDetailCode);
        // 변수명은 CoC 에 따라 proPlanDetailVO
        model.addAttribute(selectProPlanDetail(proPlanDetailVO, searchVO));
        return "mes/proPlanDetail/ProPlanDetailRegister.page";
    }

    @RequestMapping("proPlanDetail/selectProPlanDetail.do")
    public @ModelAttribute("proPlanDetailVO")
    ProPlanDetailVO selectProPlanDetail(
            ProPlanDetailVO proPlanDetailVO,
            @ModelAttribute("searchVO") ProPlanDetailVO searchVO) throws Exception {
        return proPlanDetailService.selectProPlanDetail(proPlanDetailVO);
    }

    @RequestMapping("proPlanDetail/updateProPlanDetail.do")
    public String updateProPlanDetail(
            ProPlanDetailVO proPlanDetailVO,
            @ModelAttribute("searchVO") ProPlanDetailVO searchVO, SessionStatus status)
            throws Exception {
        proPlanDetailService.updateProPlanDetail(proPlanDetailVO);
        status.setComplete();
        return "forward:/proPlanDetail/ProPlanDetailList.do";
    }
    
    @RequestMapping("proPlanDetail/deleteProPlanDetail.do")
    public String deleteProPlanDetail(
            ProPlanDetailVO proPlanDetailVO,
            @ModelAttribute("searchVO") ProPlanDetailVO searchVO, SessionStatus status)
            throws Exception {
        proPlanDetailService.deleteProPlanDetail(proPlanDetailVO);
        status.setComplete();
        return "forward:/proPlanDetail/ProPlanDetailList.do";
    }

}

package mes.pro.plan.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import mes.pro.plan.service.ProPlanService;
import mes.pro.plan.service.ProPlanDefaultVO;
import mes.pro.plan.service.ProPlanVO;

/**
 * @Class Name : ProPlanController.java
 * @Description : ProPlan Controller class
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
@SessionAttributes(types=ProPlanVO.class)
public class ProPlanController {
	
	
//	@PutMapping("/ajax/updateCode")
//	@ResponseBody
//	public Map updateCode(@RequestBody GridData gridData) {
//		System.out.println(gridData.u);
//	}
	

    @Resource(name = "proPlanService")
    private ProPlanService proPlanService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	
    /**
	 * PRO_PLAN 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 ProPlanDefaultVO
	 * @return "/proPlan/ProPlanList"
	 * @exception Exception
	 */
    //생산계획조회 페이지로 이동
    @RequestMapping(value="proPlan/ProdPlanView.do")
    public String selectProPlanList(@ModelAttribute("searchVO") ProPlanDefaultVO searchVO, 
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
		
        List<?> proPlanList = proPlanService.selectProPlanList(searchVO);
        model.addAttribute("resultList", proPlanList);
        
        int totCnt = proPlanService.selectProPlanListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "mes/pro/plan/ProdPlanView.page";
    } 
    
    //생산계획폼으로 이동 
    @RequestMapping("proPlan/prodPlanForm.do")
    public String addProPlanView(
            @ModelAttribute("searchVO") ProPlanDefaultVO searchVO, Model model)
            throws Exception {
        model.addAttribute("proPlanVO", new ProPlanVO());
        return "mes/pro/plan/prodPlanForm.page";
    }
    
    @RequestMapping("proPlan/addProPlan.do")
    public String addProPlan(
            ProPlanVO proPlanVO,
            @ModelAttribute("searchVO") ProPlanDefaultVO searchVO, SessionStatus status)
            throws Exception {
        proPlanService.insertProPlan(proPlanVO);
        status.setComplete();
        return "forward:/proPlan/ProdPlanView.do";
    }
    
    @RequestMapping("proPlan/updateProPlanView.do")
    public String updateProPlanView(
            @RequestParam("proPlanCode") java.lang.String proPlanCode ,
            @ModelAttribute("searchVO") ProPlanDefaultVO searchVO, Model model)
            throws Exception {
        ProPlanVO proPlanVO = new ProPlanVO();
        proPlanVO.setProPlanCode(proPlanCode);
        // 변수명은 CoC 에 따라 proPlanVO
        model.addAttribute(selectProPlan(proPlanVO, searchVO));
        return "mes/pro/plan/prodPlanForm.page";
    }

    @RequestMapping("proPlan/selectProPlan.do")
    public @ModelAttribute("proPlanVO")
    ProPlanVO selectProPlan(
            ProPlanVO proPlanVO,
            @ModelAttribute("searchVO") ProPlanDefaultVO searchVO) throws Exception {
        return proPlanService.selectProPlan(proPlanVO);
    }

    @RequestMapping("proPlan/updateProPlan.do")
    public String updateProPlan(
            ProPlanVO proPlanVO,
            @ModelAttribute("searchVO") ProPlanDefaultVO searchVO, SessionStatus status)
            throws Exception {
        proPlanService.updateProPlan(proPlanVO);
        status.setComplete();
        return "forward:/proPlan/ProdPlanView.do";
    }
    
    @RequestMapping("proPlan/deleteProPlan.do")
    public String deleteProPlan(
            ProPlanVO proPlanVO,
            @ModelAttribute("searchVO") ProPlanDefaultVO searchVO, SessionStatus status)
            throws Exception {
        proPlanService.deleteProPlan(proPlanVO);
        status.setComplete();
        return "forward:/proPlan/ProdPlanView.do";
    }

}

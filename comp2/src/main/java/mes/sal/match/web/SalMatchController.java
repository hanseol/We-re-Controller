package mes.sal.match.web;

import java.util.LinkedHashMap;
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
import mes.sal.match.service.SalMatchService;
import mes.sal.match.service.SalMatchVO;

/**
 * @Class Name : SalMatchController.java
 * @Description : SalMatch Controller class
 * @Modification Information
 *
 * @author hk
 * @since 2021-06-29
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
@SessionAttributes(types=SalMatchVO.class)
public class SalMatchController {

    @Resource(name = "salMatchService")
    private SalMatchService salMatchService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	
    /**
	 * SAL_MATCH 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 SalMatchDefaultVO
	 * @return "/salMatch/SalMatchList"
	 * @exception Exception
	 */
    @RequestMapping(value="/salMatch/SalMatchList.do")
    public String selectSalMatchList(@ModelAttribute("searchVO") SalMatchVO searchVO, 
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
		
        List<?> salMatchList = salMatchService.selectSalMatchList(searchVO);
        model.addAttribute("resultList", salMatchList);
        
        int totCnt = salMatchService.selectSalMatchListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "/salMatch/SalMatchList";
    } 
    
    @RequestMapping("/salMatch/addSalMatchView.do")
    public String addSalMatchView(
            @ModelAttribute("searchVO") LinkedHashMap searchVO, Model model)
            throws Exception {
        model.addAttribute("salMatchVO", new LinkedHashMap());
        return "/salMatch/SalMatchRegister";
    }
    
    @RequestMapping("/salMatch/addSalMatch.do")
    public String addSalMatch(
    		LinkedHashMap salMatchVO,
            @ModelAttribute("searchVO") LinkedHashMap searchVO, SessionStatus status)
            throws Exception {
        salMatchService.insertSalMatch(salMatchVO);
        status.setComplete();
        return "forward:/salMatch/SalMatchList.do";
    }
    
    @RequestMapping("/salMatch/updateSalMatchView.do")
    public String updateSalMatchView(
            @RequestParam("salMatchStatement") java.lang.String salMatchStatement ,
            @ModelAttribute("searchVO") SalMatchVO searchVO, Model model)
            throws Exception {
        SalMatchVO salMatchVO = new SalMatchVO();
        salMatchVO.setSalMatchStatement(salMatchStatement);
        // 변수명은 CoC 에 따라 salMatchVO
        model.addAttribute(selectSalMatch(salMatchVO, searchVO));
        return "/salMatch/SalMatchRegister";
    }

    @RequestMapping("/salMatch/selectSalMatch.do")
    public @ModelAttribute("salMatchVO")
    SalMatchVO selectSalMatch(
            SalMatchVO salMatchVO,
            @ModelAttribute("searchVO") SalMatchVO searchVO) throws Exception {
        return salMatchService.selectSalMatch(salMatchVO);
    }

    @RequestMapping("/salMatch/updateSalMatch.do")
    public String updateSalMatch(
    		LinkedHashMap salMatchVO,
            @ModelAttribute("searchVO") LinkedHashMap searchVO, SessionStatus status)
            throws Exception {
        salMatchService.updateSalMatch(salMatchVO);
        status.setComplete();
        return "forward:/salMatch/SalMatchList.do";
    }
    
    @RequestMapping("/salMatch/deleteSalMatch.do")
    public String deleteSalMatch(
    		LinkedHashMap salMatchVO,
            @ModelAttribute("searchVO") LinkedHashMap searchVO, SessionStatus status)
            throws Exception {
        salMatchService.deleteSalMatch(salMatchVO);
        status.setComplete();
        return "forward:/salMatch/SalMatchList.do";
    }

}

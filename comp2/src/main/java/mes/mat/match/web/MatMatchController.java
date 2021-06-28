package mes.mat.match.web;

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

import mes.mat.match.service.MatMatchService;
import mes.mat.match.service.MatMatchDefaultVO;
import mes.mat.match.service.MatMatchVO;

/**
 * @Class Name : MatMatchController.java
 * @Description : MatMatch Controller class
 * @Modification Information
 *
 * @author sungwon
 * @since 20210625
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
@SessionAttributes(types=MatMatchVO.class)
public class MatMatchController {

    @Resource(name = "matMatchService")
    private MatMatchService matMatchService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	
    /**
	 * MAT_MATCH 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 MatMatchDefaultVO
	 * @return "/matMatch/MatMatchList"
	 * @exception Exception
	 */
    @RequestMapping(value="/matMatch/MatMatchList.do")
    public String selectMatMatchList(@ModelAttribute("searchVO") MatMatchDefaultVO searchVO, 
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
		
        List<?> matMatchList = matMatchService.selectMatMatchList(searchVO);
        model.addAttribute("resultList", matMatchList);
        
        int totCnt = matMatchService.selectMatMatchListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "mes/matMatch/MatMatchList.page";
    } 
    
    @RequestMapping("/matMatch/addMatMatchView.do")
    public String addMatMatchView(
            @ModelAttribute("searchVO") MatMatchDefaultVO searchVO, Model model)
            throws Exception {
        model.addAttribute("matMatchVO", new MatMatchVO());
        return "mes/matMatch/MatMatchRegister.page";
    }
    
    @RequestMapping("/matMatch/addMatMatch.do")
    public String addMatMatch(
            MatMatchVO matMatchVO,
            @ModelAttribute("searchVO") MatMatchDefaultVO searchVO, SessionStatus status)
            throws Exception {
        matMatchService.insertMatMatch(matMatchVO);
        status.setComplete();
        return "forward:/matMatch/MatMatchList.do";
    }
    
    @RequestMapping("/matMatch/updateMatMatchView.do")
    public String updateMatMatchView(
            @RequestParam("matMatchStatement") java.lang.String matMatchStatement ,
            @ModelAttribute("searchVO") MatMatchDefaultVO searchVO, Model model)
            throws Exception {
        MatMatchVO matMatchVO = new MatMatchVO();
        matMatchVO.setMatMatchStatement(matMatchStatement);
        // 변수명은 CoC 에 따라 matMatchVO
        model.addAttribute(selectMatMatch(matMatchVO, searchVO));
        return "mes/matMatch/MatMatchRegister.page";
    }

    @RequestMapping("/matMatch/selectMatMatch.do")
    public @ModelAttribute("matMatchVO")
    MatMatchVO selectMatMatch(
            MatMatchVO matMatchVO,
            @ModelAttribute("searchVO") MatMatchDefaultVO searchVO) throws Exception {
        return matMatchService.selectMatMatch(matMatchVO);
    }

    @RequestMapping("/matMatch/updateMatMatch.do")
    public String updateMatMatch(
            MatMatchVO matMatchVO,
            @ModelAttribute("searchVO") MatMatchDefaultVO searchVO, SessionStatus status)
            throws Exception {
        matMatchService.updateMatMatch(matMatchVO);
        status.setComplete();
        return "forward:/matMatch/MatMatchList.do";
    }
    
    @RequestMapping("/matMatch/deleteMatMatch.do")
    public String deleteMatMatch(
            MatMatchVO matMatchVO,
            @ModelAttribute("searchVO") MatMatchDefaultVO searchVO, SessionStatus status)
            throws Exception {
        matMatchService.deleteMatMatch(matMatchVO);
        status.setComplete();
        return "forward:/matMatch/MatMatchList.do";
    }
    
    
    @RequestMapping("test.do")
    public String test() {
    	
    	return "mes/matMatch/MatMatchRegister.page";
    }

}

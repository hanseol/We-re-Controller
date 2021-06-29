package mes.mat.inout.web;

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
import mes.mat.inout.service.MatInoutDefaultVO;
import mes.mat.inout.service.MatInoutService;
import mes.mat.inout.service.MatInoutVO;

/**
 * @Class Name : MatInoutController.java
 * @Description : MatInout Controller class
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
@SessionAttributes(types=MatInoutVO.class)
public class MatInoutController {

    @Resource(name = "matInoutService")
    private MatInoutService matInoutService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	
    /**
	 * MAT_INOUT 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 MatInoutDefaultVO
	 * @return "/matInout/MatInoutList"
	 * @exception Exception
	 */
    @RequestMapping(value="/matInout/matrInoutView.do")
    public String selectMatInoutList(@ModelAttribute("searchVO") MatInoutDefaultVO searchVO, 
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
		
        List<?> matInoutList = matInoutService.selectInoutList(searchVO);
        model.addAttribute("selectInoutList", matInoutList);
        
        int totCnt = matInoutService.selectMatInoutListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "mes/matInout/matrInoutView.page";
    }
    
    @RequestMapping("/matInout/addMatInoutView.do")
    public String addMatInoutView(
            @ModelAttribute("searchVO") MatInoutDefaultVO searchVO, Model model)
            throws Exception {
        model.addAttribute("matInoutVO", new MatInoutVO());
        return "mes/matInout/MatInoutRegister.page";
    }
    
    @RequestMapping("/matInout/addMatInout.do")
    public String addMatInout(
            MatInoutVO matInoutVO,
            @ModelAttribute("searchVO") MatInoutDefaultVO searchVO, SessionStatus status)
            throws Exception {
        matInoutService.insertMatInout(matInoutVO);
        status.setComplete();
        return "forward:/matInout/MatInoutList.do";
    }
    
    @RequestMapping("/matInout/updateMatInoutView.do")
    public String updateMatInoutView(
            @RequestParam("matInoutStatement") java.lang.String matInoutStatement ,
            @ModelAttribute("searchVO") MatInoutDefaultVO searchVO, Model model)
            throws Exception {
        MatInoutVO matInoutVO = new MatInoutVO();
        matInoutVO.setMatInoutStatement(matInoutStatement);
        // 변수명은 CoC 에 따라 matInoutVO
        model.addAttribute(selectMatInout(matInoutVO, searchVO));
        return "mes/matInout/MatInoutRegister.page";
    }

    @RequestMapping("/matInout/selectMatInout.do")
    public @ModelAttribute("matInoutVO")
    MatInoutVO selectMatInout(
            MatInoutVO matInoutVO,
            @ModelAttribute("searchVO") MatInoutDefaultVO searchVO) throws Exception {
        return matInoutService.selectMatInout(matInoutVO);
    }

    @RequestMapping("/matInout/updateMatInout.do")
    public String updateMatInout(
            MatInoutVO matInoutVO,
            @ModelAttribute("searchVO") MatInoutDefaultVO searchVO, SessionStatus status)
            throws Exception {
        matInoutService.updateMatInout(matInoutVO);
        status.setComplete();
        return "forward:/matInout/MatInoutList.do";
    }
    
    @RequestMapping("/matInout/deleteMatInout.do")
    public String deleteMatInout(
            MatInoutVO matInoutVO,
            @ModelAttribute("searchVO") MatInoutDefaultVO searchVO, SessionStatus status)
            throws Exception {
        matInoutService.deleteMatInout(matInoutVO);
        status.setComplete();
        return "forward:/matInout/MatInoutList.do";
    }
    
    

}

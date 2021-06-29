package mes.qua.chk.web;

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

import mes.qua.chk.service.QuaMaterialChkService;
import mes.qua.chk.service.QuaMaterialChkDefaultVO;
import mes.qua.chk.service.QuaMaterialChkVO;

/**
 * @Class Name : QuaMaterialChkController.java
 * @Description : QuaMaterialChk Controller class
 * @Modification Information
 *
 * @author sungwon
 * @since 20210629
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
@SessionAttributes(types=QuaMaterialChkVO.class)
public class QuaMaterialChkController {

    @Resource(name = "quaMaterialChkService")
    private QuaMaterialChkService quaMaterialChkService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	
    /**
	 * QUA_MATERIAL_CHK 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 QuaMaterialChkDefaultVO
	 * @return "/quaMaterialChk/QuaMaterialChkList"
	 * @exception Exception
	 */
    @RequestMapping(value="/quaMaterialChk/QuaMaterialChkList.do")
    public String selectQuaMaterialChkList(@ModelAttribute("searchVO") QuaMaterialChkDefaultVO searchVO, 
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
		
        List<?> quaMaterialChkList = quaMaterialChkService.selectQuaMaterialChkList(searchVO);
        model.addAttribute("resultList", quaMaterialChkList);
        
        int totCnt = quaMaterialChkService.selectQuaMaterialChkListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "/quaMaterialChk/QuaMaterialChkList";
    } 
    
    @RequestMapping("/quaMaterialChk/addQuaMaterialChkView.do")
    public String addQuaMaterialChkView(
            @ModelAttribute("searchVO") QuaMaterialChkDefaultVO searchVO, Model model)
            throws Exception {
        model.addAttribute("quaMaterialChkVO", new QuaMaterialChkVO());
        return "/quaMaterialChk/QuaMaterialChkRegister";
    }
    
    @RequestMapping("/quaMaterialChk/addQuaMaterialChk.do")
    public String addQuaMaterialChk(
            QuaMaterialChkVO quaMaterialChkVO,
            @ModelAttribute("searchVO") QuaMaterialChkDefaultVO searchVO, SessionStatus status)
            throws Exception {
        quaMaterialChkService.insertQuaMaterialChk(quaMaterialChkVO);
        status.setComplete();
        return "forward:/quaMaterialChk/QuaMaterialChkList.do";
    }
    
    @RequestMapping("/quaMaterialChk/updateQuaMaterialChkView.do")
    public String updateQuaMaterialChkView(
            @RequestParam("quaMaterialStatement") java.lang.String quaMaterialStatement ,
            @ModelAttribute("searchVO") QuaMaterialChkDefaultVO searchVO, Model model)
            throws Exception {
        QuaMaterialChkVO quaMaterialChkVO = new QuaMaterialChkVO();
        quaMaterialChkVO.setQuaMaterialStatement(quaMaterialStatement);
        // 변수명은 CoC 에 따라 quaMaterialChkVO
        model.addAttribute(selectQuaMaterialChk(quaMaterialChkVO, searchVO));
        return "/quaMaterialChk/QuaMaterialChkRegister";
    }

    @RequestMapping("/quaMaterialChk/selectQuaMaterialChk.do")
    public @ModelAttribute("quaMaterialChkVO")
    QuaMaterialChkVO selectQuaMaterialChk(
            QuaMaterialChkVO quaMaterialChkVO,
            @ModelAttribute("searchVO") QuaMaterialChkDefaultVO searchVO) throws Exception {
        return quaMaterialChkService.selectQuaMaterialChk(quaMaterialChkVO);
    }

    @RequestMapping("/quaMaterialChk/updateQuaMaterialChk.do")
    public String updateQuaMaterialChk(
            QuaMaterialChkVO quaMaterialChkVO,
            @ModelAttribute("searchVO") QuaMaterialChkDefaultVO searchVO, SessionStatus status)
            throws Exception {
        quaMaterialChkService.updateQuaMaterialChk(quaMaterialChkVO);
        status.setComplete();
        return "forward:/quaMaterialChk/QuaMaterialChkList.do";
    }
    
    @RequestMapping("/quaMaterialChk/deleteQuaMaterialChk.do")
    public String deleteQuaMaterialChk(
            QuaMaterialChkVO quaMaterialChkVO,
            @ModelAttribute("searchVO") QuaMaterialChkDefaultVO searchVO, SessionStatus status)
            throws Exception {
        quaMaterialChkService.deleteQuaMaterialChk(quaMaterialChkVO);
        status.setComplete();
        return "forward:/quaMaterialChk/QuaMaterialChkList.do";
    }

}

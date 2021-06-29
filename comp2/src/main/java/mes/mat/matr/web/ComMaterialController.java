package mes.mat.matr.web;

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
import mes.mat.matr.service.ComMaterialDefaultVO;
import mes.mat.matr.service.ComMaterialService;
import mes.mat.matr.service.ComMaterialVO;

/**
 * @Class Name : ComMaterialController.java
 * @Description : ComMaterial Controller class
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
@SessionAttributes(types=ComMaterialVO.class)
public class ComMaterialController {

    @Resource(name = "comMaterialService")
    private ComMaterialService comMaterialService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	
    /**
	 * COM_MATERIAL 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 ComMaterialDefaultVO
	 * @return "/comMaterial/ComMaterialList"
	 * @exception Exception
	 */
    @RequestMapping(value="/comMaterial/ComMaterialList.do")
    public String selectComMaterialList(@ModelAttribute("searchVO") ComMaterialDefaultVO searchVO, 
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
		
        List<?> comMaterialList = comMaterialService.selectMatList(searchVO);
        model.addAttribute("selectMatList", comMaterialList);
        
        int totCnt = comMaterialService.selectComMaterialListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "mes/comMaterial/matrView.page";
    } 
    
    @RequestMapping("/comMaterial/addComMaterialView.do")
    public String addComMaterialView(
            @ModelAttribute("searchVO") ComMaterialDefaultVO searchVO, Model model)
            throws Exception {
        model.addAttribute("comMaterialVO", new ComMaterialVO());
        return "/comMaterial/ComMaterialRegister";
    }
    
    @RequestMapping("/comMaterial/addComMaterial.do")
    public String addComMaterial(
            ComMaterialVO comMaterialVO,
            @ModelAttribute("searchVO") ComMaterialDefaultVO searchVO, SessionStatus status)
            throws Exception {
        comMaterialService.insertComMaterial(comMaterialVO);
        status.setComplete();
        return "forward:/comMaterial/ComMaterialList.do";
    }
    
    @RequestMapping("/comMaterial/updateComMaterialView.do")
    public String updateComMaterialView(
            @RequestParam("comMaterialCode") java.lang.String comMaterialCode ,
            @ModelAttribute("searchVO") ComMaterialDefaultVO searchVO, Model model)
            throws Exception {
        ComMaterialVO comMaterialVO = new ComMaterialVO();
        comMaterialVO.setComMaterialCode(comMaterialCode);
        // 변수명은 CoC 에 따라 comMaterialVO
        model.addAttribute(selectComMaterial(comMaterialVO, searchVO));
        return "/comMaterial/ComMaterialRegister";
    }

    @RequestMapping("/comMaterial/selectComMaterial.do")
    public @ModelAttribute("comMaterialVO")
    ComMaterialVO selectComMaterial(
            ComMaterialVO comMaterialVO,
            @ModelAttribute("searchVO") ComMaterialDefaultVO searchVO) throws Exception {
        return comMaterialService.selectComMaterial(comMaterialVO);
    }

    @RequestMapping("/comMaterial/updateComMaterial.do")
    public String updateComMaterial(
            ComMaterialVO comMaterialVO,
            @ModelAttribute("searchVO") ComMaterialDefaultVO searchVO, SessionStatus status)
            throws Exception {
        comMaterialService.updateComMaterial(comMaterialVO);
        status.setComplete();
        return "forward:/comMaterial/ComMaterialList.do";
    }
    
    @RequestMapping("/comMaterial/deleteComMaterial.do")
    public String deleteComMaterial(
            ComMaterialVO comMaterialVO,
            @ModelAttribute("searchVO") ComMaterialDefaultVO searchVO, SessionStatus status)
            throws Exception {
        comMaterialService.deleteComMaterial(comMaterialVO);
        status.setComplete();
        return "forward:/comMaterial/ComMaterialList.do";
    }

}

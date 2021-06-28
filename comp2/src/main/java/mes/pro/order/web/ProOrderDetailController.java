package mes.pro.order.web;

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

import mes.pro.order.service.ProOrderDetailService;
import mes.pro.order.service.ProOrderDetailDefaultVO;
import mes.pro.order.service.ProOrderDetailVO;

/**
 * @Class Name : ProOrderDetailController.java
 * @Description : ProOrderDetail Controller class
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
@SessionAttributes(types=ProOrderDetailVO.class)
public class ProOrderDetailController {

    @Resource(name = "proOrderDetailService")
    private ProOrderDetailService proOrderDetailService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	
    /**
	 * PRO_ORDER_DETAIL 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 ProOrderDetailDefaultVO
	 * @return "/proOrderDetail/ProOrderDetailList"
	 * @exception Exception
	 */
    @RequestMapping(value="/proOrderDetail/ProOrderDetailList.do")
    public String selectProOrderDetailList(@ModelAttribute("searchVO") ProOrderDetailDefaultVO searchVO, 
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
		
        List<?> proOrderDetailList = proOrderDetailService.selectProOrderDetailList(searchVO);
        model.addAttribute("resultList", proOrderDetailList);
        
        int totCnt = proOrderDetailService.selectProOrderDetailListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "mes/proOrderDetail/ProOrderDetailList.page";
    } 
    
    @RequestMapping("/proOrderDetail/addProOrderDetailView.do")
    public String addProOrderDetailView(
            @ModelAttribute("searchVO") ProOrderDetailDefaultVO searchVO, Model model)
            throws Exception {
        model.addAttribute("proOrderDetailVO", new ProOrderDetailVO());
        return "mes/proOrderDetail/ProOrderDetailRegister.page";
    }
    
    @RequestMapping("/proOrderDetail/addProOrderDetail.do")
    public String addProOrderDetail(
            ProOrderDetailVO proOrderDetailVO,
            @ModelAttribute("searchVO") ProOrderDetailDefaultVO searchVO, SessionStatus status)
            throws Exception {
        proOrderDetailService.insertProOrderDetail(proOrderDetailVO);
        status.setComplete();
        return "forward:/proOrderDetail/ProOrderDetailList.do";
    }
    
    @RequestMapping("/proOrderDetail/updateProOrderDetailView.do")
    public String updateProOrderDetailView(
            @RequestParam("proOrderDetailCode") java.lang.String proOrderDetailCode ,
            @ModelAttribute("searchVO") ProOrderDetailDefaultVO searchVO, Model model)
            throws Exception {
        ProOrderDetailVO proOrderDetailVO = new ProOrderDetailVO();
        proOrderDetailVO.setProOrderDetailCode(proOrderDetailCode);
        // 변수명은 CoC 에 따라 proOrderDetailVO
        model.addAttribute(selectProOrderDetail(proOrderDetailVO, searchVO));
        return "mes/proOrderDetail/ProOrderDetailRegister.page";
    }

    @RequestMapping("/proOrderDetail/selectProOrderDetail.do")
    public @ModelAttribute("proOrderDetailVO")
    ProOrderDetailVO selectProOrderDetail(
            ProOrderDetailVO proOrderDetailVO,
            @ModelAttribute("searchVO") ProOrderDetailDefaultVO searchVO) throws Exception {
        return proOrderDetailService.selectProOrderDetail(proOrderDetailVO);
    }

    @RequestMapping("/proOrderDetail/updateProOrderDetail.do")
    public String updateProOrderDetail(
            ProOrderDetailVO proOrderDetailVO,
            @ModelAttribute("searchVO") ProOrderDetailDefaultVO searchVO, SessionStatus status)
            throws Exception {
        proOrderDetailService.updateProOrderDetail(proOrderDetailVO);
        status.setComplete();
        return "forward:/proOrderDetail/ProOrderDetailList.do";
    }
    
    @RequestMapping("/proOrderDetail/deleteProOrderDetail.do")
    public String deleteProOrderDetail(
            ProOrderDetailVO proOrderDetailVO,
            @ModelAttribute("searchVO") ProOrderDetailDefaultVO searchVO, SessionStatus status)
            throws Exception {
        proOrderDetailService.deleteProOrderDetail(proOrderDetailVO);
        status.setComplete();
        return "forward:/proOrderDetail/ProOrderDetailList.do";
    }

}

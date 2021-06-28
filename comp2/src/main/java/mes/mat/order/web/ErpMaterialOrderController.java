package mes.mat.order.web;

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
import mes.mat.order.service.ErpMaterialOrderDefaultVO;
import mes.mat.order.service.ErpMaterialOrderService;
import mes.mat.order.service.ErpMaterialOrderVO;

/**
 * @Class Name : ErpMaterialOrderController.java
 * @Description : ErpMaterialOrder Controller class
 * @Modification Information
 *
 * @author sungwon
 * @since 20210628
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
@SessionAttributes(types=ErpMaterialOrderVO.class)
public class ErpMaterialOrderController {

    @Resource(name = "erpMaterialOrderService")
    private ErpMaterialOrderService erpMaterialOrderService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	
    /**
	 * ERP_MATERIAL_ORDER 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 ErpMaterialOrderDefaultVO
	 * @return "/erpMaterialOrder/ErpMaterialOrderList"
	 * @exception Exception
	 */
    @RequestMapping(value="/erpMaterialOrder/ErpMaterialOrderList.do")
    public String selectErpMaterialOrderList(@ModelAttribute("searchVO") ErpMaterialOrderDefaultVO searchVO, 
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
		
        List<?> erpMaterialOrderList = erpMaterialOrderService.selectOrderList(searchVO);
        model.addAttribute("resultList", erpMaterialOrderList);
        
        model.addAttribute("selectOrderList", erpMaterialOrderList);
        
        int totCnt = erpMaterialOrderService.selectErpMaterialOrderListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "mes/erpMaterialOrder/matrOrderViews.page";
    } 
    
    @RequestMapping("/erpMaterialOrder/addErpMaterialOrderView.do")
    public String addErpMaterialOrderView(
            @ModelAttribute("searchVO") ErpMaterialOrderDefaultVO searchVO, Model model)
            throws Exception {
        model.addAttribute("erpMaterialOrderVO", new ErpMaterialOrderVO());
        return "/erpMaterialOrder/ErpMaterialOrderRegister";
    }
    
    @RequestMapping("/erpMaterialOrder/addErpMaterialOrder.do")
    public String addErpMaterialOrder(
            ErpMaterialOrderVO erpMaterialOrderVO,
            @ModelAttribute("searchVO") ErpMaterialOrderDefaultVO searchVO, SessionStatus status)
            throws Exception {
        erpMaterialOrderService.insertErpMaterialOrder(erpMaterialOrderVO);
        status.setComplete();
        return "forward:/erpMaterialOrder/ErpMaterialOrderList.do";
    }
    
    @RequestMapping("/erpMaterialOrder/updateErpMaterialOrderView.do")
    public String updateErpMaterialOrderView(
            @RequestParam("erpMaterialOrderCode") java.lang.String erpMaterialOrderCode ,
            @ModelAttribute("searchVO") ErpMaterialOrderDefaultVO searchVO, Model model)
            throws Exception {
        ErpMaterialOrderVO erpMaterialOrderVO = new ErpMaterialOrderVO();
        erpMaterialOrderVO.setErpMaterialOrderCode(erpMaterialOrderCode);
        // 변수명은 CoC 에 따라 erpMaterialOrderVO
        model.addAttribute(selectErpMaterialOrder(erpMaterialOrderVO, searchVO));
        return "/erpMaterialOrder/ErpMaterialOrderRegister";
    }

    @RequestMapping("/erpMaterialOrder/selectErpMaterialOrder.do")
    public @ModelAttribute("erpMaterialOrderVO")
    ErpMaterialOrderVO selectErpMaterialOrder(
            ErpMaterialOrderVO erpMaterialOrderVO,
            @ModelAttribute("searchVO") ErpMaterialOrderDefaultVO searchVO) throws Exception {
        return erpMaterialOrderService.selectErpMaterialOrder(erpMaterialOrderVO);
    }

    @RequestMapping("/erpMaterialOrder/updateErpMaterialOrder.do")
    public String updateErpMaterialOrder(
            ErpMaterialOrderVO erpMaterialOrderVO,
            @ModelAttribute("searchVO") ErpMaterialOrderDefaultVO searchVO, SessionStatus status)
            throws Exception {
        erpMaterialOrderService.updateErpMaterialOrder(erpMaterialOrderVO);
        status.setComplete();
        return "forward:/erpMaterialOrder/ErpMaterialOrderList.do";
    }
    
    @RequestMapping("/erpMaterialOrder/deleteErpMaterialOrder.do")
    public String deleteErpMaterialOrder(
            ErpMaterialOrderVO erpMaterialOrderVO,
            @ModelAttribute("searchVO") ErpMaterialOrderDefaultVO searchVO, SessionStatus status)
            throws Exception {
        erpMaterialOrderService.deleteErpMaterialOrder(erpMaterialOrderVO);
        status.setComplete();
        return "forward:/erpMaterialOrder/ErpMaterialOrderList.do";
    }
    
    @RequestMapping("/erpMaterialOrder/matrOrderView.do")
    public String searchMatrOrder(Model model) {
    	
    	
    	return "mes/erpMaterialOrder/matrOrderViews.page";
    }

}

package mes.pro.order.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import egovframework.rte.fdl.property.EgovPropertyService;

import mes.pro.order.service.ProOrderService;
import mes.pro.order.service.ProOrderVO;

/**
 * @Class Name : ProOrderController.java
 * @Description : ProOrder Controller class
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
public class ProOrderController {

    @Resource(name = "proOrderService")
    private ProOrderService service;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
    
    //테이블 목록 조회
    @RequestMapping("proOrder/ProdView")
    @ResponseBody
    public Map<String, Object> readOrder(Model model, 
    		@ModelAttribute("proOrderVO") ProOrderVO proOrderVO ) throws Exception {

    	int rowSize = 0;
    	List<?> list = new ArrayList<>();
    	
    	//검색조건이 있을 경우
    	if(!proOrderVO.getSearchKeyword().equals("")) {
    	
    		//mapper 조건에 따라 condition 설정 필요함.
    		proOrderVO.setSearchCondition("0");
    		
    		rowSize = service.selectProOrderListTotCnt(proOrderVO);
    		proOrderVO.setLastIndex(rowSize);
        	
        	list = service.selectProOrderList(proOrderVO);
        //검색조건이 없을 경우
    	}else {
    		rowSize = service.selectProOrderListTotCnt(proOrderVO);
    		
    		proOrderVO.setLastIndex(rowSize);
        	
        	list = service.selectProOrderList(proOrderVO);
    	}
    	
    	Map<String, Object> paging = new HashMap<>();
    	paging.put("page", proOrderVO.getPageIndex());
    	paging.put("totalCount", rowSize);
    	
    	Map<String,Object> data = new HashMap<>();
    	data.put("contents", list);
    	data.put("pagination", paging);
    	
    	Map<String,Object> map = new HashMap<>();
    	map.put("result", true);
    	map.put("data", data);
        
    	return map;
    }
    
//    //생산지시 리스트 조회
//    @RequestMapping(value="/proOrder/ProOrderList.do")
//    public String selectProOrderList(@ModelAttribute("searchVO") ProOrderVO searchVO, ModelMap model) throws Exception {
//    	
//    	/** EgovPropertyService.sample */
//    	searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
//    	searchVO.setPageSize(propertiesService.getInt("pageSize"));
//    	
//    	/** pageing */
//    	PaginationInfo paginationInfo = new PaginationInfo();
//		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
//		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
//		paginationInfo.setPageSize(searchVO.getPageSize());
//		
//		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
//		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
//		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
//		
//        List<?> proOrderList = service.selectProOrderList(searchVO);
//        model.addAttribute("resultList", proOrderList);
//        
//        int totCnt = service.selectProOrderListTotCnt(searchVO);
//		paginationInfo.setTotalRecordCount(totCnt);
//        model.addAttribute("paginationInfo", paginationInfo);
//        
//        return "mes/pro/order/prodView.page";
//    } 
    
    
    //생산지시 폼 호출
    @RequestMapping("/proOrder/addProOrderView.do")
    public String addProOrderView(Model model){
       
        return "mes/pro/order/prodForm.page";
    }
    
//    @RequestMapping("/proOrder/addProOrder.do")
//    public String addProOrder(
//            ProOrderVO proOrderVO,
//            @ModelAttribute("searchVO") ProOrderDefaultVO searchVO, SessionStatus status)
//            throws Exception {
//        proOrderService.insertProOrder(proOrderVO);
//        status.setComplete();
//        return "forward:/proOrder/ProOrderList.do";
//    }
//    
//    @RequestMapping("/proOrder/updateProOrderView.do")
//    public String updateProOrderView(
//            @RequestParam("proOrderCode") java.lang.String proOrderCode ,
//            @ModelAttribute("searchVO") ProOrderDefaultVO searchVO, Model model)
//            throws Exception {
//        ProOrderVO proOrderVO = new ProOrderVO();
//        proOrderVO.setProOrderCode(proOrderCode);
//        // 변수명은 CoC 에 따라 proOrderVO
//        model.addAttribute(selectProOrder(proOrderVO, searchVO));
//        return "mes/pro/order/prodForm.page";
//    }
//
//    @RequestMapping("/proOrder/selectProOrder.do")
//    public @ModelAttribute("proOrderVO")
//    ProOrderVO selectProOrder(
//            ProOrderVO proOrderVO,
//            @ModelAttribute("searchVO") ProOrderDefaultVO searchVO) throws Exception {
//        return proOrderService.selectProOrder(proOrderVO);
//    }
//
//    @RequestMapping("/proOrder/updateProOrder.do")
//    public String updateProOrder(
//            ProOrderVO proOrderVO,
//            @ModelAttribute("searchVO") ProOrderDefaultVO searchVO, SessionStatus status)
//            throws Exception {
//        proOrderService.updateProOrder(proOrderVO);
//        status.setComplete();
//        return "forward:/proOrder/ProOrderList.do";
//    }
//    
//    @RequestMapping("/proOrder/deleteProOrder.do")
//    public String deleteProOrder(
//            ProOrderVO proOrderVO,
//            @ModelAttribute("searchVO") ProOrderDefaultVO searchVO, SessionStatus status)
//            throws Exception {
//        proOrderService.deleteProOrder(proOrderVO);
//        status.setComplete();
//        return "forward:/proOrder/ProOrderList.do";
//    }

}

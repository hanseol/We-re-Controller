package mes.pro.order.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import egovframework.rte.fdl.property.EgovPropertyService;
import mes.main.service.ComFunc;
import mes.main.service.GridDataVO;
import mes.pro.order.service.ProOrderService;
import mes.pro.order.service.ProOrderVO;
import mes.pro.plan.service.ProPlanVO;

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
    
    ComFunc comFunc = new ComFunc();

    
    //proView.jsp
      
    //생산지시조회 페이지 호출(prodView.jsp)
    @RequestMapping("proOrder/prodView.do")
    public String prodView(Model model){
        return "mes/pro/order/prodView.page";
    }
    
    //생산지시리스트 조회
    @RequestMapping("proOrder/prodView")
    @ResponseBody
    public Map<String, Object> readOrder(@ModelAttribute("searchVO") ProOrderVO searchVO ) throws Exception {
    	List<?> list = service.selectProOrderList(searchVO);
    	return comFunc.sendResult(list);
    }
    
    
    
    //proForm.jsp
    
    //생산지시관리 페이지 호출(prodForm.jsp)
    @RequestMapping("proOrder/prodForm.do")
    public String prodForm(Model model){
        return "mes/pro/order/prodForm.page";
    }
        
    
    //생산지시관리 페이지에서 리스트 조회
    @RequestMapping("ajax/proOrder/prodFormList")
    @ResponseBody
    public Map<String, Object> readOrderForm(@ModelAttribute("searchVO") ProOrderVO searchVO) throws Exception {
    	List<?> list = service.selectOrderForm(searchVO);
    	return comFunc.sendResult(list);
    }
    
    
    //모달 호출(생산지시코드로 검색)
    @GetMapping("proOrderSearch.do")
    public String proOrderSearch() {
    	return "mes/pro/modal/proOrderSearch";
    }
    
    //모달 값 뿌리기(생산지시코드로 검색)
    @RequestMapping("proOrderSearch")
    @ResponseBody
    public Map<String, Object> proOrderSearch(@ModelAttribute("searchVO") ProPlanVO searchVO) throws Exception {
    	List<?> list = service.selectOrderList(searchVO);
    	ComFunc comFunc = new ComFunc();
    	return comFunc.sendResult(list);
    }
    
    
    //생산지시리스트 추가, 수정, 삭제 (****수정하기)
	@PutMapping("ajax/proOrder/modifyProdOrder")
	@ResponseBody
	public void modifyProdOrder(@RequestBody GridDataVO gd) throws Exception {

		List<?> updatedList = gd.getUpdatedRows();
		List<?> createdList = gd.getCreatedRows();
		List<?> deletedList = gd.getDeletedRows();

		if (updatedList.size() != 0) {
			for (int i = 0; i < updatedList.size(); i++) {
				service.updateProOrder((LinkedHashMap) updatedList.get(i));
			}
		}

		//시퀀스 포멧팅(pro_plan테이블) **수정하기
		if(createdList.size() != 0) { 
			
			for(int i = 0; i < createdList.size(); i++) {
			}
			
		 }

		if (deletedList.size() != 0)
		{
			for (int i = 0; i < deletedList.size(); i++) {
				service.deleteProOrder((LinkedHashMap) deletedList.get(i));
			}
		}
	}
	
}

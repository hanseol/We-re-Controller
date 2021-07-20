package mes.mat.order.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.rte.fdl.property.EgovPropertyService;
import mes.main.service.ComFunc;
import mes.mat.order.service.MatOrderService;
import mes.mat.order.service.MatOrderVO;

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
public class MatOrderController {
	//공통함수 객체 생성
	ComFunc comFunc = new ComFunc();
		
    @Resource(name = "matOrderService")
    private MatOrderService service;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	
//--------------------------------------조회 페이지-------------------------------------
    
    //페이지 넘겨주기
    @RequestMapping("/mat/order/matrOrderView.do")
    public String selectMatOrderList(@ModelAttribute("searchVO") MatOrderVO searchVO, 
    		ModelMap model) {

        return "mes/mat/matOrder/matrOrderView.page";
    }
    //자재입출고조회 리스트
    @RequestMapping("/ajax/readMatOrder")
    @ResponseBody
    public Map<String, Object> MatOrder(Model model, 
    		 @ModelAttribute("searchVO") MatOrderVO searchVO) throws Exception{

    	List<?> list = service.selectMatOrderList(searchVO);
    	
    	//공통함수 객체 생성
    	ComFunc comFunc = new ComFunc();
    	return comFunc.sendResult(list);
    }
//--------------------------------------모달 페이지--------------------------------------
    
    //발주코드 오픈
    @GetMapping("/mat/order/searchMatOrderCode.do")
  	public String searchMaterialCode() {
  		
  		//모달창에 띄워줄 view페이지 전달.
  		return "mes/mat/modal/searchMatOrderCode";
  	}
  	
  	//발주코드 결과 값 전달
  	@RequestMapping("/ajax/searchMatOrder")
  	@ResponseBody
  	public Map<String, Object> searchOrder(Model model, 
     		@ModelAttribute("searchVO") MatOrderVO searchVO) throws Exception {
  		

      	List<?> list = service.searchMatOrderCodeList(searchVO);
      	
      	ComFunc comFunc = new ComFunc();
      	return comFunc.sendResult(list);
  	}
  	
  	
  	
  	
  //순수발주코드 오픈
    @GetMapping("/mat/order/searchMatOrderCodePure.do")
  	public String searchMaterialCodePure() {
  		
  		//모달창에 띄워줄 view페이지 전달.
  		return "mes/mat/modal/searchMatOrderCodePure";
  	}
  	
  	//순수발주코드 결과 값 전달
  	@RequestMapping("/ajax/searchMatOrderPure")
  	@ResponseBody
  	public Map<String, Object> searchOrderPure(Model model, 
     		@ModelAttribute("searchVO") MatOrderVO searchVO) throws Exception {
  		

      	List<?> list = service.searchMatOrderCodePureList(searchVO);
      	
      	ComFunc comFunc = new ComFunc();
      	return comFunc.sendResult(list);
  	}
  	
  	
    //불량이 있는 발주코드 오픈
    @GetMapping("/mat/order/searchMatOrderCodeFlty.do")
  	public String searchMaterialCodeFlty() {
  		
  		//모달창에 띄워줄 view페이지 전달.
  		return "mes/mat/modal/searchMatOrderCodeFlty";
  	}
  	
  	//불량이 있는 발주코드 결과 값 전달
  	@RequestMapping("/ajax/searchMatOrderFlty")
  	@ResponseBody
  	public Map<String, Object> searchOrderFlty(Model model, 
     		@ModelAttribute("searchVO") MatOrderVO searchVO) throws Exception {
  		

      	List<?> list = service.searchMatOrderCodeFltyList(searchVO);
      	
      	ComFunc comFunc = new ComFunc();
      	return comFunc.sendResult(list);
  	}
}

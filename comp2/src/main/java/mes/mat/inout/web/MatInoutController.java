package mes.mat.inout.web;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.rte.fdl.property.EgovPropertyService;
import mes.main.service.ComFunc;
import mes.main.service.GridDataVO;
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
public class MatInoutController {
	//공통함수 객체 생성
	ComFunc comFunc = new ComFunc();

	
    @Resource(name = "matInoutService")
    private MatInoutService service;
    
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

//--------------------------------------조회 페이지-------------------------------------
    
    //페이지 넘겨주기
    @RequestMapping("/matInout/matrInoutView.do")
    public String selectMatInoutList(@ModelAttribute("searchVO") MatInoutVO searchVO, 
    		ModelMap model) {

        return "mes/matInout/matrInoutView.page";
    }
    //자재입출고조회 리스트
    @RequestMapping("/ajax/readMatInout")
    @ResponseBody
    public Map<String, Object> matInout(Model model, 
    		 @ModelAttribute("searchVO") MatInoutVO searchVO) throws Exception{

    	List<?> list = service.selectMatInoutList(searchVO);
    	
    	//공통함수 객체 생성
    	ComFunc comFunc = new ComFunc();
    	return comFunc.sendResult(list);
    }
  	

    
    
    //자재코드 검색창 오픈
    @GetMapping("searchMaterialCode.do")
  	public String searchMaterialCode() {
  		
  		//모달창에 띄워줄 view페이지 전달.
  		return "mes/matInout/searchMaterialCode";
  	}
  	
  	//자재코드 결과 값 전달
  	@RequestMapping("/ajax/searchMaterial")
  	@ResponseBody
  	public Map<String, Object> searchMaterial(Model model, 
     		@ModelAttribute("searchVO") MatInoutVO searchVO) throws Exception {
  		

      	List<?> list = service.searchMaterialCodeList(searchVO);
      	
      	ComFunc comFunc = new ComFunc();
      	return comFunc.sendResult(list);
  	}
  	
    //입고업체 검색창 오픈
    @GetMapping("searchVendorCode.do")
  	public String searchVendorCode() {
  		
  		//모달창에 띄워줄 view페이지 전달.
  		return "mes/matInout/searchVendorCode";
  	}
  	
  	//입고업체 결과 값 전달
  	@RequestMapping("/ajax/searchVendor")
  	@ResponseBody
  	public Map<String, Object> searchVendor(Model model, 
     		@ModelAttribute("searchVO") MatInoutVO searchVO) throws Exception {
  		

      	List<?> list = service.searchVendorCodeList(searchVO);
      	
      	ComFunc comFunc = new ComFunc();
      	return comFunc.sendResult(list);
  	}

//--------------------------------------관리 페이지--------------------------------------    
    
  	//자재입출고 [관리] 페이지
    @RequestMapping(value="/matInout/matrInoutForm.do")
    public String selectMatInoutForm(@ModelAttribute("searchVO") MatInoutVO searchVO, 
    		ModelMap model) {

        return "mes/matInout/matrInoutForm.page";
    }
  	
  	//자재입출고 [관리] 등록 수정 삭제 
    @PutMapping("/ajax/modifyMatInout")
	@ResponseBody
	public void modifyMatInout(@RequestBody GridDataVO gd) throws Exception {
    	
		List<?> updatedList = gd.getUpdatedRows();
		List<?> createdList = gd.getCreatedRows();
		List<?> deletedList = gd.getDeletedRows();

		if (updatedList.size() != 0) {
			for (int i = 0; i < updatedList.size(); i++) {
				service.updateMatInout((LinkedHashMap) updatedList.get(i));
			}
		}
		
		if (createdList.size() != 0) {
			//전표번호 부여해야함 MAT-날짜(MMDD)-순서(서브스트링 후 붙히기)
			for (int i = 0; i < createdList.size(); i++) {
				service.insertMatInout((LinkedHashMap) createdList.get(i));
			}
		}

		if (deletedList.size() != 0)
		{
			for (int i = 0; i < deletedList.size(); i++) {
				service.deleteMatInout((LinkedHashMap) deletedList.get(i));
			}
		}
	}

    //업체검색 모달창 오픈
    @GetMapping("mes/matInout/searchVendorCode.do")
  	public String testModal() {
  		
  		//모달창에 띄워줄 view페이지 전달.
  		return "mes/matInout/searchVendorCode";
  	}
  	
  	//모달창에 결과 값 전달
  	@RequestMapping("ajax/matInout/searchVendorCode")
  	@ResponseBody
  	public Map<String, Object> searchVendorCode(Model model, 
     		@ModelAttribute("searchVO") MatInoutVO searchVO) throws Exception {
  		

      	List<?> list = service.selectMatInoutList(searchVO);
      	
      	ComFunc comFunc = new ComFunc();
      	return comFunc.sendResult(list);
  	}
  	
    //자재LOT_NO 검색창 오픈
    @GetMapping("searchMatOrderCode.do")
  	public String searchMatOrderCode() {
  		
  		//모달창에 띄워줄 view페이지 전달.
  		return "mes/matInout/searchMatOrderCode";
  	}
  	
  	//자재LOT_NO 결과 값 전달
  	@RequestMapping("mes/matInout/searchMatOrder")
  	@ResponseBody
  	public Map<String, Object> searchMatOrder(Model model, 
     		@ModelAttribute("searchVO") MatInoutVO searchVO) throws Exception {
  		

      	List<?> list = service.selectMatInoutList(searchVO);
      	
      	ComFunc comFunc = new ComFunc();
      	return comFunc.sendResult(list);
  	}

    
    

}

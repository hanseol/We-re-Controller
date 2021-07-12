package mes.qua.chk.web;

import java.util.HashMap;
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
import mes.qua.chk.service.QuaChkService;
import mes.qua.chk.service.QuaChkVO;

/**
 * @Class Name : matQuaController.java
 * @Description : matQua Controller class
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
public class QuaChkController {
	//공통함수 객체
	ComFunc comFunc = new ComFunc();

	

    @Resource(name = "quaChkService")
    private QuaChkService service;
    
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

//--------------------------------------조회 페이지-------------------------------------
    
    //페이지 넘겨주기
    @RequestMapping("/quaChk/matrQuaView.do")
    public String selectmatQuaList(@ModelAttribute("searchVO") QuaChkVO searchVO, 
    		ModelMap model) {

        return "mes/qua/quaChk/matrQuaView.page";
    }
    //자재발주조회 리스트
    @RequestMapping("/ajax/readQuaChk")
    @ResponseBody
    public Map<String, Object> matQua(Model model, 
    		 @ModelAttribute("searchVO") QuaChkVO searchVO) throws Exception{

    	List<?> list = service.selectQuaChkList(searchVO);
    	
    	//공통함수 객체 생성
    	ComFunc comFunc = new ComFunc();
    	return comFunc.sendResult(list);
    }
    
    //검사완료 리스트 조회
    @RequestMapping("/ajax/readQuaChkPass")
    @ResponseBody
    public Map<String, Object> matQuaChkPass(Model model, 
    		 @ModelAttribute("searchVO") QuaChkVO searchVO) throws Exception{

    	List<?> list = service.selectQuaChkPassList(searchVO);
    	
    	//공통함수 객체 생성
    	ComFunc comFunc = new ComFunc();
    	return comFunc.sendResult(list);
    }


//--------------------------------------관리 페이지--------------------------------------    
    
  	//자재입고검사 [관리] 페이지
    @RequestMapping("/quaChk/matrQuaForm.do")
    public String selectQuaChkForm(@ModelAttribute("searchVO") QuaChkVO searchVO, 
    		ModelMap model) {

        return "mes/qua/quaChk/matrQuaForm.page";
    }
  	
  	//자재입고검사 [관리] 등록 수정 삭제
    @PutMapping("/ajax/modifyQuaChk")
	@ResponseBody
	public Map<String, Object> modifyQuaChk(@RequestBody GridDataVO gd) throws Exception {
    	Map<String, Object> map = new HashMap<String, Object>();
		service.insertQuaChk(gd);
		
		map.put("result", true);
		
		return map;
	}
    
    //----------------------------------모달-----------------------------------------------
    //자재불량 오픈
    @GetMapping("quaFlty/searchMatFltyCode.do")
  	public String searchVendorCode() {
  		
  		//모달창에 띄워줄 view페이지 전달.
  		return "mes/mat/modal/searchMatFltyCode";
  	}
  	
  	//자재불량 결과 값 전달
  	@RequestMapping("/ajax/searchMatFlty")
  	@ResponseBody
  	public Map<String, Object> searchMatFlty(Model model, 
     		@ModelAttribute("searchVO") QuaChkVO searchVO) throws Exception {
  		

      	List<?> list = service.searchMatFltyCodeList(searchVO);
      	
      	ComFunc comFunc = new ComFunc();
      	return comFunc.sendResult(list);
  	}
  	//자재합격량불량량 결과 값 전달
  	@RequestMapping("/ajax/searchMatFltyQty")
  	@ResponseBody
  	public Map<String, Object> searchMatFltyQty(Model model, 
     		@ModelAttribute("searchVO") QuaChkVO searchVO) throws Exception {
  		

      	List<?> list = service.searchMatFltyCodeQtyList(searchVO);
      	
      	ComFunc comFunc = new ComFunc();
      	return comFunc.sendResult(list);
  	}
    
    
}

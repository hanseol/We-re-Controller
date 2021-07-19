package mes.mat.inout.web;

import java.util.HashMap;
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

import egovframework.rte.fdl.idgnr.EgovIdGnrService;
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
	
	//출고전표번호 객체 선언
	@Resource(name = "mesMatOutStatementIdGnrService")
	protected EgovIdGnrService mesMatOutStatementIdGnrService;
	
    @Resource(name = "matInoutService")
    private MatInoutService service;
    
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

//--------------------------------------조회 페이지-------------------------------------
    
    //페이지 넘겨주기
    @RequestMapping("/mat/inout/matrInoutView.do")
    public String selectMatInoutList(@ModelAttribute("searchVO") MatInoutVO searchVO, 
    		ModelMap model) {

        return "mes/mat/matInout/matrInoutView.page";
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
    //자재입출고조회 리스트
    @RequestMapping("/ajax/readMatInoutPass")
    @ResponseBody
    public Map<String, Object> matInoutPass(Model model, 
    		 @ModelAttribute("searchVO") MatInoutVO searchVO) throws Exception{

    	List<?> list = service.selectMatInoutPassList(searchVO);
    	
    	//공통함수 객체 생성
    	ComFunc comFunc = new ComFunc();
    	return comFunc.sendResult(list);
    }

//--------------------------------------관리 페이지--------------------------------------    
    
  	//자재입출고 [관리] 페이지
    @RequestMapping("/mat/inout/matrInoutForm.do")
    public String selectMatInoutForm(@ModelAttribute("searchVO") MatInoutVO searchVO, 
    		ModelMap model) {

        return "mes/mat/matInout/matrInoutForm.page";
    }
  	
  	//자재입출고 [관리] 등록 수정 삭제 
    @PutMapping("/ajax/modifyMatInout")
	@ResponseBody
	public Map<String, Object> modifyMatInout(@RequestBody GridDataVO gd) throws Exception {
    	Map<String, Object> map = new HashMap<String, Object>();
		List<?> updatedList = gd.getUpdatedRows();
		List<?> createdList = gd.getCreatedRows();
		List<?> deletedList = gd.getDeletedRows();

		if (updatedList.size() != 0) {
			for (int i = 0; i < updatedList.size(); i++) {
				service.updateMatInout((LinkedHashMap) updatedList.get(i));
			}
		}
		
		if (createdList.size() != 0) {
			for (int i = 0; i < createdList.size(); i++) {
//				String gubun = (String) ((LinkedHashMap)createdList.get(i)).get("matInoutGubun");
				((LinkedHashMap)createdList.get(i)).put("matInoutStatement", mesMatOutStatementIdGnrService.getNextStringId());
//				//전표번호 부여
//				if(gubun.equals("INOUT002")) {
//				((LinkedHashMap)createdList.get(i)).put("matInoutStatement", mesMatInStatementIdGnrService.getNextStringId());
//				}else if(gubun.equals("INOUT003")){
//					
//				}
				service.insertMatInout((LinkedHashMap) createdList.get(i));
			}
		}

		if (deletedList.size() != 0) {
			for (int i = 0; i < deletedList.size(); i++) {
				service.deleteMatInout((LinkedHashMap) deletedList.get(i));
			}
		}
		map.put("result", true);
		
		return map;
	}


//--------------------------------------모달 페이지--------------------------------------
    
    //자재코드 오픈
    @GetMapping("/mat/inout/searchMaterialCode.do")
  	public String searchMaterialCode() {
  		
  		//모달창에 띄워줄 view페이지 전달.
  		return "mes/mat/modal/searchMaterialCode";
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
  	
    //입고업체 오픈
    @GetMapping("/mat/inout/searchVendorCode.do")
  	public String searchVendorCode() {
  		
  		//모달창에 띄워줄 view페이지 전달.
  		return "mes/mat/modal/searchVendorCode";
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
  	
    //자재LOT_NO 오픈
    @GetMapping("/mat/lot/searchMatLotNo.do")
  	public String searchMaterialLotNo() {
  		
  		//모달창에 띄워줄 view페이지 전달.
  		return "mes/mat/modal/searchMaterialLotNo";
  	}
  	
  	//자재LOT_NO 결과 값 전달
  	@RequestMapping("/ajax/searchMaterialLotNo")
  	@ResponseBody
  	public Map<String, Object> searchMaterialLot(Model model, 
     		@ModelAttribute("searchVO") MatInoutVO searchVO) throws Exception {
  		

      	List<?> list = service.searchMaterialLotList(searchVO);
      	
      	ComFunc comFunc = new ComFunc();
      	return comFunc.sendResult(list);
  	}
  	
  	
    //정산테이블전용 자재LOT_NO  오픈
    @GetMapping("/mat/lot/searchMatLotNoSecond.do")
  	public String searchMaterialLotNoSecond() {
  		
  		//모달창에 띄워줄 view페이지 전달.
  		return "mes/mat/modal/searchMaterialLotNoSecond";
  	}
  	
  	//정산테이블전용 자재LOT_NO 결과 값 전달
  	@RequestMapping("/ajax/searchMaterialLotNoSecond")
  	@ResponseBody
  	public Map<String, Object> searchMaterialLotSecond(Model model, 
     		@ModelAttribute("searchVO") MatInoutVO searchVO) throws Exception {
  		

      	List<?> list = service.searchMaterialLotSecondList(searchVO);
      	
      	ComFunc comFunc = new ComFunc();
      	return comFunc.sendResult(list);
  	}


    

}

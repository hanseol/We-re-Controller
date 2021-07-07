package mes.qua.chk.web;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.rte.fdl.idgnr.EgovIdGnrService;
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

	//입고전표번호 객체
	@Resource(name = "mesMatInStatementIdGnrService")
	protected EgovIdGnrService mesMatInStatementIdGnrService;

	
    @Resource(name = "quaMaterialChkService")
    private QuaChkService service;
    
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

//--------------------------------------조회 페이지-------------------------------------
    
    //페이지 넘겨주기
    @RequestMapping("/quaChk/matrQuaView.do")
    public String selectmatQuaList(@ModelAttribute("searchVO") QuaChkVO searchVO, 
    		ModelMap model) {

        return "mes/qua/quaChk/matrQuaChkView.page";
    }
    //자재입출고조회 리스트
    @RequestMapping("/ajax/readQuaChk")
    @ResponseBody
    public Map<String, Object> matQua(Model model, 
    		 @ModelAttribute("searchVO") QuaChkVO searchVO) throws Exception{

    	List<?> list = service.selectQuaMaterialChkList(searchVO);
    	
    	//공통함수 객체 생성
    	ComFunc comFunc = new ComFunc();
    	return comFunc.sendResult(list);
    }
  	

//--------------------------------------관리 페이지--------------------------------------    
    
  	//자재입출고 [관리] 페이지
    @RequestMapping("/quaChk/matrQuaForm.do")
    public String selectQuaChkForm(@ModelAttribute("searchVO") QuaChkVO searchVO, 
    		ModelMap model) {

        return "mes/mat/quaChk/matrQuaChkForm.page";
    }
  	
  	//자재입출고 [관리] 등록 수정 삭제 
    @PutMapping("/ajax/modifyQuaChk")
	@ResponseBody
	public void modifyQuaChk(@RequestBody GridDataVO gd) throws Exception {
    	
		List<?> updatedList = gd.getUpdatedRows();
		List<?> createdList = gd.getCreatedRows();
		List<?> deletedList = gd.getDeletedRows();

		if (updatedList.size() != 0) {
			for (int i = 0; i < updatedList.size(); i++) {
				service.updateQuaMaterialChk((LinkedHashMap) updatedList.get(i));
			}
		}
		
		if (createdList.size() != 0) {
			for (int i = 0; i < createdList.size(); i++) {
				//입고전표번호 만들어서 insert맵퍼에 값 전달
				((LinkedHashMap)createdList.get(i)).put("quaMaterialStatement", mesMatInStatementIdGnrService.getNextStringId());

				service.insertQuaMaterialChk((LinkedHashMap) createdList.get(i));
			}
		}

		if (deletedList.size() != 0)
		{
			for (int i = 0; i < deletedList.size(); i++) {
				service.deleteQuaMaterialChk((LinkedHashMap) deletedList.get(i));
			}
		}
	}

}

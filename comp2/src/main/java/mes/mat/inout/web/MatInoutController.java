package mes.mat.inout.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
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
    
    //자재입출고 [조회] 페이지
    @RequestMapping(value="/matInout/matrInoutView.do")
    public String selectMatInoutList(@ModelAttribute("searchVO") MatInoutVO searchVO, 
    		ModelMap model) {

        return "mes/matInout/matrInoutView.page";
    }
    
    //자재입출고 [관리] 페이지
    @RequestMapping(value="/matInout/matrInoutForm.do")
    public String selectMatInoutForm(@ModelAttribute("searchVO") MatInoutVO searchVO, 
    		ModelMap model) {

        return "mes/matInout/matrInoutForm.page";
    }
    
    //리스트 조회
    @RequestMapping(value="/mat/inout/readMatInout")
    @ResponseBody
    public Map<String, Object> matInout(Model model, 
    		 @ModelAttribute("searchVO") MatInoutVO searchVO) throws Exception{

    	int rowSize = 0;
    	List<?> list = new ArrayList<>();
    	
    
        list = service.selectMatInoutList(searchVO);
    	
    	
    	return comFunc.sendResult(list);
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
			//전표번호 부여해야함
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

    
    

}
